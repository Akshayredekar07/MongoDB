Here's the improved format for the CRUD operations, focusing on **Update Operation**:

---

### CRUD Operations

**C** – Create Operation | Insert Operation  
**R** – Retrieve Operation | Read Operation  
**U** – Update Operation  
**D** – Delete Operation

---

### Update Operation:
**U** – Update Operation:  
----------------------  
Updating documents is crucial when we need to reflect the latest information. Here are different types of updates that can be performed on documents within a MongoDB collection.

#### Examples:
- **Example 1:** Update a student document with a changed mobile number.
- **Example 2:** Increment all employee salaries by 1000 if the salary is less than 10,000.

#### Types of Updates:
1. **Overwrite** an existing field's value with a new value.
2. **Add** a new field to selected documents.
3. **Remove** an existing field.
4. **Rename** an existing field.

#### How to Perform Updates:
Updates can be performed using specific **update methods** and **update operators**.

---

### Update Methods:
There are 3 update methods in MongoDB:

1. **`updateOne()`**  
   - **Syntax:** `db.collection.updateOne(filter, update, options)`
   - Updates the first document that matches the filter criteria.
   - This method only updates one document.

2. **`updateMany()`**  
   - **Syntax:** `db.collection.updateMany(filter, update, options)`
   - Updates all documents that match the filter criteria.

3. **`update()`** (Deprecated)  
   - **Syntax:** `db.collection.update(filter, update, options)`
   - Updates one or more documents. By default, it updates only a single document. To update multiple documents, use `{multi: true}` in the options.
   - **Note:** This method is deprecated. Use `updateOne()` or `updateMany()` instead.

#### Case Study:

```bash
db.employees.insert({_id:1, eno:100, ename:"Sunny", esal:1000, eaddr:"Mumbai"})  
db.employees.insert({_id:2, eno:200, ename:"Bunny", esal:2000, eaddr:"Hyderabad"})  
db.employees.insert({_id:3, eno:300, ename:"Chinny", esal:3000, eaddr:"Mumbai"})  
db.employees.insert({_id:4, eno:400, ename:"Vinny", esal:4000, eaddr:"Delhi"})  
db.employees.insert({_id:5, eno:500, ename:"Pinny", esal:5000, eaddr:"Chennai"})  
db.employees.insert({_id:6, eno:600, ename:"Tinny", esal:6000, eaddr:"Mumbai"})  
db.employees.insert({_id:7, eno:700, ename:"Zinny", esal:7000, eaddr:"Delhi"})
```

### Performing Updates with `updateOne()` and `updateMany()`:

#### Q1: Update Sunny's salary to 9999.
```bash
db.employees.updateOne({ename:"Sunny"}, {$set:{esal:9999}});
db.employees.find({ename:"Sunny"});
```

#### Q2: Update the salary of all employees based in Mumbai to 7777.
- **Single Document:**
  ```bash
  db.employees.update({eaddr:"Mumbai"}, {$set:{esal:7777}});
  ```
- **Multiple Documents:**
  ```bash
  db.employees.updateMany({eaddr:"Mumbai"}, {$set:{esal:7777}});
  ```

#### Q3: Update the salary of all employees based in Delhi to 5555.
- **Single Document:**
  ```bash
  db.employees.update({eaddr:"Delhi"}, {$set:{esal:5555}});
  ```
- **Multiple Documents:**
  ```bash
  db.employees.updateMany({eaddr:"Delhi"}, {$set:{esal:5555}});
  ```

---

### Update Operators:
To modify documents, we can use various update operators:

1. **`$set`** – Overwrites the value of an existing field or adds a new field.
2. **`$unset`** – Removes a specified field.
3. **`$inc`** – Increments the value of a field by a specified amount.
4. **`$mul`** – Multiplies the value of a field.
5. **`$rename`** – Renames a field.
6. **`$min`** – Updates the field to a new value if the new value is less than the current value.
7. **`$max`** – Updates the field to a new value if the new value is greater than the current value.
8. **`$currentDate`** – Sets the value of a field to the current date.

---

#### Using `$set` Operator:

**Example 1:** Update Sunny’s salary to 9999.  
```bash
db.employees.update({ename:"Sunny"}, {$set:{esal:9999}});
```

**Example 2:** Update multiple fields for Sunny.
```bash
db.employees.update({ename:"Sunny"}, {$set: {esal:1111, age:45, origin:"Punjab"}});
```

#### Q4: Add a new field `friend` with the value `Guest` for all employees with a salary >= 4000.
```bash
db.employees.updateMany({esal:{$gte:4000}}, {$set:{friend:"Guest"}});
```

---

#### Nested Document Update:
**Example:** Change the call name of Sara to Virushka.
```bash
db.books.update({"author.name": "Sara Lee"}, {$set: {"author.callname": "Virushka"}});
```