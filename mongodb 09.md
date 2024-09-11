
## Logical Query Operators

## $or, $nor, $and, $not

### $or operator:
`$or` performs logical OR operation on an array of two or more expressions (conditions) and selects documents that satisfy at least one of the expressions (conditions).

Syntax: `{$or: [{expression1}, {expression2}, {expression3},...]}`

Q1. Select all documents where either no_of_reviews > 3 or tags contains programming element?

```javascript
c1: {no_of_reviews: {$gt:3}}
c3: {tags: "programming"}

db.books.find({$or: [{no_of_reviews: {$gt:3}}, {tags: "programming"}]})
```

Q2. Select all documents where either no_of_reviews is less than 3 or downloadable is true author profile contains at least 2 books

```javascript
c1: {no_of_reviews: {$lt:3}}
c2: {downloadable: true}
c3: {"author.profile.books": {$gte: 2}}

db.books.find({$or : [ {no_of_reviews: {$lt:3}}, {downloadable: true}, {"author.profile.books": {$gte: 2}}]})
```

### $nor operator:

It is the inverse of $or operator
- $or --> At least one condition satisfied
- $nor --> Neither condition satisfied i.e., all conditions fail

`$nor` performs a logical NOR operation on an array of one or more expressions (conditions) and selects the documents that fail all query expressions

Example:
```javascript
c1: {no_of_reviews:{$gt: 3}}
c2: {downloadable: true}

db.books.find({$nor: [ {no_of_reviews:{$gt: 3}}, {downloadable: true}]})
```

It will select all documents where:
1. The no_of_reviews is less than or equal to 3 (i.e., not greater than 3)
2. downloadable is false
3. document does not contain no_of_reviews and downloadable fields

Note: $or + $nor = total no of documents

```javascript
db.books.find({$nor: [ {no_of_reviews:{$gt: 3}}, {downloadable: true}]}).count()

db.books.find({$or: [ {no_of_reviews:{$gt: 3}}, {downloadable: true}]}).count()

db.books.find().count()
```

### $and operator:
`$and` performs logical AND operation on an array of one or more expressions (conditions) and selects documents that satisfy all expressions (conditions) in the array i.e., all conditions must be satisfied.

Syntax: `{$and: [{expression1}, {expression2}, {expression3},...]}`

Q. Select all documents where the no_of_reviews is greater than or equal to 25 and downloadable true

```javascript
db.books.find({$and: [{no_of_reviews: {$gte: 25}}, {downloadable: true}]})
```

 **Student.json**

```json
[
  {"name": "Anya Patel", "marks": 85},
  {"name": "Ben Lee", "marks": 92},
  {"name": "Chen Li", "marks": 78},
  {"name": "David Johnson", "marks": 95},
  {"name": "Emily Kim", "marks": 88},
  {"name": "Frank Rodriguez", "marks": 75},
  {"name": "Grace Tanaka", "marks": 90},
  {"name": "Hassan Ali", "marks": 82},
  {"name": "Ivan Ivanov", "marks": 97},
  {"name": "Jacob Cohen", "marks": 80},
  {"name": "Kate Müller", "marks": 93},
  {"name": "Leo Wang", "marks": 87},
  {"name": "Maria Rodriguez", "marks": 76},
  {"name": "Nikhil Gupta", "marks": 91},
  {"name": "Olivia Chen", "marks": 84},
  {"name": "Paul Smith", "marks": 96},
  {"name": "Quinn O'Brien", "marks": 89},
  {"name": "Riley Kim", "marks": 77},
  {"name": "Sarah Patel", "marks": 94},
  {"name": "Thomas Lee", "marks": 83}
]
```

Import command:
```
mongoimport --db storedb --collection student --file Student.json --jsonArray
```

Q. Select all documents where marks are less than 85 and greater than 45?
```javascript
c1: {marks: {$lt: 85}}
c2: {marks: {$gt: 45}}
db.student.find({$and: [{marks:{$lt: 85}}, {marks:{$gt: 45}}]})
```

Q2. Select all documents where marks are less than 80 and greater than or equal to 76?
```javascript
db.student.find({$and: [{marks:{$lt: 80}}, {marks:{$gte: 76}}]})
```

### Shortcut for AND operation:
MongoDB provides an implicit AND operation when specifying a comma-separated list of expressions

Normal way: `{$and: [{expression1}, {expression2},...]}`
Shortcut:  `{expression1, expression2,...}`

Example:
```javascript
db.student.find({$and: [{no_of_reviews: {$gte: 3}}, {downloadable: true}]})

db.student.find({no_of_reviews: {$gte: 3}, downloadable: true})
```

Limitation of this shortcut:
- If the conditions are for the same field, then this shortcut won't work.

Q. List all the students whose marks are >=50 and <=90
```javascript
db.student.find({marks:{$gte:50}, marks:{$lte: 90}})
```

Reason:
In JavaScript objects, duplicate keys are not allowed. If we try to add duplicate keys, the old values will be replaced with new values.

`{marks: {$gte: 50}, marks: {$lte: 90}}` 
It will become
`{marks: {$lte: 90}}`

Solution: We should use $and operator
```javascript
db.student.find({$and: [{marks: {$gte: 50}}, {marks: {$lte: 90}}]})
```