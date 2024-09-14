## D : Delete

### Deleting Document from the Collection:

MongoDB provides the following methods to delete documents from the collection:

1. `deleteOne()`
2. `deleteMany()`
3. `remove()`

### 1. deleteOne()
To delete only one document that matches the query criteria.

**Syntax:**

```js
db.collection.deleteOne()
```

### 2. deleteMany()
To delete all documents that match the query criteria.

**Use this data:**

```js
db.employees.insertMany([
  {_id: 1, eno: 100, ename: "Sunny", esal: 1000, eaddr: "Mumbai"},
  {_id: 2, eno: 200, ename: "Bunny", esal: 2000, eaddr: "Hyderabad"},
  {_id: 3, eno: 300, ename: "Chinny", esal: 3000, eaddr: "Mumbai"},
  {_id: 4, eno: 400, ename: "Vinny", esal: 4000, eaddr: "Delhi"},
  {_id: 5, eno: 500, ename: "Pinny", esal: 5000, eaddr: "Chennai"},
  {_id: 6, eno: 600, ename: "Tinny", esal: 6000, eaddr: "Mumbai"},
  {_id: 7, eno: 700, ename: "Zinny", esal: 7000, eaddr: "Delhi"}
]);
```

#### Q1. Delete the first matched document where `eaddr` is "Mumbai":

```js
db.employees.deleteOne({eaddr: "Mumbai"})
```

**Result:**

```js
{ acknowledged: true, deletedCount: 1 }
```

Only the first matched document is deleted.

#### Q2. Delete all documents where `eaddr` is "Mumbai":

```js
db.employees.deleteMany({eaddr: "Mumbai"})
```

**Result:**

```js
{ acknowledged: true, deletedCount: 2 }
```

After deletion:

```js
[
  { _id: 2, eno: 200, ename: 'Bunny', esal: 2000, eaddr: 'Hyderabad' },
  { _id: 4, eno: 400, ename: 'Vinny', esal: 4000, eaddr: 'Delhi' },
  { _id: 5, eno: 500, ename: 'Pinny', esal: 5000, eaddr: 'Chennai' },
  { _id: 7, eno: 700, ename: 'Zinny', esal: 7000, eaddr: 'Delhi' }
]
```

#### Q3. Delete all documents where `esal` is greater than 3000:

```js
db.employees.deleteMany({esal: {$gt: 3000}})
```

**Result:**

```js
{ acknowledged: true, deletedCount: 3 }
```

After deletion:

```js
[
  { _id: 2, eno: 200, ename: 'Bunny', esal: 2000, eaddr: 'Hyderabad' }
]
```

#### Q4. Delete all documents where `esal` is greater than 500 and `eaddr` is "Delhi":

First, insert the data again:

```js
db.employees.insertMany([...])
```

Then, delete the matched documents:

```js
db.employees.deleteMany({$and : [{esal: {$gt: 500}}, {eaddr: "Delhi"}]})
```

**Result:**

```js
{ acknowledged: true, deletedCount: 2 }
```

After deletion:

```js
[
  { _id: 1, eno: 100, ename: 'Sunny', esal: 1000, eaddr: 'Mumbai' },
  { _id: 2, eno: 200, ename: 'Bunny', esal: 2000, eaddr: 'Hyderabad' },
  { _id: 3, eno: 300, ename: 'Chinny', esal: 3000, eaddr: 'Mumbai' },
  { _id: 5, eno: 500, ename: 'Pinny', esal: 5000, eaddr: 'Chennai' },
  { _id: 6, eno: 600, ename: 'Tinny', esal: 6000, eaddr: 'Mumbai' }
]
```

### 2nd Way:

```js
db.employees.deleteMany({esal: {$gt: 5000}, eaddr: "Delhi"})
```

#### Q5. How to delete all documents from the collection without deleting the collection?

```js
db.employees.deleteMany({})
```

**Result:**

```js
{ acknowledged: true, deletedCount: 5 }
```

After deletion:

```js
storedb> db.employees.find().count()  // 0
storedb> show collections
books
courses
employees
...
```

### 3. remove()

We can use the `remove()` method to delete either a single document or multiple documents.

**Syntax:**

```js
db.collection.remove({query}, justOne)
```

- `justOne` field can take a boolean value.
- If it is `true`, then only one document will be deleted.
- If it is `false`, then all documents will be deleted.
- The default value is `false`, hence, by default, `remove()` will delete multiple documents.

#### Q1. To delete all documents where `eaddr` is "Mumbai":

```js
db.employees.remove({eaddr: "Mumbai"})
```

**Result:**

```js
{ acknowledged: true, deletedCount: 3 }
```

After deletion:

```js
[
  { _id: 2, eno: 200, ename: 'Bunny', esal: 2000, eaddr: 'Hyderabad' },
  { _id: 4, eno: 400, ename: 'Vinny', esal: 4000, eaddr: 'Delhi' },
  { _id: 5, eno: 500, ename: 'Pinny', esal: 5000, eaddr: 'Chennai' },
  { _id: 7, eno: 700, ename: 'Zinny', esal: 7000, eaddr: 'Delhi' }
]
```

#### Q2. To delete only the first matched document where `eaddr` is "Delhi":

```js
db.employees.remove({eaddr: "Delhi"}, true)
```

**Result:**

```js
{ acknowledged: true, deletedCount: 1 }
```

### How to Delete a Collection?

```js
db.collection.drop()
```

To delete a collection including all documents.

Example:

```js
db.student1.drop()
```

### How to Drop a Database?

```js
db.dropDatabase()
```

It will delete the current database.

- `db.getName()` : To get the name of the database.

### Q1. What is the difference between the following 2 commands?

- `db.collection.drop()` → Both the collection and documents will be deleted.
- `db.collection.deleteMany()` → Only the documents will be deleted but not the collection.

**Note:** In general, deleting collections and databases is the responsibility of the database admin.

### Q2. What is the difference between the following commands?

- `db.collection.deleteMany({})`
- `db.collection.remove({})`
- `db.collection.remove({}, false)`

All are equal, and they delete all documents from the collection.
```

