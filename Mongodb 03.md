
# MongoDB Concepts

## Database and Collections
- **Database** → Several collections
- **Collection** → Several documents

## Terminology:
- **Collection** → Equivalent to tables in relational databases.
- **Document** → Equivalent to a record/row in relational databases.

## MongoDB Shell vs MongoDB Server
- **Start MongoDB server**: `mongod`
- **Start MongoDB client**: `mongosh`

### MongoDB Shell:
- Acts as a client that helps send queries to the server.

[MongoDB Documentation](https://claude.site/artifacts/a8482635-e1c1-4dab-97ef-17f37a6f2820)

## Default Databases in MongoDB

### 1. Admin Database:
- Stores user authentication information like usernames, passwords, and roles.
- Used by administrators for managing users and roles.

### 2. Config Database:
- Stores configuration details of the MongoDB server.

### 3. Local Database:
- Utilized during the replication process by the admin.

**Warning:** Don't delete these databases, as MongoDB may not function properly without them.

## Data Format in MongoDB

### Data Input/Storage:
- End-user/developer provides data in JSON format.
- MongoDB server stores data in BSON format.

**Example**:
- JSON: `{"name":"durga"}` → Stored as BSON in MongoDB.

### Why BSON Conversion?
1. **Extended Data Types**:
   - JSON only supports a limited number of types like String, Number, Array, Boolean, Null.
   - BSON provides extra types like:
     - 32-Bit Integer (`NumberInt`)
     - `ObjectID`
     - `Date`

2. **Efficient Storage**:
   - BSON requires less memory compared to JSON.
   - **JSON**: 10 KB → **BSON**: 4-5 KB.

BSON offers efficient storage and supports extra data types, which are advantages over JSON.

## Conversion Process:
- **Insertion/Creation**: JSON → BSON
- **Read/Retrieval Operation**: BSON → EJSON

**Q: What data formats are used in MongoDB?**
- **Answer**: 3 formats: JSON, BSON, EJSON.


## MongoDB Concepts and Operations

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Creation of Database and Collection:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Creation of database command:
```shell
use durgadb
```
- The database won't be created at the beginning; it will be created dynamically.
- Whenever we create a collection or insert a document, the database is created automatically.

### How to create a collection:
```shell
db.createCollection("Employees")
```

### To view the databases:
```shell
show dbs
```
- `db` is a predefined object in MongoDB, which we can use for various methods.

### Show collections:
```shell
show collections
```

Example:
```shell
durga> db.createCollection("Students")
{ ok: 1 }

durga> show collections
Employees
Students
```

### Q. How to drop a collection?
```shell
db.Students.drop()
```

### Q. How to drop the database?
```shell
db.dropDatabase()
```

Check the current database name:
```shell
db.getName()
```


### Basic CRUD Operations using MongoDB:


### 1. Create/Insert a document:
```shell
db.collection.insert()
db.collection.insertOne()
db.collection.insertMany()
```

Example:
```shell
db.Students.insertOne({roll:23, name:"Akshay", university:"SPPU"})
db.Students.insertOne({roll:27, name:"Rohit", university:"SPPU"})
db.Students.insertOne({roll:31, name:"Karan", university:"SPPU"})
```

### 2. Read/Retrieve a document:
```shell
db.collection.find()    # To get all records in the collection
db.collection.findOne() # To get one record in the collection based on a match condition
```

Example:
```shell
db.Students.find()
db.Students.findOne()
```

- To print data in a more readable format:
```shell
db.Students.find().pretty()
```

Output:
```json
durga> db.Students.find()
[
  {
    _id: ObjectId("66b1e34658b89e920b32fc84"),
    roll: 23,
    name: 'Akshay',
    university: 'SPPU'
  },
  {
    _id: ObjectId("66b1e3a158b89e920b32fc85"),
    roll: 27,
    name: 'Rohit',
    university: 'SPPU'
  },
  {
    _id: ObjectId("66b1e3b158b89e920b32fc86"),
    roll: 31,
    name: 'Karan',
    university: 'SPPU'
  }
]
```

### 3. Update a document:
```shell
db.collection.updateOne()
db.collection.updateMany()
db.collection.replaceOne()
```

Example:
```shell
db.Students.updateOne({name: 'Rohit'}, { $set: {university: 'BAMU'}})
```

Explanation:
- If the `university` field already exists, the old value will be replaced with the new one.
- If the field does not exist, it will be created.

Correct update syntax:
```shell
durga> db.Students.updateOne({name: 'Rohit'}, { $set: {university: 'BAMU'}})
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```
**Note**: Anything prefixed with a `$` symbol is a predefined operator in MongoDB.

### 4. Delete a document:
```shell
db.collection.deleteOne()
db.collection.deleteMany()
```

Example:
```shell
db.Students.deleteOne({name:"Karan"})
```

Output:
```json
durga> db.Students.deleteOne({name:"Karan"})
{ acknowledged: true, deletedCount: 1 }
```

### Important Note:
```shell
use Studentdb
db.Students.insertOne({name:"Rohit", city:"beed"})
```
- Databases and collections are created dynamically when a document is inserted.
