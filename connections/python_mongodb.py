# import pymongo
# # client = pymongo.MongoClient()
# # client = pymongo.MongoClient("localhost", 27017)
# client = pymongo.MongoClient("mongodb://localhost:27017/")
# print("Connection to MongoDB successful")
# db_list = client.list_database_names()
# print("List of available databases:")
# for db in db_list:
#     print(db)
# client.close()


# Q2. Write a program to cretae a database named with pythondb and a collection named with employees and insert one document into the collection?


# import pymongo
# client = pymongo.MongoClient("mongodb://localhost:27017/")
# db=client['pythondb']
# collection=db['employees']

# document={
#     "name": "Durga",
#     "age": 25,
#     "department": "IT",
#     "salary": 50000
# }

# x=collection.insert_one(document)
# print("Document inserted with ID:", x.inserted_id)
# client.close()

# #show all collections
# print(db.list_collection_names())

# #show collection
# print(collection.find_one())

# client.close()
# print("Connection to MongoDB closed")


# Example3: To insert multiple documents into the collection?

import pymongo
client = pymongo.MongoClient("mongodb://localhost:27017/")
db=client['pythondb']
collection=db['employees']

emplist=[
    {
        "name": "Durga",
        "age": 25,
        "department": "IT",
        "salary": 50000
    },
    {
        "name": "ravi",
        "age": 20,
        "department": "Comp",
        "salary": 60000
    },
    {
        "name": "Raju",
        "age": 22,
        "department": "IT",
        "salary": 70000
    }
]

x=collection.insert_many(emplist)
print("Documents inserted with IDs:", x.inserted_ids)

#show all collections
print(db.list_collection_names())

#show collection
cursor = collection.find()
for document in cursor:
    print(document)

client.close()

