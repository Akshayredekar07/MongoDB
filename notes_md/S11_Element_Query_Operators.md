## Element Query Operator:

### Part 2: $type

The `$type` operator selects the documents where the value of a field is of a particular type.

We have to specify the type as BSON type.

This operator is very helpful whenever we are dealing with large volumes of unstructured data where types are unpredictable.

**Syntax-1**: Querying for a single type
```
{field: {$type: <BSON type>}}
```

We can specify either the alias for BSON type.
e.g:
```javascript
{field: {$type: "int"}}
{field: {$type: "string"}}
```

**Syntax-2**: Querying for multiple types:
```
{field: [{$type: <BSON type1>}, {$type: <BSON type2>}, {$type: <BSON type3>}]}
```

### BSON Type Table:

| BSON Type      | Number | Alias     |
|----------------|--------|-----------|
| Double         | 1      | "double"  |
| String         | 2      | "string"  |
| Object         | 3      | "object"  |
| Array          | 4      | "array"   |
| Binary Data    | 5      | "binData" |
| ObjectId       | 7      | "objectId"|
| Boolean        | 8      | "bool"    |
| Date           | 9      | "date"    |
| Null           | 10     | "null"    |
| 32 Bit Integer | 16     | "int"     |
| 64 Bit Integer | 18     | "long"    |
| Decimal128     | 19     | "decimal" |

Q1. What is the difference between int and long?
- int --> 32 bits
- long --> 64 bits

Q2. What is the difference between double and decimal?
- double --> 64 bit floating point value
- decimal --> 128 bit floating point value

Note: `$type` supports "number" Alias, which will match the following BSON Types:
- int
- long
- double
- decimal

### Case Study:

```javascript
db.phonebook.insertOne({_id: 1, name: "Durga", phoneNumber: "9392297878"})
db.phonebook.insertOne({_id: 2, name: "Bunny", phoneNumber: 9392297979})
db.phonebook.insertOne({_id: 3, name: "Chinny", phoneNumber: NumberLong(9898989898)})
db.phonebook.insertOne({_id: 4, name: "Vinny", phoneNumber: NumberInt(9191919191)})
db.phonebook.insertOne({_id: 5, name: "Pinny", phoneNumber: ["7474747474", 7171717171]})
```

Every number is by default treated as double type in MongoDB.

- "9392299090" -- String
- 9392299097 -- double

If you want to consider it as long type or any other type:

```javascript
NumberLong(9898989898)
NumberInt(9898989898)
```

Warning: Specifying a number as an argument to NumberLong is deprecated and may lead to loss of precision. Pass a string instead.

Solution: Always pass large integer values as strings to NumberLong to prevent precision loss.

```javascript
NumberLong("9898989898")
```

```javascript
db.phonebook.find().pretty()
[
  { _id: 1, name: 'Durga', phoneNumber: '9392297878' },
  { _id: 2, name: 'Bunny', phoneNumber: 9392297979 },
  { _id: 3, name: 'Chinny', phoneNumber: Long("9898989898") },
  { _id: 4, name: 'Vinny', phoneNumber: 601984599 },
  { _id: 5, name: 'Pinny', phoneNumber: [ '7474747474', 7171717171 ] }
]
```

Q1. Select all documents where phoneNumber value is of string type?

```javascript
db.phonebook.find({phoneNumber: {$type: "string"}})
db.phonebook.find({phoneNumber: {$type: 2}})
```

Output:
```javascript
[
  { _id: 1, name: 'Durga', phoneNumber: '9392297878' },
  { _id: 5, name: 'Pinny', phoneNumber: [ '7474747474', 7171717171 ] }
]
```

Q2. Select all documents where phoneNumber is of double type

```javascript
db.phonebook.find({phoneNumber: {$type: "double"}})
db.phonebook.find({phoneNumber: {$type: 1}})
```

Output:
```javascript
[
  { _id: 2, name: 'Bunny', phoneNumber: 9392297979 },
  { _id: 5, name: 'Pinny', phoneNumber: [ '7474747474', 7171717171 ] }
]
```

Q3. Select all documents where phoneNumber is of int type

```javascript
db.phonebook.find({phoneNumber: {$type: "int"}})
db.phonebook.find({phoneNumber: {$type: 16}})
```

Output:
```javascript
[ { _id: 4, name: 'Vinny', phoneNumber: 601984599 } ]
```

Q4. Select all documents where phoneNumber is of long type

```javascript
db.phonebook.find({phoneNumber: {$type: "long"}})
db.phonebook.find({phoneNumber: {$type: 18}})
```

Check if the value is of number type:
```javascript
db.phonebook.find({phoneNumber: {$type: "number"}})
```

Output:
```javascript
[
  { _id: 2, name: 'Bunny', phoneNumber: 9392297979 },
  { _id: 3, name: 'Chinny', phoneNumber: Long("9898989898") },
  { _id: 4, name: 'Vinny', phoneNumber: 601984599 },
  { _id: 5, name: 'Pinny', phoneNumber: [ '7474747474', 7171717171 ] }
]
```

Insert:

```javascript
db.phonebook.insertOne({_id: 6, name: "Sunny", phoneNumber: NumberInt(10)})
db.phonebook.insertOne({_id: 7, name: "Minny", phoneNumber: NumberInt(9999999999)})
```

Note: Why this conversion happens: 9999999999 is too large for a 32-bit number, but we forcefully told MongoDB to store it as int, hence automatic rounding off happens.

Output: `{ _id: 7, name: 'Minny', phoneNumber: 1410065407 }`

Hence, use NumberLong instead of NumberInt:

Note: `NumberInt(9999999999)` --> `1410065407`
9999999999 cannot be accommodated in 32 bits, hence some loss of information occurs.

Q6. Querying multiple datatypes?

Q. Select all documents where phoneNumber value is of string or double type.

```javascript
db.phonebook.find({phoneNumber: {$type:[2,1]}}).pretty()
```

Here's a summary of the operators you mentioned, formatted in Markdown:


### Summary Of MongoDB Query Operators

**1. Comparison Operators**

| Operator | Description |
|----------|-------------|
| $gt      | Greater than |
| $gte     | Greater than or equal to |
| $lt      | Less than |
| $lte     | Less than or equal to |
| $eq      | Equal to |
| $ne      | Not equal to |
| $in      | Matches any of the values in an array |
| $nin     | Does not match any of the values in an array |

**2. Logical Operators**

| Operator | Description |
|----------|-------------|
| $or      | Joins query clauses with a logical OR |
| $nor     | Joins query clauses with a logical NOR |
| $and     | Joins query clauses with a logical AND |
| $not     | Inverts the effect of a query expression |

**3. Element Query Operators**

| Operator | Description |
|----------|-------------|
| $exists  | Matches documents that have the specified field |
| $type    | Selects documents if a field is of the specified type |

