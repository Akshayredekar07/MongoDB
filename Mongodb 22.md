
### Update Operators  
1. **$**  
2. **$[]**  
3. **$[<identifier>]**  

**Marks Example**:  
`marks: [70, 89, 56, 38, 45]`  

---  

### Updating First Matched Element Using `$`  
---------------------------------------------------   
The `$` operator acts as a placeholder to update the first matched element based on the query condition.  

**Syntax**:  
```plaintext  
db.collection.update(query, {update_operator: {"<array>.$": value}})  
```  
Note: The array field must be a part of the query condition.  

#### Case Study  
-----------  
```plaintext  
db.students.insertOne({_id: 1, marks: [70, 87, 90, 30, 40]})   
db.students.insertOne({_id: 2, marks: [90, 88, 92, 110, 45]})   
db.students.insertOne({_id: 3, marks: [85, 100, 90, 76, 58]})   
db.students.insertOne({_id: 4, marks: [79, 85, 80, 89, 56]})   
db.students.insertOne({_id: 5, marks: [88, 88, 92, 45, 23]})   
db.students.insertOne({_id: 6, marks: [95, 90, 96, 92, 95]})   
```  

#### Q1. Update the first matched element (90) in marks array to 999 where `_id: 1`?   
```plaintext  
db.students.updateOne(  
  { _id: 1, marks: 90 },  
  { $set: { "marks.$": 999 } }  
)  
```  

#### Q2. Update the first matched element in marks array less than 90 to 999 in every document?  
```plaintext  
db.students.updateMany(  
  { marks: { $lt: 90 } },  
  { $set: { "marks.$": 999 } }  
)  
```  

---  

### Updating All Array Elements Using `$[]`  
---------------------------------------------------   
The `$[]` operator acts as a placeholder to update all elements in the array for the matched documents based on the query condition.  

**Syntax**:  
```plaintext  
db.collection.update(query, {update_operator: {"<array>.$[]": value}})  
```  

#### Q1. Increment all elements of the marks array by 10?  
```plaintext  
db.students.updateMany({}, { $inc: { "marks.$[]": 10 } })  
```  

#### Q2. Update every element of marks array to 1000 if the array contains at least one element greater than or equal to 1000?  
```plaintext  
db.students.updateMany(  
  { marks: { $elemMatch: { $gte: 1000 } } },  
  { $set: { "marks.$[]": 1000 } }  
)  
```  

---  

### Updating Specific Array Elements Using `$[identifier]`  
-----------------------------------------------------------   
Instead of updating only the first matched element or all elements of the array, we can update only required array elements using `$[identifier]`.  

**$[identifier]** acts as a placeholder to update all elements that match the `arrayFilters` condition for the documents that match the query condition.  

**Syntax**:  
```plaintext  
db.collection.update(query, {update_operator: {"<array>.$[identifier]": value}}, {arrayFilters: [<filters>]})  
```  

#### Q1. Update all marks array elements which are less than 100 to 100?  
```plaintext  
db.students.updateMany(  
  {},  
  { $set: { "marks.$[element]": 100 } },  
  { arrayFilters: [{ "element": { $lt: 100 } }] }  
)  
```  

#### Q2. Write a query to perform the following update: If marks are in the range 101 to 110, set them to 110.  
```plaintext  
db.students.updateMany(  
  {},  
  { $set: { "marks.$[e1]": 110 } },  
  { arrayFilters: [{ $and: [{ "e1": { $gt: 100 } }, { "e1": { $lte: 110 } }] }] }  
)  
```  

---  

### Summary  
- **`$`**: Updates only the first matched element of the array.  
- **`$[]`**: Updates all elements of the array.  
- **`$[identifier]`**: Updates specific array elements based on conditions defined in `arrayFilters`.  

