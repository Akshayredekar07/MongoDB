# MongoDB Importing Data and Cursor Operations

## Importing Data from CSV into MongoDB

To import data from a CSV file into MongoDB, you can use the `mongoimport` command.

### Example:

```bash
mongoimport -d storedb -c emp --type csv --headerline --drop vidya.csv
```

In the above example use:
- `-d storedb`: Specifies the database name (`storedb`).
- `-c emp`: Specifies the collection name (`emp`).
- `--type csv`: Specifies the file type as CSV.
- `--headerline`: Uses the first line of the CSV file as field names.
- `--drop`: Drops the collection if it exists before inserting the data.
- `vidya.csv`: The CSV file name.

### Another Example:
```bash
mongoimport -d storedb -c learners --type csv --headerline --drop learner.csv
```

### Renaming a Collection:
After importing, you can rename a collection using the following command:

```javascript
db.getCollection('emp').renameCollection('emp')
```

---

## Cursor Concept in MongoDB

### Cursor Overview

When you use the `find()` method in MongoDB, it doesn't return the documents directly; instead, it returns a **cursor object**. The cursor allows you to retrieve documents either **batch-wise** or **document-wise**.

In MongoDB, the cursor object helps to avoid:
1. **Storage problems**
2. **Network traffic issues**
3. **Performance degradation**

The **find()** method returns a cursor object that allows the efficient retrieval of data.

#### Cursor Batch Size:
The default batch size is 20, but you can change this value using the following configuration:
```javascript
config.set("displayBatchSize", 5)
```
You can change the batch size to any value as needed.

### Example:
```javascript
storedb> db.learners.find()
[
  { _id: 6, name: 'Dhanaraju', marks: 60 },
  { _id: 13, name: 'Pranav', marks: 30 },
  { _id: 14, name: 'Meera', marks: 40 },
  ...
]
```

### Cursor Benefits:
1. Retrieve only the required number of documents.
2. Fetch documents batch-wise or document-wise.
3. Prevent storage issues.
4. Avoid network traffic problems.
5. No performance problems.

---

## Important Cursor Methods:

1. **count()**  
   Get the total number of documents:
   ```javascript
   db.learners.find().count()
   ```

2. **hasNext()**  
   Check if there is a next document in the cursor:
   ```javascript
   mycursor.hasNext() // returns true or false
   ```

3. **next()**  
   Retrieve the next document:
   ```javascript
   mycursor.next() // retrieves the next document
   ```

---

### Example - Using Cursor:

When you run `find().next()` multiple times without storing the cursor object, you get the same document because you're creating a new cursor each time.

#### Example:
```javascript
storedb> db.learners.find().next()
{ _id: 6, name: 'Dhanaraju', marks: 60 }
storedb> db.learners.find().next()
{ _id: 6, name: 'Dhanaraju', marks: 60 }
```
Here, two different cursor objects are being created.

#### Using Same Cursor:
```javascript
var mycursor = db.learners.find();
mycursor.next(); // Get the first document
mycursor.next(); // Get the second document
```

---

## JavaScript-based Cursor Example:

To iterate through the cursor in JavaScript, use the `hasNext()` and `next()` methods.

```javascript
var mycursor = db.learners.find();
while (mycursor.hasNext()) {
    print(JSON.stringify(mycursor.next()));
}
```

### Example 1 - Cursor Usage in Shell:
```javascript
var mycursor = db.learners.find();
while (mycursor.hasNext()) {
    print(JSON.stringify(mycursor.next()));
}
```

In the new Mongo shell (`mongosh`), BSON objects can be converted to JSON using `JSON.stringify()`.

---

## Additional Cursor Examples:

### Example 2 - Using `printjson()`:
```javascript
var mycursor = db.learners.find();
while (mycursor.hasNext()) {
    printjson(mycursor.next());
}
```

### Example 3 - Using `forEach` with an Arrow Function:
```javascript
var mycursor = db.learners.find();
mycursor.forEach(doc => {
    printjson(doc);
});
```

### Example 4 - Using `forEach` with `printjson` as a Callback:
```javascript
var mycursor = db.learners.find();
mycursor.forEach(printjson);
```

---

## Cursor Helper Methods:

1. **limit()**  
   Limits the number of documents returned:
   ```javascript
   db.learners.find().limit(5)
   ```

2. **skip()**  
   Skips the specified number of documents:
   ```javascript
   db.learners.find().skip(10)
   ```

3. **sort()**  
   Sorts the documents based on the specified field:
   ```javascript
   db.learners.find().sort({ marks: 1 }) // Sort by marks in ascending order
   ```

---
```
