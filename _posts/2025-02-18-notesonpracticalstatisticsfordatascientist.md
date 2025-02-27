---
layout: post
title: Notes on Practical Statistics for Data Scientist 📗
date: 2025-02-18 09:22 +0100
categories: ["datascience", "fundamentals"]
tags: ["notes"]
mermaid: true
published: false
---

This is my personal notes of the book [Practical Statistics for Data Scientists - 50+ Essential Concepts Using R and Python by Peter Bruce, Andrew Bruce, Peter Gedeck.](#Bruce-Bruce-Gedeck-2020). I will update this post, as I study and digest the contents of the book.


## Chapter 1 - Exploratory Data Analysis 

John W. Tukey established the field of exploratory data analysis through his 1977 publication [exploratory data analysis](#john-tukey-1977), in which he introduced methods to explore a dataset by using plots and summary statistics (mean, median etc.). Later in 2015, one of Tukey's former undergraduate student David Donoho published a summary article [50 years of Data Science](#david-donoho-2015) showing the genesis and developments of data science as a field.


* Before analyzing the data it is important to identify the type of data to be studied. 
* Type of data can influence the kind of data analysis methods which can be used to explore the data. 

The figure below provides the taxonomy of data types. 
```mermaid
mindmap
  root((Data types))
    Numeric 
        Continuous (Continuous - Data that can contain any value in an interval)
        Discrete (Discrete - Data that can contain only integer values)
    Categorical
        Binary (Binary - Data that contain just two categories )
        Ordinal (Ordinal - Data that is explicitly ordered)

```

#### Ordinal data 
The interesting data type above is the ordinal data type where the order of the data is important. Here is an example of ordinal data type using sklearn. 

```python
from sklearn.preprocessing import OrdinalEncoder
enc = OrdinalEncoder()
X = [['Male', 1], ['Female', 3], ['Female', 2]]
enc.fit(X)
enc.categories_
```
`[array(['Female', 'Male'], dtype=object), array([1, 2, 3], dtype=object)]`

```python
enc.transform([['Female', 3], ['Male', 1]])
```
`array([[0., 2.],[1., 0.]])`


Explanation of `enc.transform`
First sample: `['Female', 3]`

    Gender column: 'Female' is the first category in enc.categories_ → encoded as 0
    Number column: 3 is the third category in enc.categories_[1] → encoded as 2
    Result: [0., 2.]

Second sample: `['Male', 1]`

    Gender column: 'Male' is the second category → encoded as 1
    Number column: 1 is the first category → encoded as 0
    Result: [1., 0.]


```python
enc.inverse_transform([[1, 1], [0, 2]])
```
`array([['Male', 2],['Female', 3]], dtype=object)`


### Rectangular data
Typically analysis in data science focuses on rectangular data. It is a two-dimensional matrix containing records in form of rows and features/variables in form of columns. Rectangular data is usually the result of some preprocessing of unstructured data. Following are the key terms in rectangular data. 


```mermaid
mindmap
  root((Rectangular data))
    Dataframe 
        A basic data structure used in statistical and machine learning models
    Feature
        Each column within a table is referred to as a feature
    Outcome
        The dependent variable. Output variable which is dependent on one or many features. Also called target, response, output. 
    Records
        Each row in a table. Can be defined as singular case,  scenario, observation, pattern or sample
```




### Related literature 
* Jon Tukey : [Exploratory Data Analysis](https://archive.org/details/exploratorydataa0000tuke_7616)  <a name="john-tukey-1977"></a>

* David Donoho : [50 years of Data Science](https://courses.csail.mit.edu/18.337/2015/docs/50YearsDataScience.pdf) <a name="david-donoho-2015"></a>

* Bruce, P., Bruce, A., & Gedeck, P. (2020). [Practical statistics for data scientists: 50+ essential concepts using R and Python](https://books.google.no/books?hl=no&lr=&id=k2XcDwAAQBAJ&oi=fnd&pg=PP1&dq=9781492072942&ots=dEKcnlVmx1&sig=A4W7tK5Um6BTbuzr3_gOvVinDRg&redir_esc=y#v=onepage&q=9781492072942&f=false). O'Reilly Media. <a name="Bruce-Bruce-Gedeck-2020"></a>