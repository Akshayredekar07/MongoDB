### Projection of Array Elements

 1. `$`
 2. `$elemMatch`
 3. `$slice`

### Case Study

```js
db.student1.insertMany([
    { _id: 4, name: "Durga", year: 1, marks: [70, 87, 90] },
    { _id: 5, name: "Ravi", year: 1, marks: [90, 88, 92] },
    { _id: 6, name: "Shiva", year: 1, marks: [85, 100, 90] },
    { _id: 7, name: "Durga", year: 2, marks: [79, 85, 80] },
    { _id: 8, name: "Ravi", year: 2, marks: [88, 88, 92] },
    { _id: 9, name: "Shiva", year: 2, marks: [95, 90, 96] }
]);
```

### 1. `$` Operator
The `$` operator is used to project the first element in an array that matches the query condition.

- **Syntax:**
  ```js
  db.collection.find({<array>: <condition>}, {<fields>})
  ```

- **Example 1:**
  Find all students with marks greater than or equal to 85, and project only the matched element from the `marks` array.
  ```js
  db.student1.find({marks: {$gte: 85}}, {_id: 0, name: 1, "marks.$": 1})
  ```
  Output:
  ```json
  [
    { name: 'Durga', marks: [ 87 ] },
    { name: 'Ravi', marks: [ 90 ] },
    { name: 'Shiva', marks: [ 85 ] }
  ]
  ```

- **Key Point:** The `$` operator selects only one element (the first matched element) based on the query condition. If there is no array in the query, the `$` operator will throw an error.

### 2. `$elemMatch` Operator
The `$elemMatch` operator selects only one array element that matches a specified condition within the array itself, regardless of the query condition.

- **Syntax:**
  ```js
  db.collection.find({}, {<array>: {$elemMatch: <condition>}})
  ```

- **Example 1:**
  Find all students and project only the first `marks` element that is less than 95.
  ```js
  db.student1.find({}, {_id: 0, name: 1, year: 1, marks: {$elemMatch: {$lt: 95}}})
  ```
  Output:
  ```json
  [
    { name: 'Durga', year: 1, marks: [ 70 ] },
    { name: 'Ravi', year: 1, marks: [ 90 ] }
  ]
  ```

- **Key Difference from `$`:** Unlike the `$` operator, `$elemMatch` does not consider the query condition but rather the explicit condition specified within the `$elemMatch`.

### 3. `$slice` Operator
The `$slice` operator is used to select a specified number of elements from an array. It allows you to select elements from either the start or the end of an array or specify a range.

- **Syntax 1 (First/Last Elements):**
  ```js
  db.collection.find({query}, {<array>: {$slice: n}})
  ```

  - `n > 0` → Returns the first `n` elements.
  - `n < 0` → Returns the last `n` elements.

- **Example 1:**
  Project the first two elements of the `marks` array.
  ```js
  db.student1.find({}, {_id: 0, name: 1, year: 1, marks: {$slice: 2}})
  ```
  Output:
  ```json
  [
    { name: 'Durga', year: 1, marks: [ 70, 87 ] },
    { name: 'Ravi', year: 1, marks: [ 90, 88 ] }
  ]
  ```

- **Syntax 2 (Skip and Select):**
  ```js
  db.collection.find({query}, {<array>: {$slice: [n1, n2]}})
  ```

  - `n1` → Number of elements to skip.
  - `n2` → Number of elements to return.

- **Example 2:**
  Skip the first element and select the next two from the `marks` array.
  ```js
  db.student1.find({year: 1}, {_id: 0, name: 1, marks: {$slice: [1, 2]}})
  ```
  Output:
  ```json
  [
    { name: 'Durga', marks: [ 87, 90 ] },
    { name: 'Ravi', marks: [ 88, 92 ] }
  ]
  ```

In conclusion:
- The `$` operator returns the first matched element based on the query condition.
- The `$elemMatch` operator returns the first element that matches the condition explicitly specified in `$elemMatch`.
- The `$slice` operator allows for selecting a range of elements from an array by specifying how many elements to skip and select.