# MongoDB Aggregation Pipeline

## Overview
- Aggregation Pipeline is composed of multiple stages executed sequentially
- Each stage's output becomes the input for the next stage
- Pipeline takes a collection as input and provides aggregated results in required format

## Implementation Structure
```javascript
db.collection.aggregate([
    {stage-1},
    {stage-2},
    {stage-3},
    {stage-4},
    {stage-5}
    ...
])
```

## Characteristics
- Stages are executed one by one
- The output of previous stage becomes input to next stage
- Pipeline processes collection data and returns aggregated results

## Pipeline Stages
### 2. $sort stage:
- It sorts all input documents and returns them to the pipeline in sorted order

## Documentation Note
- Explore as many stages as possible in the documentation
- Reference: Operators ---> Aggregation Pipeline stages

## MongoDB $sort Stage Details

### Functionality
- Sorts all input documents and returns them to the pipeline in sorted order

### Syntax
```javascript
{ $sort: { <field1>: <sort order>, <field2>: <sort order> ... } }
```

### Sort Order Values
- 1 ---> Ascending Order
- -1 ---> Descending Order

### Example
Finding citywise sum of salaries and printing based on descending order of totalSalary:

```javascript
db.employees.aggregate([
  { $group: {_id:"$eaddr", totalSalary:{$sum:"$esal"}} }, 
  { $sort:{totalSalary: -1}}
])
```

### Example Output
```javascript
[
  { _id: 'Delhi', totalSalary: 11000 },
  { _id: 'Mumbai', totalSalary: 10000 },
  { _id: 'Chennai', totalSalary: 5000 },
  { _id: 'Hyderabad', totalSalary: 2000 }
]
```