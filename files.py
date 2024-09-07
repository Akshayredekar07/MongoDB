for i in range(20, 41):  
    filename = f"mongodb {i}.txt"  
    with open(filename, 'w') as file:  
        file.write(f"This is the content of {filename}")