
## 2. `$unset` Operator  
To delete the specified field.  
**Syntax:**  
```bash
{$unset: {field1:"", field2:"", ...}}
```
The specified value in the `$unset` expression (i.e., `""`) does not impact the operation.  

### Q1. Delete `esal` and `husband` fields where `ename` is "Sunny"?  
```bash
db.employees.update({ename: "Sunny"}, {$unset: {esal: 0, husband: ""}})
db.employees.update({ename: "Sunny"}, {$set: {esal: 50000, husband: "Ravi"}})
```

### Q2. Remove `husband` and `friend` fields where `esal` is less than 8000?  
```bash
db.employees.updateMany({esal: {$lt: 8000}}, {$unset: {husband: "", friend: ""}})
```

## 3. `$rename` Operator  
We can use the `$rename` operator to rename fields, i.e., change the name of a field.  

**Syntax:**  
```bash
{$rename: {field1: <newName1>, field2: <newName2>, ...}}
```

### Q. Write a query to rename `esal` as `salary` and `eaddr` as `city` in the employees collection?  
```bash
db.employees.updateMany({}, {$rename: {esal: "salary", eaddr: "city"}})
```

**Example Output:**  
```bash
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 7,
  modifiedCount: 7,
  upsertedCount: 0
}
```

**Updated Records:**  
```json
[
  { _id: 1, eno: 100, ename: "Sunny", age: 45, origin: "Punjab", city: "Mumbai", salary: 1111 },
  { _id: 2, eno: 200, ename: "Bunny", city: "Hyderabad", salary: 2000 },
  { _id: 3, eno: 300, ename: "Chinny", city: "Mumbai", salary: 7777 },
  { _id: 4, eno: 400, ename: "Vinny", city: "Delhi", salary: 4444 },
  { _id: 5, eno: 500, ename: "Pinny", city: "Chennai", salary: 5000 },
  { _id: 6, eno: 600, ename: "Tinny", city: "Mumbai", salary: 7777 },
  { _id: 7, eno: 700, ename: "Zinny", city: "Delhi", salary: 4444 }
]
```

### How `$rename` Works Internally:  
- Internally, the `$set` and `$unset` operations happen, so the order of fields may not be the same.  
- If the document already has a field with the `newName`, the `$rename` operator will remove that field and rename the specified field.

**Example:**  
```bash
db.employees.insert({_id: 8, eno: 800, ename: "Minny", eaddr: "Hyderabad", esal: 8000, city: "Mumbai"})
```

### Q. Rename `eaddr` as `city`?  
```bash
db.employees.update({_id: 8}, {$rename: {eaddr: "city"}})
```

**Note:**  
If the field to rename does not exist in the document, `$rename` won't do anything.  

### Q. Rename `age` to `totalage`?  
```bash
db.employees.update({_id: 8}, {$rename: {age: "totalage"}})
```

## `$inc` Operator  
The `$inc` operator increments or decrements the value of a field by the specified amount.  

**Syntax:**  
```bash
{$inc: {field1: amount1, field2: amount2}}
```

### Example:  
Increase `salary` by 2000:  
```bash
db.employees.updateMany({}, {$inc: {salary: 2000}})
```

### Case Study:  

Inserting employees data:  
```bash
db.employees.insert({_id: 1, eno: 100, ename: "Sunny", esal: 1000, eaddr: "Mumbai"})  
db.employees.insert({_id: 2, eno: 200, ename: "Bunny", esal: 2000, eaddr: "Hyderabad"})  
db.employees.insert({_id: 3, eno: 300, ename: "Chinny", esal: 3000, eaddr: "Mumbai"})  
db.employees.insert({_id: 4, eno: 400, ename: "Vinny", esal: 4000, eaddr: "Delhi"})  
db.employees.insert({_id: 5, eno: 500, ename: "Pinny", esal: 5000, eaddr: "Chennai"})  
db.employees.insert({_id: 6, eno: 600, ename: "Tinny", esal: 6000, eaddr: "Mumbai"})  
db.employees.insert({_id: 7, eno: 700, ename: "Zinny", esal: 7000, eaddr: "Delhi"})  
```

### Q. Increment all employee `esal` by 500?  
```bash
db.employees.updateMany({}, {$inc: {esal: 500}})
```

### Q. Decrement `esal` by 1 where `esal` > 4700?  
```bash
db.employees.updateMany({esal: {$gt: 4700}}, {$inc: {esal: -1}})
```

### **Note:**
1. If the specified field does not exist, `$inc` creates that field and sets it to the specified value:  
    ```bash
    db.employees.updateMany({}, {$inc: {age: 2}})
    ```

2. You cannot perform multiple updates on the same field in a single operation:  
    ```bash
    db.employees.updateMany({}, {$inc: {esal: 500}, $set: {esal: 5000}})
    ```

