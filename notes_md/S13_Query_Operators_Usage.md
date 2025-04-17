# MongoDB Query Operators and Use Cases

## 1. `$mod` operator:

The **Modulo operator** or reminder operator `%` is very helpful for selecting documents based on modulo operations. You can use the `$mod` operator to select documents where the values of the fields, when divided by a divisor, result in a specific remainder.

**Syntax:** 
```json
{ field: { $mod: [divisor, remainder] } }
```

### Case Study:

```javascript
db.shop.insertOne({_id:1, item: "soaps", quantity: 13})
db.shop.insertOne({_id:2, item: "books", quantity: 10})
db.shop.insertOne({_id:3, item: "pens", quantity: 15})
db.shop.insertOne({_id:4, item: "pencils", quantity: 17})
db.shop.insertOne({_id:5, item: "sharpner", quantity: 20})
```

### Q1. Select all documents of the `shop` collection where the quantity value is divisible by 5:

```javascript
db.shop.find({quantity: {$mod: [5, 0]}})
```

#### Output:

```json
[
  { _id: 2, item: 'books', quantity: 10 },
  { _id: 3, item: 'pens', quantity: 15 },
  { _id: 5, item: 'sharpner', quantity: 20 }
]
```

### Q2. Select all documents of the `shop` collection where the quantity value is divisible by 4 and has a remainder of 1:

```javascript
db.shop.find({quantity: {$mod: [4, 1]}})
```

#### Output:

```json
[
  { _id: 1, item: 'soaps', quantity: 13 },
  { _id: 4, item: 'pencils', quantity: 17 }
]
```

**Note:** It is mandatory to provide both divisor and remainder. Otherwise, you will get an error.

Example:
```javascript
storedb> db.shop.find({quantity: {$mod: [4, 1, 2]}})
```
This would throw an error:
```text
MongoServerError: malformed mod, too many elements
```

---

## 2. `$jsonSchema` operator:
We can use this operator to select documents based on a given JSON schema.

---

## 3. `$text` operator:
This operator is related to indexing concepts.

---

## 4. `$where` operator:
This is deprecated and replaced by the `$expr` operator.

---

## Array Query Operators:

### 1. `$all` operator:

You can use the `$all` operator to select documents where the array contains all specified elements.

**Syntax:**
```json
{ field: { $all: [value1, value2, value3,...] } }
```

You can also write an equivalent query using the `$and` operator:
```json
{$and: [{field: value1}, {field: value2},...]}
```

### Case Study:

```javascript
db.courses.insertOne({_id:1, name:"java", tags:["language", "programming", "easy", "ocean"]})
db.courses.insertOne({_id:2, name:"python", tags:["language", "programming", "easy"]})
db.courses.insertOne({_id:3, name:"C", tags:["language", "performance"]})
db.courses.insertOne({_id:4, name:"Oracle", tags:["database", "sql", "cloud"]})
db.courses.insertOne({_id:5, name:"Devops", tags:["Culture"]})
db.courses.insertOne({_id:6, name:"MongoDB", tags:["database", "nosql", "cloud"]})
```

### Q1. Select all documents where the `tags` array contains "database" and "cloud":

1. Using `$all` operator:
```javascript
db.courses.find({tags: {$all: ["database", "cloud"]}})
```

2. Using `$and` operator:
```javascript
db.courses.find({$and: [{tags: "database"}, {tags: "cloud"}]})
```
Here, the order of elements is not important, and it is not an exact match.

3. Using exact match:
```javascript
db.courses.find({tags: ["database", "cloud"]})
```
Here, the order is important, and it requires an exact match.

### Q2. Select all documents where the `tags` array contains "language" and "programming":

```javascript
db.courses.find({$and: [{tags: "language"}, {tags: "programming"}]})
```

or

```javascript
db.courses.find({tags: {$all: ["language", "programming"]}})
```

---

### 2. `$elemMatch` operator:

The `$elemMatch` operator selects documents where at least one element of the array matches the specified query criteria.

**Syntax:**
```json
{ field: { $elemMatch: { <query1>, <query2>, <query3>,... } } }
```

### Case Study:

```javascript
db.students1.insertOne({_id:1, name: "durga", marks:[82,35,99]})
db.students1.insertOne({_id:2, name: "Ravi", marks:[70, 90, 95]})
```

### Q1. Select documents where a student has at least one subject mark greater than or equal to 80 but less than 90:

```javascript
db.students1.find({marks: {$elemMatch: {$gte: 80, $lt:90}}})
```

#### Output:
82 is greater than or equal to 80 but less than 90.

---

### 3. `$size` operator:

The `$size` operator is used to select documents based on the size of an array.

**Syntax:**
```json
{ field: { $size: n } }
```

### Example - `courses` collection:

#### Q1. Select all documents where the `tags` array contains exactly 4 elements:

```javascript
db.courses.find({tags: {$size: 4}})
```

#### Q2. Select all documents where the `tags` array contains exactly 3 elements:

```javascript
db.courses.find({tags: {$size: 3}})
```

#### Q3. Select all documents where the `tags` array contains only one element:

```javascript
db.courses.find({tags: {$size: 1}})
```

**Note:** The `$size` operator does not accept a range of values.

---
```