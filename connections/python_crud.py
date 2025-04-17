import pymongo

try:
    client = pymongo.MongoClient()
    db = client['pythondb']
    collection = db['student']

    # while True:
    #     try:
    #         sid = int(input("Enter student id: "))
    #         name = input("Enter student name: ")
    #         marks = int(input("Enter student marks: "))

    #         document = {"SID": sid, "Name": name, "Marks": marks}
    #         collection.insert_one(document)
    #         print("Student details added successfully")

    #         option = input("Do you want to add another student details [Yes|No]: ")
    #         while option.lower() not in ['yes', 'no', 'y', 'n']:
    #             option = input("Please enter valid option: ")
            
    #         if option.lower() in ('no', 'n'):
    #             break

    #     except ValueError:
    #         print("Invalid input. Please enter a valid integer for ID and marks.")
    #     except pymongo.errors.PyMongoError as e:
    #         print(f"An error occurred while inserting data: {e}")

    # print("Thank you for using our application")

    # Add find operation to display all student records
    # print("\nAll Student Records:")
    # for student in collection.find():
    #     print(f"ID: {student['SID']}, Name: {student['Name']}, Marks: {student['Marks']}")

    # write a query to display all students with marks greater than 100
    print("\nStudents with marks greater than 100:")
    query = {"Marks": {"$gt": 100}}
    cursor = collection.find(query)
    for document in cursor:
        print(document)

    # find the student whose marks less than 102 in descending order
    print("\nStudents with marks less than 102 in descending order:")
    query = {"Marks": {"$lt": 102}}
    cursor = collection.find(query).sort("Marks", pymongo.DESCENDING)
    for document in cursor:
        print(document)


    # to display only 3 students with least marks
    print("\n3 students with least marks:")
    query = {"Marks": {"$lt": 102}}
    cursor = collection.find(query).sort("Marks", 1).limit(3)
    for document in cursor:
        print(document)

    # display information based on student name how to ignore _id field 
    print("\nInformation based on student name:")
    name = input("Enter student name: ")
    query = {"Name": name}
    cursor = collection.find(query, {"_id": 0})
    for document in cursor:
        print(document)

    # display information based on student name how to ignore _id field 
    print("\nInformation based on student name:")
    name = input("Enter student name: ")
    query = {"Name": name}
    cursor = collection.find(query, {"_id": 0})
    for document in cursor:
        print(document)



except pymongo.errors.ConnectionFailure:
    print("Failed to connect to the MongoDB server.")
except Exception as e:
    print(f"An unexpected error occurred: {e}")
finally:
    if 'client' in locals():
        client.close()



