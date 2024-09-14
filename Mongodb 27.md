### MongoDB Utilities (Database Tools)
MongoDB provides several command-line utilities to manage and manipulate data, such as importing, exporting, and creating backups. These utilities are not part of the MongoDB shell, so they must be executed from the command line and installed separately.

#### Installation Steps:
1. Download the tools from the official MongoDB website: [MongoDB Database Tools](https://www.mongodb.com/try/download/database-tools).
2. Extract the downloaded `.zip` file.
3. Navigate to the `bin` directory inside the extracted folder.
4. Copy the utility tools to your MongoDB `bin` folder for easy access.

### Key Tools and Commands:

1. **mongoimport**  
   This tool is used to import data into MongoDB from files like `.json` or `.csv`.

   **Syntax**:  
   ```bash
   mongoimport -d databaseName -c collectionName --file fileName --jsonArray
   ```
   - **Example 1**: Import data from a JSON file into the `students` collection in the `durgadb` database:
     ```bash
     mongoimport -d durgadb -c students --file students.json --jsonArray
     ```
   - **Example 2**: Import data from a CSV file:
     ```bash
     mongoimport -d databaseName -c collectionName --type csv --headerline --drop emp.csv
     ```

2. **mongoexport**  
   This tool is used to export specific data from a MongoDB collection to a file in `.json` format.

   **Syntax**:  
   ```bash
   mongoexport -d databaseName -c collectionName -o fileName
   ```
   - **Example**: Export data from the `employees` collection of the `storedb` database to a `emp.txt` file:
     ```bash
     mongoexport -d storedb -c employees -o emp.txt
     ```
   - Output file (`emp.txt`) would contain:
     ```json
     {"_id":2,"eno":200,"ename":"Bunny","esal":2000,"eaddr":"Hyderabad"}
     {"_id":5,"eno":500,"ename":"Pinny","esal":5000,"eaddr":"Chennai"}
     {"_id":7,"eno":700,"ename":"Zinny","esal":7000,"eaddr":"Delhi"}
     ```

3. **mongodump**  
   This tool allows you to create a backup (dump) of your MongoDB database. It exports the data into `.bson` format, which is MongoDB’s binary format.

   **Syntax**:  
   ```bash
   mongodump
   ```
   This will create a dump for **all databases** in a folder named `dump`. Each collection will have two files:
   - A `.bson` file for the actual data.
   - A `.json` file for metadata.
   
   - **Directory Structure**:  
     ```plaintext
     ├───admin
     │       system.version.bson
     │       system.version.metadata.json
     ├───student
     │       data.bson
     │       data.metadata.json
     ├───testdb
     │       students.bson
     │       students.metadata.json
     └───university
             teachers.bson
             teachers.metadata.json
     ```

4. **mongorestore**  
   This tool restores data from the `.bson` dump created by `mongodump`.

   **Syntax**:  
   ```bash
   mongorestore
   ```
   It restores the data back into the MongoDB instance.

5. **bsondump**  
   Use this tool to convert `.bson` data to a human-readable `.json` format.

   - **Example 1**: Convert and display `.bson` data on the console:
     ```bash
     bsondump teachers.bson
     ```
     This will output:
     ```json
     {"_id":{"$oid":"655a39933059ce8497f86e6f"},"tname":"Aliya","dname":"Comp","salary":{"$numberInt":"11000"},"exp":{"$numberInt":"2"}}
     ```

   - **Example 2**: Convert `.bson` data and write it to a `.json` file:
     ```bash
     bsondump --outFile=teachers.json teachers.bson
     ```

These tools are essential for managing data in MongoDB, offering functionality for backup, restore, and data migration. Each tool serves specific tasks that help you handle data efficiently.