## MongoDB Query Operators

## Comparison Operators
- `$gt`: Greater than
- `$gte`: Greater than or equal to
- `$lt`: Less than
- `$lte`: Less than or equal to
- `$eq`: Equal to
- `$ne`: Not equal to
- `$in`: In array
- `$nin`: Not in array

## Logical Operators
- `$or`: Logical OR
- `$nor`: Logical NOR
- `$and`: Logical AND
- `$not`: Logical NOT

## Element Query Operators
- `$exists`: Checks for the existence of a field
- `$type`: Checks for the BSON data type of a field

## Evaluation Query Operators

Evaluation Query Operators are used for evaluation purposes and are as follows:
1. `$expr`
2. `$regex`
3. `$mod`
4. `$jsonSchema`
5. `$text`
6. `$where`

### Examples

**Collection: `homeBudget`**

```javascript
db.homeBudget.insertOne({category: "Home food", budget:1000, spent:1500})
db.homeBudget.insertOne({category: "Outside food", budget:1000, spent:2000})
db.homeBudget.insertOne({category: "Rent", budget:1500, spent:1500})
db.homeBudget.insertOne({category: "Education", budget:2000, spent:1000})
db.homeBudget.insertOne({category: "Clothes", budget:750, spent:1500})
db.homeBudget.insertOne({category: "Entertainment", budget:1000, spent:2500})
db.homeBudget.insertOne({category: "electronics", budget:400, spent:700})
```

### Query Examples

**Q1. Select all documents where budget value is 1000:**

```javascript
db.homeBudget.find({budget: 1000})
```

**Q2. Select all documents where category value is Rent:**

```javascript
db.homeBudget.find({category: "Rent"})
```

**Q3. Select all documents where spent amount exceeds budget amount:**

**Condition:**

```javascript
db.homeBudget.find({spent: {$gt: budget}}) // wrong
```

In the same collection, to compare two field values, use `$expr`.

### `$expr`

`$expr` is useful for comparing two field values within the same document.

**Syntax:**

```javascript
{$expr: {<expression>}}
```

**Q1. Select all documents where spent amount exceeds budget amount:**

```javascript
db.homeBudget.find({$expr: {$gt: ["$spent", "$budget"]}}).pretty()
```

**Q2. Select all documents where spent amount is less than or equal to budget amount:**

```javascript
db.homeBudget.find({$expr: {$lte: ["$spent", "$budget"]}}).pretty()
```

**Q3. Select all documents where spent amount is equal to budget amount:**

```javascript
db.homeBudget.find({$expr: {$eq: ["$spent", "$budget"]}}).pretty()
```

**Note:**
`$expr` is commonly used with aggregation expressions to evaluate expressions and select documents that satisfy those expressions.

### `$regex`

Use `$regex` to select documents where field values match a specified regular expression.

**Syntax:**

```javascript
{field: {$regex: /pattern/, $options: '<options>'}}
{field: {$regex: 'pattern', $options: '<options>'}}
{field: {$regex: /pattern/<options>}}
{field: /pattern/<options>}
```

**Q1. Select all documents where category value contains "food":**

```javascript
db.homeBudget.find({category: {$regex: /food/}})
db.homeBudget.find({category: {$regex: 'food'}})
db.homeBudget.find({category: /food/})
```

**Q2. Select all documents where category value starts with "E":**

```javascript
db.homeBudget.find({category: {$regex: /^E/}})
db.homeBudget.find({category: {$regex: '^E'}})
db.homeBudget.find({category: /^E/})
```

**Q3. Select all documents where category value starts with either "E" or "C":**

```javascript
db.homeBudget.find({category: {$regex: /^[EC]/}})
db.homeBudget.find({category: {$regex: '^[EC]'}})
db.homeBudget.find({category: /^[EC]/})
```

**Q4. Select all documents where category value ends with "t":**

```javascript
db.homeBudget.find({category: {$regex: /t$/}})
db.homeBudget.find({category: {$regex: 't$'}})
db.homeBudget.find({category: /t$/})
```

**Q5. Select all documents where category value ends with either "t" or "n":**

```javascript
db.homeBudget.find({category: {$regex: /[tn]$/}})
db.homeBudget.find({category: {$regex: '[tn]$'}})
db.homeBudget.find({category: /[tn]$/})
```

**How to Check Case Insensitivity:**

By default, case is considered. To ignore case (i.e., case insensitivity), use the 'i' option.

**Q2. Select all documents where category value starts with either "e" or "E":**

```javascript
db.homeBudget.find({category: {$regex: /^E/, $options: 'i'}})
db.homeBudget.find({category: {$regex: '^E', $options: 'i'}})
db.homeBudget.find({category: {$regex: /^E/i}})
db.homeBudget.find({category: /^E/i})
```



## Note on Regular Expressions

### `^` Symbol in Regular Expressions

The `^` symbol in regular expressions is used to indicate that a pattern should match at the start of a string.

- `^t` ---> Matches any string that starts with "t"
- `t$` ---> Matches any string that ends with "t"

### `$` Symbol in Regular Expressions

The `$` symbol in regular expressions is used to indicate that a pattern should match at the end of a string.

- `t$` ---> Matches any string that ends with "t"
- `^t` ---> Matches any string that starts with "t"

### Character Classes and Ranges

- `[abc]` ---> Matches any one of the characters "a", "b", or "c"
- `[ec]` ---> Matches any one of the characters "e" or "c"
- `^[ec]` ---> Matches strings that start with either "e" or "c"
- `[tn]$` ---> Matches strings that end with either "t" or "n"

### Case Insensitivity

To perform a case-insensitive match, use the `i` option in regular expressions.

- **Example**: 
  ```javascript
  db.homeBudget.find({category: {$regex: /^E/, $options: 'i'}})
  db.homeBudget.find({category: {$regex: '^E', $options: 'i'}})
  db.homeBudget.find({category: {$regex: /^E/i}})
  db.homeBudget.find({category: /^E/i})
  ```
