
# Nested Documents:

Sometimes we can take document inside another document, such type of document is called as Nested documents also called as embedded documents.

```javascript
db.Employees.insertOne({empno:76, ename:"Ankit", esal:2345, eaddr:"Pune", hobbies:{h1:"Swimming", h2:"Reading"}})
```

**Example**
```json
{
    "specifications": {
        "capacity": "12 cups",
        "color": "Stainless Steel",
        "height": "14 inches",
        "width": "9 inches",
        "depth": "8 inches"
    }
}
```

## Consider the example:
**books.json** 

```json
[
    {
        "Title": "MongoDB",
        "isbn": "2345",
        "reviews": 5,
        "versions": {
            "version1": 2015,
            "version2": 2017
        }
    },
    {
        "Title": "NoSQL",
        "isbn": "2346",
        "reviews": 41,
        "versions": {
            "version1": 2001,
            "version2": 2004
        }
    }
]
```

```bash
mongoimport --db Bookstore --collection books --file book books.json --jsonArray
```

Execute it from the command prompt not from MongoDB shell:

### Download the mongodb tools:
[Download](https://www.mongodb.com/try/download/database-tools). The key tool for importing is `mongoimport`, which supports importing data from JSON, CSV, or TSV files into MongoDB collections.

```bash
mongoimport "C:\Users\Akshay\Documents\DATABASES\MongoDB Durgasoft\books.json" -d Bookstore -c books --jsonArray --drop
```

```bash
PS C:\Users\Akshay\Documents\DATABASES\MongoDB Durgasoft> mongoimport "C:\Users\Akshay\Documents\DATABASES\MongoDB Durgasoft\books.json" -d Bookstore -c books --jsonArray --drop
2024-08-12T16:59:08.381+0530    connected to: mongodb://localhost/
2024-08-12T16:59:08.383+0530    dropping: Bookstore.books
2024-08-12T16:59:08.441+0530    2 document(s) imported successfully. 0 document(s) failed to import.
```

- Bookstore → Database Name
- BOOKS     → Collection Name
- books.json  → JSON data 

```json
[
    {
        "Title": "MongoDB",
        "isbn": "2345",
        "reviews": 5,
        "versions": {
            "version1": 2015,
            "version2": 2017
        }
    },
    {
        "Title": "NoSQL",
        "isbn": "2346",
        "reviews": 41,
        "versions": {
            "version1": 2001,
            "version2": 2004
        }
    },
    {
        "Title": "Advanced python with Durga",
        "isbn": "1111",
        "reviews": 7000,
        "versions": { "version1": 2019, "version2": 2021 }
    },
    {
        "Title": "Java with Durga",
        "isbn": "9876",
        "reviews": 675,
        "versions": { "version1": 2013, "version2": 2016 }
    }
]
```

### mongoimport 
```bash
mongoimport "C:\Users\Akshay\Documents\DATABASES\MongoDB Durgasoft\books.json" -d Bookstore -c books --jsonArray --drop
```

Inside a nested document, we can take another document as well.

MongoDB supports up to 100-level nesting.

### Queries:

```javascript
db.collection.find()
db.collection.insertOne()
db.collection.insertMany()
db.collection.update()
db.collection.updateOne({}, {})
```

```json
{
  "product_name": "Laptop",
  "brand": "Dell",
  "price": 999.99,
  "specifications": {
    "display": {
      "size": "15.6 inches",
      "resolution": "1920x1080",
      "type": "IPS"
    },
    "processor": {
      "manufacturer": "Intel",
      "model": "Core i7-12700H",
      "cores": 14
    },
    "storage": {
      "type": "SSD",
      "capacity": "512GB"
    }
  },
  "reviews": [
    {
      "customer": "John Doe",
      "rating": 4.5,
      "comment": "Great laptop!"
    },
    {
      "customer": "Jane Smith",
      "rating": 5,
      "comment": "Excellent performance."
    }
  ]
}
```

### Arrays in document:

Any collection of items is called an array.
The item can be string, number, or object also.

```json
{
  "category": "Software Engineering",
  "books": [
    {
      "title": "Clean Code: A Handbook of Agile Software Craftsmanship",
      "author": "Robert C. Martin",
      "publishedYear": 2008,
      "ISBN": "9780132350884",
      "genres": ["Software Engineering", "Programming"],
      "language": "English",
      "pages": 431,
      "reviews": [
        {
          "reviewer": "Alice Johnson",
          "rating": 5,
          "comment": "A must-read for all developers!"
        },
        {
          "reviewer": "Bob Lee",
          "rating": 4,
          "comment": "Great insights, but some parts are repetitive."
        }
      ]
    },
    {
      "title": "Design Patterns: Elements of Reusable Object-Oriented Software",
      "author": [
        "Erich Gamma",
        "Richard Helm",
        "Ralph Johnson",
        "John Vlissides"
      ],
      "publishedYear": 1994,
      "ISBN": "9780201634983",
      "genres": ["Software Engineering", "Design Patterns"],
      "language": "English",
      "pages": 395,
      "reviews": [
        {
          "reviewer": "Charlie Brown",
          "rating": 5,
          "comment": "A foundational book for understanding design patterns."
        }
      ]
    },
    {
      "title": "The Pragmatic Programmer: Your Journey to Mastery",
      "author": [
        "Andrew Hunt",
        "David Thomas"
      ],
      "publishedYear": 1999,
      "ISBN": "9780201616222",
      "genres": ["Software Engineering", "Programming"],
      "language": "English",
      "pages": 320,
      "reviews": [
        {
          "reviewer": "David White",
          "rating": 4,
          "comment": "Full of practical advice for programmers."
        },
        {
          "reviewer": "Emma Green",
          "rating": 4,
          "comment": "Good book, but some advice feels dated."
        }
      ]
    }
  ]
}
```

## Basic Idea about CRUD Operations

### C - Create Operation | Insert Operation

### Object Id:

For every document, MongoDB server will associate a unique id, which is nothing but ObjectId will be assigned to `_id` field.

Example:
```json
_id: ObjectId("66ba10b8599317bb6852e07b")
```

ObjectId is not a JSON type and it is of BSON type.

### ObjectId Structure (12 Bytes):

1. The first 4 bytes represent the timestamp when this document was inserted.
2. The next 3 bytes represent the machine identifier (hostname).
3. The next 2 bytes represent the process id.
4. The last 3 bytes represent some random increment value.

### Why this lengthy ObjectId:

The only reason is **uniqueness**.

### Decoding the ObjectId:

To generate a timestamp from ObjectId:

```javascript
db.books.find()[0]  // List out only the first document of the books collection
db.books.find()[0]._id  // Object id of first document
db.books.find()[0]._id.getTimestamp()  // Get timestamp of the object id
```

---

### Check the Errors:

```shell
Bookstore> use Studentdb
switched to db Studentdb
Studentdb> show collections
Students
Studentdb> dd.Students.find()
ReferenceError: dd is not defined
Studentdb> db.Students.find()
[
  {
    _id: ObjectId("66b1ea3158b89e920b32fc87"),
    name: 'Rohit',
    city: 'beed'
  }
]
Studentdb> db.Students.find()[0]

Studentdb> db.Students.find()._id()
TypeError: db.Students.find()._id is not a function
Studentdb> db.insertOne({"A":200, "B":400});
TypeError: db.insertOne is not a function
Studentdb> db.Students.insertOne({"A":200, "B":400});
{
  acknowledged: true,
  insertedId: ObjectId("66bc3fb2eb46ecd72f341399")
}
```

### Using `_id` Field:

You can provide your own value as ObjectId, but it is not recommended. MongoDB server will generate a default ObjectId if we are not providing any `_id` field value.

**Example:**
```shell
db.employees.insertOne({_id:789, name:"Rahul"})
db.employees.insertOne({_id:789, name:"Viraj"})
```

### Duplicate ObjectId is Not Possible:

```shell
Bookstore> db.employees.insertOne({_id:789, name:"Rahul"})
{ acknowledged: true, insertedId: 789 }
Bookstore> db.employees.insertOne({_id:789, name:"Viraj"})
MongoServerError: E11000 duplicate key error collection: Bookstore.employees index: _id_ dup key: { _id: 789 }
```

### Immutable ObjectId:

ObjectIds are immutable. Once created, the value cannot be changed.

```shell
Bookstore> db.employees.updateOne({_id:789},{$set: {_id:9999}})
MongoServerError: Performing an update on the path '_id' would modify the immutable field '_id'
```

Error Message:  
**Performing an update on the path '_id' would modify the immutable field '_id'**

---

### ObjectId Uniqueness:

ObjectId uniqueness is for **collections** not for the entire **database**.

#### Questions and Answers:

1. **Q**: We can use the same ObjectId for other collections, right?  
   **A**: Yes, possible. Uniqueness is per collection, not per database.

2. **Q**: `_id: 100` and `_id: "100"` possible in the same collection?  
   **A**: Yes, because data types are different.

---

### Key Points:

- We cannot store documents in a collection without ObjectId. (False)
- `_id` field will be added automatically by MongoDB if we are not providing that field explicitly. (True)
- ObjectId is not JSON type and it is of BSON type. (True)
- Default ObjectId generated by MongoDB is 12 bytes. (True)
- ObjectIds are unique. (True)
- ObjectIds are mutable. (False)
- We cannot modify the value of ObjectId after creation. (True)
- Default ObjectId consists of timestamp, machine identifier, process id, etc. (True)
- The advantage of using default ObjectId is that we can get several details like timestamp, etc. (True)
- If we provide our own ObjectId value, it may not generate timestamp, machine identifier, process id, etc. (True)


