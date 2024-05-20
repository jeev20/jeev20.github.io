---
layout: post
title: Linear programming 
date: 2024-05-19 15:06 +0200
categories: ["Python"]
tags: [ "linear programming", "optimization", "pulp"]
mermaid: true
published: false
---

At work I attended a presentation on an optimization problem was made by researches working in the local hospital. They were looking to minimizing staffing resources given certain variables and constraints. 

The field which studies such problems is called Linear Programming (LP). I remember studying this vaguely during my bachelors in industrial engineering, but since then I have forgotten the basics of it. 

In short, linear programming is used to find an optimal solution given the variables of the system and adhering to the constraints which define the limitations within the system. In short, a objective function is either maximized or minimized. 

---------------------------------------------

```mermaid
---
title: Components within linear programming
---
stateDiagram-v2 
direction LR
[*]--> Decision_Variables
note left of Decision_Variables
    Output influencing variables
end note
[*]--> Constraints
note left of Constraints
    Defined limitations
end note
Decision_Variables --> Objective_Functions 
note right of Objective_Functions
    Quantitatively calculable
end note
Constraints --> Objective_Functions
Objective_Functions -->Optimal_Solution:Linear Solver
note right of Optimal_Solution
    Solution given the other three components
end note
Optimal_Solution -->[*]

```

----------------------------------------------
#### Case
Consider a case of staffing a hospital. Nurses and doctors are expected to working in shifts, but as the rest of us they too may have personal commitments which have to be taken into consideration when planning for resource utilization. Some of them may be specialists in one form of care so they cannot not easily be replaced by others from the resource pool. 

Now such problems are where linear programming is most useful. 

In the above case we are trying to maximize resource utilization while considering the dynamic nature of resource availability and skills while also adhering to constraint of minimum required resources for smooth operations. 

#### Modules in python
Docplex, PluP, Pyomo and Gekko are some of the well known python modules to perform linear programming. 

Solver is independent of the python modules, as many LP solvers are openly available and the python modules have built and api over these solvers to make it easier to solve LP problems. 

#### Resources 

   Introduction to LP from [Byjus](https://byjus.com/maths/linear-programming/#components)

   Short introduction to linear programming 
   {% include embed/youtube.html id='c9D04BWvpBc' %}

   A deep dive into concepts behind linear programming 
   {% include embed/youtube.html id='E72DWgKP_1Y' %}

   {% include embed/youtube.html id='qQFAvPF2OSI' %}

   Using PulP in python
   {% include embed/youtube.html id='qa4trkLfvwQ' %}
    
## Example problems
Solving some problems without help and only understanding from videos watched

### Problem 1
*A doctor wishes to mix two types of Dishes in such a way that the vitamin contents of the mixture contain at least 8 units of vitamin A and 10 units of vitamin C. Dish 1 contains 2 units/kg of vitamin A and 1 unit/kg of vitamin C. Dish 2 contains 1 unit/kg of vitamin A and 2 units/kg of vitamin C. It costs Kr 50 per kg to purchase Dish 1 and Kr 70 per kg to purchase Dish 2. Formulate this problem as a linear programming problem to minimize the cost of such a mixture*

Formulating the above problem. Before we do that we create a table to make this easier. This [video](https://www.youtube.com/watch?v=_ewPTxICHHA&list=PLbxFfU5GKZz1Tm_9RR5M_uvdOXpJJ8LC3&index=31) was of great to understand and build an intuition. 

|           | Vitamin A (units) | Vitamin C (units) | Cost (Kr)|
|-----------|-------------|--------|---------|
|Dish 1    |   2     |     1     |   50|
|Dish 2   |    1    |     2      |  70|
|Daily need  | 8    |     10|

For simplicity `Vitamin A = x Vitamin C = y`

**Variables** `x, y daily feed in units`

**Objective function**: `f(x, y) = 50*x + 70*y` --> Minimzation problem

**Subject to constraints**:
```
Vitamin A: 2*x + 1*y >= 8
Vitamin C: 1*x + 2*y >= 10
x >=0
y >= 0
```

```python
# importing modules
import pulp   

# Creating LP problem
"""
Here we are looking to minimize the cost while getting the enough of vitamin a and c in the diet. This is therefore a minimization LP problem.
"""
vitamin_mix_lp = pulp.LpProblem("vitamin_mix_lp", pulp.LpMinimize)

# Creating LPvariables
x = pulp.LpVariable("Dish 1", lowBound=0, cat='Integer')
y = pulp.LpVariable("Dish 2", lowBound=0, cat='Integer')

# Creating Constraints: Mixture contain at least 8 units of vitamin A and 10 units of vitamin C
vitamin_mix_lp += 2*x + 1*y >=8
vitamin_mix_lp += 1*x + 2*y >= 10
vitamin_mix_lp += x >= 0
vitamin_mix_lp += y >=0

# Creating the objective function: f(x, y) = 50*x + 70*y
vitamin_mix_lp += 50*x + 70*y

# Solving the objective function
solution = vitamin_mix_lp.solve()

# Printing the results and optimal variable values
print("Status:", solution) # 1: Optimal solution exists
print("Optimal Solution Value:", vitamin_mix_lp.objective.value(), "Kr.")
for var in vitamin_mix_lp.variables():
    print(var.name, "=", var.varValue, "units")
```

*Output* from the above problem results in 2 units of dish 1 and 4 units of dish 2, which results in the minimum cost of 380 kroner while adhering to the set constraints. 

```bash
Status: 1 (optimal solution exists)
Optimal Solution Value: 380.0 Kr.
Dish_1 = 2.0 units
Dish_2 = 4.0 units
```

-------------------------

### Problem 2