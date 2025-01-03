## Querying the Nested Document

**Database Name:** storedb  
**Collection Name:** books  
**File Name:** books.json

To import the JSON file, use the following command:

```bash
mongoimport --db storedb --collection books --file books1.json --jsonArray
```

## Accessing Nested Properties

If the value of a field is another document, you can access the nested property value using the dot operator.

**Q1:** List all documents where the author's callname is "Shiv".

```javascript
db.books.find({"author.callname": "Shiv"}).pretty()
```

**Output:**

```json
[
  {
    _id: ObjectId("66c49da6b033c154dd47d275"),
    title: 'Linux in Simple Way',
    isbn: 6677,
    downloadable: false,
    no_of_reviews: 1,
    tags: ['os', 'freeware', 'shell programming'],
    languages: ['english', 'hindi', 'telugu'],
    author: {
      name: 'Shiva Ramachandran',
      callname: 'Shiv',
      profile: { exp: 8, courses: 3, books: 2 }
    }
  }
]
```

**Q2:** List all documents from the books collection where the author profile contains exactly 3 courses.

```javascript
db.books.find({"author.profile.courses": 3}).pretty()
```

---

## Querying Array Elements

Querying array elements is straightforward. 

**Q1:** List all documents where the `tags` array contains the element "programming".

```javascript
db.books.find({tags: "programming"}).pretty()
```

**Note:** 

- This query checks if the array contains the element "programming".
- For querying the array itself (e.g., exact match of the array), use:

```javascript
db.books.find({tags: ["programming"]}).pretty()
```

**Q3:** List all documents where the `languages` array contains the element "telugu".

```javascript
db.books.find({languages: "telugu"}).pretty()
```

**Querying Array Itself**

**Q1:** List all documents where the `tags` array contains exactly `["web development", "html", "css", "javascript"]`.

```javascript
db.books.find({tags: ["web development", "html", "css", "javascript"]}).pretty()
```

*Note:* The order and case of elements in the array are important.

**Examples:**

```javascript
db.books.find({tags: ["web development", "css", "html", "javascript"]}).pretty()
```

```javascript
db.books.find({tags: ["web development", "CSS", "HTML", "JAVASCRIPTS"]}).pretty()
```

---

## Query Operators

Query operators are prefixed with the `$` symbol. MongoDB recognizes the `$` symbol as an indicator of an operator rather than a field or value.

## Comparison Query Operators

Operators include `$eq`, `$ne`, `$gt`, `$lt`, `$gte`, `$lte`, `$in`, `$nin`.

### `$eq` (Equality)

The `$eq` operator matches documents where the field's value is equal to the specified value.

**Syntax:**

```javascript
db.collection.find({field: {$eq: value}})
db.collection.find({field: value}) // Shorter syntax
```

**Case 1:** Equal to a specific value

**Q1:** Select all documents from the books collection where `no_of_reviews` is 15.

```javascript
db.books.find({no_of_reviews: {$eq: 15}}).pretty()
db.books.find({no_of_reviews: 15}).pretty()
```

To count the documents:

```javascript
db.books.find({no_of_reviews: 15}).count()
```

**Case 2:** Field in a nested document equals a value

**Q1:** Select all documents from the books collection where the author profile contains 7 courses.

```javascript
db.books.find({"author.profile.courses": {$eq: 7}})
db.books.find({"author.profile.courses": 7})
```

**Case 3:** Array element equals a value

**Q1:** List all documents where the `tags` array contains the element "AI".

```javascript
db.books.find({'tags': {$eq: "AI"}})
db.books.find({'tags': "AI"})
```

**Case 4:** Select all documents where the `tags` array is exactly equal to `["web development", "react", "javascript"]`.

```javascript
db.books.find({tags: {$eq: ["web development", "react", "javascript"]}}).pretty()
```