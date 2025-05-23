---
layout: post
title: Searching and validating Norwegian Identity Numbers
date: 2025-04-11 10:06 +0200
categories: ["misc"]
tags: ["norwegianid"]
mermaid: true
published: true
---

Norwegian Identity Number (NiN) is a interesting unique identifier. In this post, I would like to show how to parse an input text and validate a NiN using Python. 

## Background

An NiN is a 11 digit number allocated to Norwegian citizens and residents with the following properties
* The first 6 digits signify a date 
* The 7th, 8th and the 9th digit signify a individual number specific to each person 
* The 9th digit is special as it also encodes the two biological gender of the person (male or female)
* The fascinating part is the last two digits which are known as control digits, which is mathematically determined

Let's continue with the same example NiN used in the reference article from [matematikk.no](https://www.matematikk.org/artikkel.html?tid=64299) and build a visual representation of a NiN.


```mermaid


graph TD
subgraph NiN[02016126007]
end

NiN -->|Birthday| BirthDay(020161)
NiN -->|Personal number| Personnummer(26007)

BirthDay -->|BirthDate-d1d2| Date(02)
BirthDay -->|BirthMonth-m1m2| Month(01)
BirthDay -->|BirthYear-y1y2| Year(61)

Personnummer -->|Individual number<br>Decade specific| IndividualNumber(260)
IndividualNumber -->|RandomlyGenerated<br>DependentOnNumberOfBirthsonTheDay|RandomlyGenerated(26)
IndividualNumber -->|GenderEncoding<br>Even=Women=0,2,4,6,8<br>Odd=Men=1,3,5,7,9|Gender(0)
Personnummer -->|Control digits| ControlDigits(07)

ControlDigits -->|"sum(dotproduct)MOD11<br>if result==0:<br>c1=0<br>else:<br>c1=11-result"| digit10[0]
ControlDigits -->|"sum(dotproduct)MOD11<br>if result==0:<br>c2=0<br>else:<br>c2=11-result"| digit11[7]

```

### Specimen calculation

The two multiplier list used are 

c1_multipliers = [3, 7, 6, 1, 8, 9, 4, 5, 2]

c2_multipliers = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2]

Lets represent the input string "02016126007" as an array/list of int

NiN = [0,2,0,1,6,1,2,6,0,0,7]

#### Calculating c1
remainder = DotProduct(NiN[0:9],c1_multipliers)%11

c1 = 0 if remainder == 0 else 11 - remainder

**c1 = 0**

#### Calculating c2
remainder = DotProduct(NiN[0:10],c2_multipliers)%11

c2 = 0 if remainder == 0 else 11 - remainder

**c2 = 7**

In the case of 020161260**07**, we see that the last 2 digits match with c1c2(**07**). Hence this is a valid NiN! 



## Building a parser

> To make it easier to read sometimes the NiN can also be written with a space in between the date and individual numbers like so 
020161 26007. Therefore the parsing logic we build needs to consider this variation as well.
{: .prompt-info }

To check if a text string contains one or more valid NiN's we can generate three simple methods. 
### 1. Check the first 6 digits are valid 

```python
def is_valid_date(date_str) -> bool:
    """
    Validates whether a given string follows the specified date format.

    This function checks if `date_str` conforms to the 'DDMMYY' format and ensures the date is valid.
    It attempts to parse the string using Python's datetime library and returns True if successful; otherwise,
    it catches a ValueError exception and returns False.

    Args:
        date_str (str): The date string to be validated.

    Returns:
        bool: True if `date_str` matches the 'DDMMYY' format and is a valid date, False otherwise.

    Example:
        is_valid = is_valid_date("310323")
        # This will return True since "31-03-2023" is a valid date in 'DDMMYY' format.

    Note:
        - The function assumes that `date_str` should be exactly 6 characters long to match the 'DDMMYY' format.
        - Checks are performed for invalid dates like "310429" (April 30th does not exist).
    """
    from datetime import datetime 

    if len(date_str) != 6:
        return False

    try:
        # Parse the date string
        date_obj = datetime.strptime(date_str, "%d%m%y")

        # Check if the day is valid for the given month and year
        if date_obj.day != int(date_str[:2]) or date_obj.month != int(date_str[2:4]):
            return False

        return True
    except ValueError:
        return False
```

### 2. Check if the control numbers are valid in the input string


```python
def check_nin_control_numbers(text: str) -> bool:
    """
    Validates a Norwegian National Identification Number (NIN) based on control digits.

    This function checks the validity of a Norwegian National Identification Number (NIN) by calculating
    two control digits using predefined multipliers and verifying them against the provided NIN.

    Args:
        text (str): A string representing the NIN to be validated. The NIN should be 11 digits long.

    Returns:
        bool: True if the NIN is valid, False otherwise.

    Example:
        >>> check_nin_control_numbers("01010112345")
        True
    """
    if len(text) != 11:
        return False

    def calculate_control_digit(digits, multipliers):
        total = sum(int(d) * m for d, m in zip(digits, multipliers))
        remainder = total % 11
        return 0 if remainder == 0 else 11 - remainder

    k1_multipliers = [3, 7, 6, 1, 8, 9, 4, 5, 2]
    k2_multipliers = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2]

    k1 = calculate_control_digit(text[:9], k1_multipliers)
    k2 = calculate_control_digit(text[:9] + str(k1), k2_multipliers)

    return text[9:] == f"{k1}{k2}"

```

### 3. Using regex to extract potential 11 digit numbers (with or without spaces after 6th digit) and we invoke the above to methods 

```python
def find_norwegian_ss_number(text: str) -> list[str]:
    """
    Finds and extracts Norwegian Social Security Numbers (SSNs) from a given text.

    This method searches through the input text to identify patterns that match
    possible formats of Norwegian SSNs. The recognized formats include:
    - Continuous 11-digit numbers (`ddddddmmmyyy`),
    - Split format with space between day/month and year (`dddd dd mmmyyy`), and
    - An alternative split format used in some historical contexts (`dddd mm yyyy`).

    It returns a list of extracted SSNs, where all spaces are removed for consistency.

    Parameters:
    text (str): The input string from which Norwegian SSNs will be extracted.
                This can include any textual content that might contain the target patterns.

    Returns:
    list: A list of strings, each representing an identified and formatted SSN with
        no internal spaces. If no valid SSNs are found, returns an empty list.

    Example:
    >>> text = "Some example numbers 01010112345, 0101 01 012345, and 0101 02 1987."
    >>> find_norwegian_ss_number(text)
    ['01010112345', '01010123456', '0101021987']
    """
    pattern = re.compile(r"\b(\d{6} \d{5}|\d{11}|\d{4} \d{2} \d{5})\b")
    matches = pattern.findall(text)

    results = []
    for match in matches:
        if len(match) > 0:
            # Join the match parts (in case of split formats) into a continuous string
            formatted_match = "".join(filter(None, match))
            first_six_digits = formatted_match[:6]
            if is_valid_date(
                first_six_digits
            ) and check_ss_control_numbers(formatted_match):
                results.append(formatted_match)
    return results
```


> Although the above approach works currently, by the year 2040 the current number series can no longer generate unique numbers. To counter this, a set of alterations have been proposed by the tax authorities and will be implemented by the year 2032.
{: .prompt-warning }

> The new number series will still be 11 digits long
> 
> The gender encoding will be removed
>
> The information regarding the person's birthday in the NiN will also be removed
>
> All previously valid NiN's will remain valid
>
> All organizations using NiN's in their systems will need to adopt newer validation methods which support both the older and the newer series of NiN's as mentioned by [skatteetaten](https://skatteetaten.github.io/folkeregisteret-api-dokumentasjon/nytt-fodselsnummer-fra-2032/)
{: .prompt-info }








## Resources
1. [Store norske leksikon](https://snl.no/f%C3%B8dselsnummer)

2. [Er fødselsnummeret gyldig?](https://www.matematikk.org/artikkel.html?tid=64299)  

3. [Dagens system med individ- og kontrollnummer](https://www.matematikk.org/artikkel.html?tid=64296&within_tid=64294)
  
4. [Nytt fødselsnummer fra 2032](https://skatteetaten.github.io/folkeregisteret-api-dokumentasjon/nytt-fodselsnummer-fra-2032/) 