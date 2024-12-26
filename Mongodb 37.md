
## MongoDB with Python

Upto this point, we communicated with the MongoDB server using the MongoDB shell, where MongoDB was associated as a client to perform required database operations.

In Python, we communicate with MongoDB using the `pymongo` driver.

---

### Steps

1. **Import `pymongo`:**
   ```python
   from pymongo import *
   ```

2. **Create a client to communicate with the MongoDB server:**
   ```python
   client = MongoClient()
   client = MongoClient("localhost", 27017)
   client = MongoClient("mongodb://localhost:27017/")
   client = MongoClient("mongodb://127.0.0.1:27017/")
   ```

3. **Create or connect to a database:**
   ```python
   db = client["EmployeeDB"]
   ```

4. **Create or connect to a collection:**
   ```python
   collection = db.employees
   ```

5. **Perform database operations using the collection object:**

   A. **To insert a document:**
   ```python
   collection.insert_one()
   collection.insert_many()
   collection.insert()
   ```

   B. **To read a document:**
   ```python
   collection.find_one()
   collection.find_many()
   collection.find()
   ```

   C. **To update a document:**
   ```python
   collection.update_one()
   collection.update_many()
   collection.update()
   ```

   D. **To delete a document:**
   ```python
   collection.delete_one()
   collection.delete_many()
   collection.delete()
   ```

6. **Close the connection:**
   ```python
   client.close()
   ```

---

### Example: Connect to MongoDB Server and List Available Databases

To get the list of available databases, we use:
```python
client.list_database_names()
```

**Python Script Example:**
```python
from pymongo import MongoClient

# Create a client
client = MongoClient("mongodb://localhost:27017/")

# List available databases
databases = client.list_database_names()
print("Available Databases:", databases)

# Close the connection
client.close()
```
