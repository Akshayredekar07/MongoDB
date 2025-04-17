## Working with Files

1. Creation of Files 
2. Viewing of Files 
3. Copying of Files 
4. Comparison of Files 
5. Renaming of Files 
6. Deleting Files 
7. Creation of Hidden files and directories 
8. Creation of Link Files 
9. Editing of Files

## 1. Creation of Files: 

In Linux, we can create files in the following ways: 
1. By using touch command (to create empty file)
2. By using cat command 
3. By using editors like gedit, vi, nano etc  

### cat Command:

cat  >  file1.txt

Eg: $ cat > file1.txt 
Hello Friends 
Listen Carefully 
Otherwise Linux will give Left and Right 

ctrl+d : To save and exit  

If file1.txt is not already available, then file1.txt will be created with our provided data. If file1.txt is already available with some content, then old data will be over written with our provided new data.  Instead of overwriting, 

- If we want append operation then we should use >> with cat command. 

cat >> file1.txt 
extra content 

ctrl+d 


Q1. What is the difference between Touch and Cat? 
    touch for creating empty file where as cat for creating a file with some content.  

Q2. How we can perform overwriting and appending with cat Command? 
         >  meant for overwriting          
         >> meant for appending/concatenation  

Q3. If we are using Touch Comamnd, but the File is already available then what will happend?
    The content of the file won't be changed. But last modified date and time i.e., timestamp. will be updated.


```bash
akshay@Ubuntu:~/Desktop$ ls -l file1.txt 
-rw-rw-r-- 1 akshay akshay 52 Sep 12 13:45 file1.txt

akshay@Ubuntu:~/Desktop$ ls -l file1.txt 
-rw-rw-r-- 1 akshay akshay 52 Sep 12 13:56 file1.txt
```

### Case Study:

Assume that we write one shell script. The job of this shell script is to send all current date files to remote server. Assume that this script won't be executed on sat and sun. But on Monday all 3 days files have to be send. 

But the problem with this script is it can recognize only current date files. To change timestamp of sat and Sunday files, we have to use touch command. 

Note:
The touch command can be used for two main purposes:

To create an empty file
To change the timestamp of an existing file

View Content of the Files:

We can view content of the file by using the following commands:
1. cat
2. tac
3. rev
4. head
5. tail
6. less
7. more


1. Text editors comparison:
   • gedit ===> Similer to windows notepad

2. vi editor
 
Using vi editor:
   • Open file: vi file3.txt
   • Editor opens in command mode
   • Enter insert mode: Press 'i'
   • Add your required data
   • Return to command mode: Press ESC key
   • Save and exit: Type ':wq'

3. vim editor: Advanced version of vi editor

4. nano editor:

    nano file4.txt
    save: ctrl+O
    exit: ctrl+X

    