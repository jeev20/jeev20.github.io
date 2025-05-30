---
layout: post
title: Notes on Practical Statistics for Data Scientists 📗
date: 2025-04-15 23:00m +0100
categories: ["datascience", "fundamentals"]
tags: ["notes"]
mermaid: true
published: true
math: true
---

This is my personal notes of the book [Practical Statistics for Data Scientists - 50+ Essential Concepts Using R and Python by Peter Bruce, Andrew Bruce, Peter Gedeck.](https://books.google.no/books?hl=no&lr=&id=k2XcDwAAQBAJ&oi=fnd&pg=PP1&dq=9781492072942&ots=dEKcnlVmx1&sig=A4W7tK5Um6BTbuzr3_gOvVinDRg&redir_esc=y#v=onepage&q=9781492072942&f=false) I will update this post, as I study and digest the contents of this book.


## Chapter 1 - Exploratory Data Analysis 

John W. Tukey established the field of exploratory data analysis through his 1977 publication [exploratory data analysis](https://archive.org/details/exploratorydataa0000tuke_7616), in which he introduced methods to explore a dataset by using plots and summary statistics (mean, median etc.). Later in 2015, one of Tukey's former undergraduate student David Donoho published a summary article [50 years of Data Science](https://courses.csail.mit.edu/18.337/2015/docs/50YearsDataScience.pdf) showing the genesis and developments of data science as a field.


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



### Non rectangular data structures

* **Time Series data** records sequential measurements of a same variable with time. This kind of data is used to create statistical forecasting models. An example is a IOT sensor capturing temperature data every 2 minutes perpetually. Such data structures always need to include a time at which the record was captured. 
  
* **Spatial data** can be used to create location based analytics. The object under observation can be for example a house or a point of interest in a map and its spatial coordinates. 
  
* **Graph/ Network** are used to represent abstract relationships between the object under observation. An example can be a social network of a person showing how many contacts or friends that person has and how often he/she interacts with them. These types of data is useful in recommender systems and optimization problems. 

All these three can also be combined in a single use case. For example, Google maps can store spatial data in a time series manner for a person and include a graph/ network data on how the user interacts with other spatial objects (shops, landmarks) when they travel 60 kms away from their home. 


> **Difference in terminologies**
> 
> Statisticians use **predicator variables** to predict a response or **dependent variable** and data scientist use **features** to predit a **target** 
>
> The term **sample** to a computer scientist signifies a single row while a **sample** to a statistician means a collection of rows.
>
> Graph in statistics can mean plots or visualization and not just connections of entities as it is in computer science or information technology.
{: .prompt-info }

### Estimates of location

```mermaid
mindmap
  root((Estimates of location))
    Mean 
        Sum of all observations divided by total number of observations. Also known as **average**
    Trimmed mean
        By removing the first n and the last n observations from a sorted set of observations, trimmed mean can then be calculated on the remaining observations divided by the total number of remaining observations. This helps us eliminate very high or very low values in the dataset. This can also result in a trimmed mean, which is closer to the median value.
    Weighter mean
        Sum of all observations multiplied by corresponding weights and divided by sum of the weights. Also known as **weighted average**
    Median
        The middle most observation in the ascendingly sorted dataset. Also known as 50th percentile and a robust estimate of location.
    Weighted median
        The value such that one-half of the sum of the weights lies below or above the sorted data
    Percentile
        The value which signifies the percentage of data which lies below or equal to a given data value. Can also be called as quantile.
    Robust
        Not sensitive to extreme observations
    Outlier
        Observation/s which are located in extreme ranges when compared with most of the observations
```


$$
\begin{equation}
  Mean = \bar{x}= \frac{\sum_{i=1}^n x_i}{n} 
  \label{eq:mean}
\end{equation}
$$

$$
\begin{equation}
  TrimmedMean = \bar{x}= \frac{\sum_{i=p+1}^{n-p} x_i}{n - 2p} 
  \label{eq:trimmedmean}
\end{equation}
$$


$$
\begin{equation}
  WeightedMean = \bar{x}_w= \frac{\sum_{i=1}^{n} w_i*x_i}{\sum_{i=1}^{n} w_i} 
  \label{eq:weightedmean}
\end{equation}
$$


> **Difference in terminologies**
> 
> Datascientist measure and statisticians estimates. Statisticians account for uncertainities in the analysis whereas concrete business objectives are the focus for datascientists.
{: .prompt-info }

```python
import pandas as pd
from scipy.stats import trim_mean
import numpy as np
import wquantiles

df = pd.read_csv("https://raw.githubusercontent.com/gedeck/practical-statistics-for-data-scientists/refs/heads/master/data/state.csv")

df_mean = df["Population"].mean()
df_median = df["Population"].median()
trimmed_mean = trim_mean(df["Population"], 0.1)
weighted_mean = np.average(df["Murder.Rate"],weights=df["Population"])
weighted_median = wquantiles.median(df["Murder.Rate"],weights=df["Population"])
```

### Estimates of variability
Variability (aka dispersion) is the second dimension of summarizing a feature. The first one is **Location**. Dispersion measures if the data values are tightly clustered or spread out. 

```mermaid
mindmap
  root((Estimates of variability))
    Deviations 
        The difference between the observed values and the estimates of locations. Also known as residuals or errors. 
    Variance
        The sum of squared deviations from the mean divided by n-1 where n is the number of observations. Also known as mean-squared-error
    Standard deviation
        The square root of variance
    Mean absolute deviation
        The absolute values of deviations from the mean. Also known as L1 norm or Manhattan norm
    Median absolute deviation from the median
        The median absolute values of the deviations from the median
    Range
        The difference between the largest and the smallest observations in the data set
    Order statistics
        Metrics based on sorted data from smallest ti biggest. Also known as ranks. 
    Interquartile range
        The difference between the 75th percentile and 25th percentile

```



## Related literature 
* Jon Tukey : [Exploratory Data Analysis](https://archive.org/details/exploratorydataa0000tuke_7616)  

* David Donoho : [50 years of Data Science](https://courses.csail.mit.edu/18.337/2015/docs/50YearsDataScience.pdf) 

* Bruce, P., Bruce, A., & Gedeck, P. (2020). [Practical statistics for data scientists: 50+ essential concepts using R and Python](https://books.google.no/books?hl=no&lr=&id=k2XcDwAAQBAJ&oi=fnd&pg=PP1&dq=9781492072942&ots=dEKcnlVmx1&sig=A4W7tK5Um6BTbuzr3_gOvVinDRg&redir_esc=y#v=onepage&q=9781492072942&f=false). O'Reilly Media.
