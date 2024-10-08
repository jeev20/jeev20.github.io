---
layout: post
title: Notes on time series analysis
date: 2024-09-17 13:44 +0200
categories: ["data science"]
tags: ["time series"]
mermaid: true
published: true
---

## A mindmap of time series analysis

```mermaid
mindmap
  root((Time Series Analysis))
    Databases
        TimeScaleDB
        InfluxDB
    Python tools
        Altair
        Pandas
        DuckDB
        Polars
        Scipy
        Gekko
        Matplotlib
    Core concepts
        Trend
        Cycle
        Variation
        Statistical movements
        Stationary and non-stationary
        Seasonality
        Auto-Correlation
    Forcasting
        Auto Regressive Integrated Moving Average - ARIMA
        Exponential smoothing

    
```

## Core concepts explained visually

#### Time series 
Observed values of the same variable collected at regular time intervals. 

In the below example, revenue is the variable observed with a monthly time intervals given a year.

```mermaid
---
config:
    xyChart:
        width: 700
        height: 350
    themeVariables:
        xyChart:
            titleColor: "#ff0000"
---
xychart-beta
    title "Sales revenue"
    x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
    y-axis "Revenue (in $)" 4000 --> 13000
    line [5000, 6200, 7900, 8800, 10300, 11500, 12200, 11600, 10800, 10300, 9000, 8200]
```

### Time series analysis
The method of analyzing a timestamped dataset to observe/forecast/predict past and future values for the observed variable. Hence this analysis can be used as a decision support system. 


#### Trend
Positive secular trend

```mermaid
---
config:
    xyChart:
        width: 700
        height: 350
    themeVariables:
        xyChart:
            titleColor: "#ff0000"
---
xychart-beta
    title "Sales revenue (positive secular trend)"
    x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
    y-axis "Revenue (in $)" 4000 --> 13000
    line [5000, 5200, 6100, 5900, 6800, 7500, 8200, 7900, 8600, 8400, 9100, 9500]
```



Negative secular trend

```mermaid
---
config:
    xyChart:
        width: 700
        height: 350
    themeVariables:
        xyChart:
            titleColor: "#ff0000"
---
xychart-beta
    title "Sales revenue (negative secular trend)"
    x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
    y-axis "Revenue (in $)" 4000 --> 20000
    line [14000, 13600, 13900, 13200, 13500, 12800, 13100, 12500, 12700, 12100, 11800, 11500]
```

#### Seasonality
Time series data can change depending on the seasons/seasonal pattern.

Seasonal positive secular trend 

```mermaid
---
config:
    xyChart:
        width: 700
        height: 350
    themeVariables:
        xyChart:
            titleColor: "#ff0000"
---
xychart-beta
    title "Sales revenue (seasonal postive secular trend)"
    x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
    y-axis "Revenue (in $)" 4000 --> 20000
    line [14000, 13600, 14800, 14200, 15100, 15600, 15300, 14900, 15800, 15400, 15900, 16200]
```

Seasonal negative secular trend 

```mermaid
---
config:
    xyChart:
        width: 700
        height: 350
    themeVariables:
        xyChart:
            titleColor: "#ff0000"
---
xychart-beta
    title "Sales revenue (seasonal negative secular trend)"
    x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
    y-axis "Revenue (in $)" 4000 --> 20000
   line [14000, 13200, 13900, 12800, 13500, 14100, 12600, 13200, 13800, 12400, 12900, 13300]
```

#### Cyclic

```mermaid
---
config:
    xyChart:
        width: 700
        height: 350
    themeVariables:
        xyChart:
            titleColor: "#ff0000"
---
xychart-beta
    title "Sales revenue (Cyclic trend)"
    x-axis [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
    y-axis "Revenue (in $)" 4000 --> 20000
    line [10000, 10800, 11900, 13200, 14300, 15100, 15500, 15400, 14800, 13900, 12800, 11700]
```

## Resources 
Here are some of the resources which helped me learn the basic concepts of time series analysis with no specific order.

 
   Introduction to time series analysis 
   {% include embed/youtube.html id='GE3JOFwTWVM' %}

   Lecture on time series analysis 
   {% include embed/youtube.html id='Prpu_U5tKkE' %}

   Patterns and trends in time series plots
   {% include embed/youtube.html id='ca0rDWo7IpI' %}


When I learn an interesting aspect of time series analysis, I will update this post. For now, time series analysis was fun learning. I have barely scratched the surface here. 

More fun to be had!