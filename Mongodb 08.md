## Query Operators

### `$ne` Operator

**`$ne`: Not Equal**  
The `$ne` operator selects all documents where the value of a field is not equal to the specified value.

**Syntax:**

```javascript
db.collection.find({field: {$ne: value}})
```

**Example:**

Select all documents from the collection where `no_of_reviews` is not 28.

```javascript
db.books.find({no_of_reviews: {$ne: 28}}).pretty()
```

*Note:* Documents where the specified field is not available will also be included in the result.

---

### `$gt` Operator

**`$gt`: Greater Than**  
The `$gt` operator selects all documents where the value of a field is greater than the specified value.

**Syntax:**

```javascript
db.collection.find({field: {$gt: value}})
```

**Example:**

Select all documents from the collection where `no_of_reviews` is greater than 28.

```javascript
db.books.find({no_of_reviews: {$gt: 28}})
```

---

### `$gte` Operator

**`$gte`: Greater Than or Equal To**  
The `$gte` operator selects all documents where the value of a field is greater than or equal to the specified value.

**Syntax:**

```javascript
db.collection.find({field: {$gte: value}})
```

**Example:**

Select all documents from the collection where `no_of_reviews` is greater than or equal to 50.

```javascript
db.books.find({no_of_reviews: {$gte: 50}})
```

---

### `$lt` Operator

**`$lt`: Less Than**  
The `$lt` operator selects all documents where the value of a field is less than the specified value.

**Syntax:**

```javascript
db.collection.find({field: {$lt: value}})
```

**Example:**

Select all documents from the collection where `no_of_reviews` is less than 10.

```javascript
db.books.find({no_of_reviews: {$lt: 10}})
```

---

### `$lte` Operator

**`$lte`: Less Than or Equal To**  
The `$lte` operator selects all documents where the value of a field is less than or equal to the specified value.

**Syntax:**

```javascript
db.collection.find({field: {$lte: value}})
```

**Example:**

Select all documents from the collection where `no_of_reviews` is less than or equal to 3.

```javascript
db.books.find({no_of_reviews: {$lte: 3}})
```

---

### `$in` Operator

**`$in`: In**  
The `$in` operator selects all documents where the value of a field is equal to any value in the specified array.

**Syntax:**

```javascript
db.collection.find({field: {$in: [value1, value2, value3, ...]}})
```

**Example 1:**

Select all documents from the collection where `no_of_reviews` is 1, 2, or 5.

```javascript
db.books.find({no_of_reviews: {$in: [1, 2, 5]}})
```

**Example 2:**

Select all documents from the books collection where the `tags` array contains either "python" or "programming".

```javascript
db.books.find({tags: {$in: ["python", "programming"]}})
```

---

### `$nin` Operator

**`$nin`: Not In**  
The `$nin` operator selects all documents where the value of a field is not present in the specified array.

**Syntax:**

```javascript
db.collection.find({field: {$nin: [value1, value2, value3, ...]}})
```

**Example 1:**

Select all documents from the books collection where `no_of_reviews` is not 1, 4, or 5.

```javascript
db.books.find({no_of_reviews: {$nin: [1, 4, 5, 28, 42, 81]}})
```

**Example 2:**

Consider the query:

```javascript
db.books.find({exams: {$nin: [1, 4, 5]}})
```

We will get all documents because the `exams` field is not available in any document.

*Note:* `$in` result + `$nin` result = Total number of documents.

---

### Next: Logical Query Operators

**Operators:** `$or`, `$not`, `$and`, `$nor`