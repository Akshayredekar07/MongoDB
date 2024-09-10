# Ordered Insertion, Write Concern, and Atomicity

## Ordered Insertion in Bulk Insertions

We can perform bulk inserts either by using `insertMany()` or `insert()` methods. All documents present inside the given array will be inserted into the collection.

```javascript
// Database: DurgaDB
// alphabet collection
// some documents --> bulk Insertion
// insert([{}, {}, {}])

db.alphabet.insertMany([{'A':"apple"}, {'B':"banana"}, {'C':"cat"}])
//It is the JavaScript objects
```

```plaintext
DurgaDB> db.alphabet.insertMany([{'A':"apple"}, {'B':"banana"}, {'C':"cat"}])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId("66c3877aff7bfa1f8d69ff18"),
    '1': ObjectId("66c3877aff7bfa1f8d69ff19"),
    '2': ObjectId("66c3877aff7bfa1f8d69ff1a")
  }
}
```

### Default Behaviour of Bulk Insertion

While performing bulk insertion, if any document insertion fails, the rest of the documents won't be inserted. The documents that are already inserted won't be rolled back.

```javascript
db.cars.insertMany([{_id:100, M:"Maruti"}, {_id:200, A:"Audi"}, {_id:300, B:"Benz"}])

db.cars.find().pretty()

db.cars.insertMany([{_id:400, N:"Nexon"}, {_id:400, K:"Kia"}, {_id:300, B:"Benz"}])
```

```plaintext
Uncaught:
MongoBulkWriteError: E11000 duplicate key error collection: DurgaDB.cars index: _id_ dup key: { _id: 400 }
Result: BulkWriteResult {
  insertedCount: 1,
  matchedCount: 0,
  modifiedCount: 0,
  deletedCount: 0,
  upsertedCount: 0,
  upsertedIds: {},
  insertedIds: { '0': 400, '1': 400, '2': 300 }
}
Write Errors: [
  WriteError {
    err: {
      index: 1,
      code: 11000,
      errmsg: 'E11000 duplicate key error collection: DurgaDB.cars index: _id_ dup key: { _id: 400 }',
      errInfo: undefined,
      op: { _id: 400, K: 'Kia' }
    }
  }
]
```

### Customizing Behaviour

We can customize this behaviour so that if one document fails to insert, the remaining documents can still be inserted.

```javascript
>> db.cars.insertMany([{},{},{}], {ordered:false})
```
We can use the ordered property, the default value for ordered is `true`.
If ordered is `false`, then if one document insertion fails, the rest of the documents will be inserted without any problem

```bash
db.cars.insert([{_id:400, I:"Innova"}, {_id:500, R:"Ritz"}], {ordered:false})
```

### Questions

1. **How to rollback already inserted documents in case of any error in the bulk inserts?**

   By using Transactions.

   Transfer 10K from my account to Sunny's account:
   - Operation-1: Debit 10K from my account
   - Operation-2: Credit 10K to Sunny's account

2. **What is the purpose of the ordered property in the insert operation?**

   While performing bulk insert operations using either `insertMany()` or `insert()` methods, if one document insertion fails, the rest of the documents will not be inserted by default. But this behavior can be customized using the ordered property.

3. **Assume the cars collection is empty: How many records should be inserted in the collection?**

   ```javascript
   db.cars.insert([{_id:400, I:"Innova"}, {_id:400, R:"Ritz"}], {ordered:true})
   ```

   **Answer:** 1

4. **Assume the cars collection is empty: How many records should be inserted in the collection?**

   ```javascript
   db.cars.insert([{_id:400, I:"Innova"}, {_id:700, L:"RangeRover"}, {_id:400, R:"Ritz"},  {_id:900, M:"Thar"}], {ordered:false})
   ```

   **Answer:** 3

## Write Concern Property

The `WriteConcern` property is similar to the `ordered` property.

```javascript
db.cars.find()

db.cars.drop()

db.cars.insertOne({I:"Innova"})
```

### Use Case 1

Whenever we are performing an insert operation, by default, the shell/client will wait until receiving an acknowledgment after completing the insertion operation. This may reduce performance at the client side.

```javascript
db.alphabet.insertMany([{'A':"apple"}, {'B':"banana"}, {'C':"cat"}])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId("66c3877aff7bfa1f8d69ff18"),
    '1': ObjectId("66c3877aff7bfa1f8d69ff19"),
    '2': ObjectId("66c3877aff7bfa1f8d69ff1a")
  }
}
```

We can customize this behavior using the `WriteConcern` property.

```javascript
db.collection.insertOne({}, {WriteConcern:{w:0}})
```
```plaintext
w:1 ==> It is the default value, and the client will wait until receiving acknowledgment.
w:0 ==> It means the client won't wait for acknowledgment.
```

```javascript
db.cars.insertOne({B:"BMW"}, {WriteConcern:{w:1}})
db.cars.insertOne({F:"Ferrari"}, {WriteConcern:{w:0}})

db.cars.insertMany(
  [
    { brand: "Ferrari", model: "488 Spider" },
    { brand: "Lamborghini", model: "Huracan" },
    { brand: "Porsche", model: "911 Turbo S" }
  ],
  { writeConcern: { w: 0 } }
);
```

### Use Case 2

In production, for every database, we have to maintain a cloned/replica database to handle failover situations and for load balancing purposes. A single document needs to be inserted into multiple database instances: primary database, replica-1, replica-2, etc.

After inserting how many instances, you are expecting acknowledgment. This can be specified using the `WriteConcern` property.

```
if w: 0 ==> No acknowledgment
if w: 1 ==> Acknowledgment after inserting the document in the primary database.
if w: 2 ==> Acknowledgment after inserting the document in the primary database and replica-1.
if w: 3 ==> Acknowledgment after inserting the document in the primary database, replica-1, and replica-2.
```

```javascript
db.cars.insertOne(
  { A: "Audi" },
  { writeConcern: { w: 3 } }
);
```

```plaintext
DurgaDB> db.cars.insertOne({B:"Benz"}, {writeConcern:{w:3}})
MongoServerError: cannot use 'w' > 1 when a host is not replicated
```

This is not logical because the replica database is not available.
```