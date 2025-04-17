# Document Type Database/NoSQL Database

## Document
- No schema
- Not required to have join queries → performance is higher
- Examples: MongoDB, Cassandra, HBase, etc.

## MongoDB
#### MongoDB Shell Client vs MongoDB Server:
- Once we install MongoDB, we get MongoDB Shell and MongoDB Server.
- These are JavaScript-based applications.
- MongoDB server is responsible for storing data in the database.
- MongoDB shell is responsible for managing the server.
- Using this shell, we can perform all required CRUD operations.

MongoDB server can be local or remote.

- To launch/start MongoDB Server: `mongod` command.
- To launch/start MongoDB Shell: `mongosh` command.

### GUI support for MongoDB Shell:
- Compass
- Tobo T3
- Others

## MongoDB Driver:
From an application (Java/Python/Node/C#), if we want to communicate with a database, some software (driver software) is required.

### MongoDB Website:
Go to: `Docs >> Driver >> Choose the language`.

## Installation
**Community version**

Go to the installed directory:

```
cd "C:\Program Files\MongoDB\Server\7.0\bin"
```

Open terminal and check the version:

```
mongod -version
```
**Example output:**
```bash
PS C:\Program Files\MongoDB\Server\7.0\bin> mongod -version
db version v7.0.3
Build Info: {
    "version": "7.0.3",
    "gitVersion": "b96efb7e0cf6134d5938de8a94c37cec3f22cff4",
    "modules": [],
    "allocator": "tcmalloc",
    "environment": {
        "distmod": "windows",
        "distarch": "x86_64",
        "target_arch": "x86_64"
    }
}
```

2nd command:
```
mongo -version
PS C:\Program Files\MongoDB\Server\7.0\bin> mongosh -version
2.0.2
```

## Starting the Server
```
mongod --dbpath "c:\data\db"
```

## Launching Mongo Shell
```
mongosh
```

### Commands to check status:
- `db.version()` → Displays the current version of the server.
- `db.watch()` → Watches for changes in the database.
- `db.help()` → Provides help information for database commands.
- `db.stats()` → Shows statistics about the database.
- `show dbs` → Lists all databases.
- `show collections` → Lists all collections in the current database.
- `use test` → Switches to the 'test' database.
