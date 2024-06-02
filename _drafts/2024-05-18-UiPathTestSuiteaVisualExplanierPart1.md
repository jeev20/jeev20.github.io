---
layout: post
title: UiPath Test Suite a Visual Explainer - Part 1 
date: 2024-05-18 20:57 +0200
categories: ["UiPath"]
tags: ["UiPath test suite", "UiPath test manager"]
mermaid: true
published: false
---

In the last couple of years UiPath's test suite has been maturing and expanding on its user base.  

This series of posts will explain the UiPath test suite offering in a visual manner. 


## UiPath test automation development sequence
```mermaid

---
title: UiPath Test Case Development Sequence Diagram
---

sequenceDiagram
Test Responsible->>+Test Automation Developer:Provides test requirements on
Test Automation Developer->>+UiPath Studio:Develops on
UiPath Studio->>+UiPath Orchestrator: Publishes test cases
UiPath Orchestrator->>+UiPath Test Manager:Provides list of test sets
UiPath Orchestrator  ->>+ UiPath Test Robot:Triggers a test set
UiPath Test Manager  ->>+ UiPath Test Robot:Triggers a test set

UiPath Test Robot ->>- UiPath Orchestrator :Returns test results

UiPath Orchestrator  ->>- Test Responsible:Presents test results

```




------------------------------------------

## UiPath test suite overall flow diagram
```mermaid

---
title: UiPath Test Suite Overall Flow Diagram
---

flowchart TD
    A[UiPath Studio]-->|Publishes test cases via CI/CD|B[UiPath Orchestrator]
    B[1. UiPath Orchestrator] <-->|Sync of test sets and execution details| C[2. UiPath Test Manager]
    C --> |Triggering Test Sets|D[UiPath Testing Robot]
    B-->|Triggering test sets| D
    
    D-->|Results from test run|B
    E[3. External Application]-->|Triggering test sets| D
    D-->|Results from test run|E
```


## UiPath test automation project linking
```mermaid
---
title: UiPath test automation project linking
---

flowchart TD
    A[UiPath Studio]-->|Connect test manager|B[UiPath Test Manager]
    B -->|Access and link test case and requirements| A


```

## UiPath individual test case recommended structure

```mermaid
---
title: UiPath individual test case recommended structure
---

flowchart TB
    subgraph Given
    Input_Data
    end
    subgraph When
    Scenarios
    end
    subgraph Then
    Assertions
    end
    Given --> When
    When --> Then

    subgraph Given1
    Input_Data1
    end
    subgraph When1
    Test_Logic
    end
    subgraph Then1
    Assertions1
    end
    Given1 --> When1
    When1 --> TakeScreenshot
    TakeScreenshot --> Then1
```



