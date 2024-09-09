# Humongous (adjective)  
Extremely large; huge.  
**Example:** A humongous building, humongous amounts of money.  

# MongoDB: Overview  
MongoDB is a popular and trending database used in various applications.  

**Vendor:** MongoDB  
**Website:** [https://www.MongoDB.com](https://www.MongoDB.com)  

## Where to Use MongoDB  
- Desktop applications  
- Mobile applications  
- Web applications (most popular)  

# Full Stack Developer:  
**Stack:** The technologies used to develop web applications are collectively called a stack.  

## MERN Stack  
- **M** - MongoDB  
- **E** - ExpressJS  
- **R** - ReactJS  
- **N** - NodeJS  

**Frontend:** React or Angular  
**Backend Server-Side Framework:** ExpressJS  
**Server-Side Runtime Environment:** NodeJS  
**Database:** MongoDB  

## JavaScript-based technologies:  
- NodeJS  
- ReactJS  
- ExpressJS  
- MongoDB  

MongoDB: Internally uses Mozilla's SpiderMonkey JavaScript Engine.  

# MongoDB Database   
**Type:** Document database/NoSQL database  

## Relational Database vs. Document Database  
There are two most common types of databases:  

### SQL Database/Relational Database:  
Data stored in tables with relationships such as:  
- One to One  
- One to Many  
- Many to One  

To retrieve data, we write join queries to collect data from different tables.  
**Examples:** Oracle, MySQL  

### Document Oriented Database:  
Data is stored in separate documents, and each document is independent of others.  
**Examples:** MongoDB, Cassandra  

# MongoDB Structure  
MongoDB contains multiple databases.  
A physical database in MongoDB contains several logical databases.  
Each logical database contains several collections.  

**Collection:** Similar to a record/row in a relational database.  

**Example:** Shopping Cart Database  
**Collections:** Customers, Products, Orders  

**Customer Collection:** Contains several documents  

## Data Representation in MongoDB  
**Format:** JSON (BSON)  

**JSON:** JavaScript Object Notation  
**BSON:** Binary JSON  
Internally, data is stored in BSON.  

### Example Documents  
**document01**  
```json  
{  
    "Name": "Durga",  
    "Salary": 457770,  
    "Age": 40  
}
```
**document02**
```json
{  
    "name": "Bunny",  
    "age": 30,  
    "address": {  
        "city": "Hyderabad"  
    },  
    "hobbies": [  
        {"name": "Cricket playing"},  
        {"name": "swimming"}  
    ]  
}
```

# Key Characteristics of MongoDB Database  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
1. All information related to a document will be stored in a single place. To retrieve data, it is not required to perform join operations, and hence retrieval is very fast.  

2. Documents are independent of each other and have no schema. Hence, we can store unstructured data like video, audio files, etc.  

3. We can perform operations like editing existing documents, deleting documents, and inserting new documents very easily.  

4. Retrieval of data is in the form of JSON, which can be understood by any programming language without any conversion (Interoperability).  

5. We can store a very huge amount of data, and hence scalability is more.  

**Note:** Performance and flexibility are the biggest assets of MongoDB.