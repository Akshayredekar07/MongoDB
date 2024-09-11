Here's the content corrected and formatted in proper Markdown:

# The Big Story of the Insert Operation

1. `insertOne()`, `insertMany()`, `insert()`
2. Insert documents from JavaScript file using `load()`
3. Insert documents from JSON or CSV file using `mongoimport`
4. Nested documents
5. Arrays in documents
6. `ObjectId`
7. Ordered Insertion
8. Write Concern
9. Atomicity

## What is Meant by Atomicity?

### Question
Assume we have to insert a document with 100 fields. After inserting 50 fields, if the database server faces some problem, what will happen?

### Answer
Whatever fields have already been added will be rolled back.

MongoDB server stores either the complete document or nothing. It won’t store part of the document. CRUD operations are atomic at the document level.

```javascript
db.collection.insertMany([{}, {}, {}, {}]);
```

However, while performing bulk insertion (multiple insertions), if the database server encounters a problem after inserting some documents, the already inserted documents won’t be rolled back. Therefore, atomicity is not applicable by default for bulk inserts.

If we want atomicity for bulk inserts, we should use transactions.

### Transactions
Transactions ensure that either all operations are completed successfully, or none are. 

**Example:**
Transfer 10K from my account to Sunny’s account:
- Operation 1: Debit 10K from my account
- Operation 2: Credit 10K to Sunny’s account

---

# CRUD Operations

## Read (Retrieve/Find) Operation

We can read documents from the collection using the following find methods:
1. `find({query})`: Returns all matched documents based on the query.
2. `findOne({query})`: Returns one matched document based on the query.

The `query` argument is a simple JavaScript object. These methods are related to the collection, so we call these methods on the collection objects.

```javascript
db.collection.find()
db.collection.findOne()
```

These find methods are similar to the SELECT query in relational databases.

**Examples:**
- Read all employees
- Read all employees where `esal > 10000`
- Read all employees where `eaddr` is Hyderabad
- Read all employees where `eaddr` is Hyderabad or `esal > 10000`
- Aggregate functions
- Logical operations

All these operations are possible in MongoDB.

---

# Books.json

**Database Name:** Bookstore  
**Collection Name:** books  
**File Name:** books.json

To import the JSON file, use the following command:

```bash
mongoimport --db Bookstore --collection books --file books.json --jsonArray
```

## Queries

**Q1:** List all documents present in the `books` collection.
```javascript
db.books.find().pretty()
db.books.find({}).pretty()
```

**Q2:** Find the total number of documents present in the `books` collection.
```javascript
db.books.find().count()
```

**Q3:** List the first document present in the `books` collection.
```javascript
db.books.findOne()
db.books.findOne({})
```

*Note:* `pretty()` cannot be used with `findOne()`.

**Example Error:**
```plaintext
Bookstore> db.books.findOne({}).pretty()
TypeError: db.books.findOne({}).pretty is not a function
```

*Note:* The `count()` method cannot be used with `findOne()` either. The `find()` method always returns a cursor object.

**Q4:** List all documents from the collection where `"Title"` is `"NoSQL"`.
```javascript
db.books.find({"Title": "NoSQL"})
```

**Q5:** List all documents from the collection where `"reviews"` are `675`.
```javascript
db.books.find({"reviews": 675})
```