##  $addToSet operator:
----------------------
It is exactly the same as the $push operator, except that it won't allow duplicates. It adds elements to the array if and only if the array does not already contain those elements. There is no effect on already existing duplicates.

Case Study:
----------- 
```javascript
db.students.insertOne({_id: 1, marks: [70, 87, 90]});
db.students.insertOne({_id: 2, marks: [90, 88, 92]});
db.students.insertOne({_id: 3, marks: [85, 100, 90]});
db.students.insertOne({_id: 4, marks: [79, 85, 80]});
db.students.insertOne({_id: 5, marks: [88, 88, 92]});
db.students.insertOne({_id: 6, marks: [95, 90, 96]});
```

eg-1: Adding Duplicate Element
------------------------------
```javascript
{_id: 5, marks: [88, 88, 92]}
```
```javascript
> db.students.update({_id: 5}, {$addToSet: {marks: 88}});
```
```javascript
storedb> db.students.update({_id: 5}, {$addToSet: {marks: 88}});
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 0,
  upsertedCount: 0
}
```
```javascript
{ _id: 5, marks: [ 88, 88, 92 ] },
```

In this case, 88 won't be added because it is already available.

eg-2: Adding Non-Duplicate Element
------------------------------------ 
```javascript
> db.students.update({_id: 5}, {$addToSet: {marks: 90}});
```
```javascript
storedb> db.students.update({_id: 5}, {$addToSet: {marks: 90}});
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```
```javascript
storedb> db.students.find();
[
  { _id: 1, marks: [ 70, 87, 90 ] },
  { _id: 2, marks: [ 90, 88, 92 ] },
  { _id: 3, marks: [ 85, 100, 90 ] },
  { _id: 4, marks: [ 79, 85, 80 ] },
  { _id: 5, marks: [ 88, 88, 92, 90 ] },
  { _id: 6, marks: [ 95, 90, 96 ] }
]
```

eg-3: Adding Multiple Elements:
-------------------------------
To add multiple elements, we have to use the $each modifier.  

```javascript
> db.students.update({_id: 5}, {$addToSet: {marks: {$each: [10, 20, 88, 90, 30]}}});
```

```javascript
{
  _id: 5,
  marks: [
    88, 88, 92, 90,
    10, 20, 30
  ]
}
```

Note:
- In the case of the $push operator, order terminology is applicable. 

- Hence, we can use $position, $sort, and $slice modifiers. However, in the case of the $addToSet operator, order terminology is not applicable. 

- Thus, we cannot use $position, $sort, or $slice modifiers. The $each modifier is applicable for both $push and $addToSet operators.
```


