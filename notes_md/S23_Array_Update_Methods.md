## Updating documents based on conditions
---
**Syntax:**
```bash
db.collection.updateMany(
    { filter },
    { $set: { field: value } },
    { arrayFilters: [ { condition } ] }
);
```

### Dropping the `students` collection
```shell
db.students.drop()
```

## Inserting data
```shell
db.students.insertOne({_id: 1, marks: [70, 87, 90, 30, 40]});   
db.students.insertOne({_id: 2, marks: [90, 88, 92, 110, 45]});   
db.students.insertOne({_id: 3, marks: [85, 100, 90, 76, 58]});   
db.students.insertOne({_id: 4, marks: [79, 85, 80, 89, 56]});   
db.students.insertOne({_id: 5, marks: [88, 88, 92, 45, 23]});   
db.students.insertOne({_id: 6, marks: [95, 90, 96, 92, 95]}); 
```

### Update marks based on ranges
The following query updates the marks:
- Marks in the range 71 to 80 will become 80.
- Marks in the range 81 to 90 will become 90.
- Marks in the range 91 to 100 will become 100.

```shell
db.students.updateMany({}, {
    $set: {
        "marks.$[e1]": 80,
        "marks.$[e2]": 90,
        "marks.$[e3]": 100
    }
}, {
    arrayFilters: [
        { $and: [{"e1": {$gt: 70}}, {"e1": {$lte: 80}}] },
        { $and: [{"e2": {$gt: 80}}, {"e2": {$lte: 90}}] },
        { $and: [{"e3": {$gt: 90}}, {"e3": {$lte: 100}}] }
    ]
});

#Another way without using $and operator
db.students.updateMany(  
    {},  
    {  
        $set: {  
            "marks.$[e1]": 80,  
            "marks.$[e2]": 90,  
            "marks.$[e3]": 100  
        }  
    },  
    {  
        arrayFilters: [  
            { "e1": { $gt: 70, $lte: 80 } },  
            { "e2": { $gt: 80, $lte: 90 } },  
            { "e3": { $gt: 90, $lte: 100 } }  
        ]  
    }  
);
```

#### Output:
```shell
storedb> db.students.find()
[
  { _id: 1, marks: [ 70, 90, 90, 30, 40 ] },
  { _id: 2, marks: [ 90, 90, 100, 110, 45 ] },
  { _id: 3, marks: [ 90, 100, 90, 80, 58 ] },
  { _id: 4, marks: [ 80, 90, 80, 90, 56 ] },
  { _id: 5, marks: [ 90, 90, 100, 45, 23 ] },
  { _id: 6, marks: [ 100, 90, 100, 100, 100 ] }
]
```

## $push operation:
We can use `$push` to add elements to an array.

####  Using `$push` to add an element to an array
---
**Syntax:**
```bash
db.collection.update(
    { filter },
    { $push: { arrayField: value } }
)
```

### Adding a single element
```shell
> db.students.update({_id:1}, {$push: {marks: 35}})
```
Updated record:
```shell
{ _id: 1, marks: [ 70, 90, 90, 30, 40, 35 ] },
```

### Adding multiple elements
Attempting to add multiple elements at once:
```shell
> db.students.update({_id:1}, {$push: {marks: 36, marks: 37, marks: 38}})
```
Only one element is added because duplicate keys are not allowed.

To add multiple elements correctly:
```shell
> db.students.update({_id:1}, {$push: {marks: {$each: [42,43,44]}}})
```

### Using `$position` modifier
You can control where elements are added by using `$position`. Example of adding an element at the beginning:
```shell
> db.students.update(
    {_id: 7},
    {
        $push: {
            "marks": {
                $each: [50],
                $position: 0
            }
        }
    }
);
```
Record:
```shell
{ _id: 7, marks: [ 50, 10, 20, 60, 30, 40 ] }
```

### Adding elements using negative indices
Negative indices add elements starting from the end of the array. Example:
```shell
> db.students.update(           
    {_id: 7},    
    {       
        $push: {          
            marks: {  
                $each: [70],       
                $position: -1  
            }    
        } 
    }
);
```

Updated record:
```shell
{ _id: 7, marks: [ 50, 10, 20, 60, 30, 80, 70, 40 ] }
```

### Adding multiple elements with a negative index:
```shell
> db.students.update(
    {_id: 7},
    {
        $push: {
            marks: {
                $each: [1, 2, 3],
                $position: -3
            }
        }
    }
);
```

Final updated record:
```shell
{
    _id: 7,
    marks: [
      50, 10, 20, 60, 30,
       1,  2,  3, 80, 70,
      40
    ]
}
```



### 3. Using `$push` with `$each` to add multiple values to an array:
```shell
db.collection.update(
    { filter },
    { $push: { arrayField: { $each: [value1, value2, ...] } } }
)
```

### 4. Using `$push` with `$position` to insert at a specific index:
```shell
db.collection.update(
    { filter },
    { $push: { arrayField: { $each: [value1], $position: index } } }
)
```

### 5. Using negative index with `$position` in `$push`:
```shell
db.collection.update(
    { filter },
    { $push: { arrayField: { $each: [value1], $position: -index } } }
)
```
