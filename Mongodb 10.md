## $not Operator

It is just to perform inverse operation.

Syntax: `{field: {$not: {operator-expression}}}`
Example: `{marks: {$not: {$gte: 10}}}`

$not operator performs Logical NOT operation on the specified operator expression and selects the documents that do not match operator expression. This includes the documents that do not contain the field.

Example:
```javascript
C: {no_of_reviews: {$not: {$gt: 5}}}

db.books.find({no_of_reviews: {$not: {$gte: 3}}}).pretty()
```

It returns all documents where:
1. The no_of_reviews is not greater than 3 (i.e., less than or equal to 3)
2. no_of_reviews field doesn't exist

## Element Query Operators

1. $exists 
2. $type

### 1. $exists

Syntax: `{field: {$exists: <boolean>}}`

If `<boolean>` is true, then it selects all documents that contain the specified field, even if the value of the field is null.

If `<boolean>` is false, then it selects all documents that do not contain the specified field.

Q1. Select all documents which contain no_of_reviews field.
```javascript
db.books.find({no_of_reviews: {$exists: true}})
```

Q2. Select all documents which do not contain no_of_reviews field.
```javascript
db.books.find({no_of_reviews: {$exists: false}})
```

### Case Study:

```javascript
db.student.insertOne({name: "Durga", marks:100, gf:"Vedika"})
db.student.insertOne({name: "Ravi", marks:20, gf:"Mallika"})
```

Q1. Select all students who have a gf field?
```javascript
db.student.find({gf: {$exists: true}})
```

Q2. Select all students who do not have a gf field?
```javascript
db.student.find({gf: {$exists: false}})
```

Q3. Select all students who have the gf field, but still have marks greater than 70?

```javascript
c1: {gf: {$exists: true}}
c2: {marks: {$gt: 70}}

db.student.find({gf: { $exists: true }, marks: { $gt: 70 }})
db.student.find({$and : [{gf: { $exists: true }}, {marks: { $gt: 70 }}]})
```