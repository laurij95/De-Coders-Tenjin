<p align="center">
  <img width="100" src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/tenjin-2.png" alt="Tenjin Logo">
</p>

<h1 align = "center">Tenjin by Decoders</h1>


> In mythology, folklore and the Shinto religion of Japan, Tenjin (天神) is the patron kami (deity) of academics, scholarship and learning, the intelligentsia.

**This is a Github respository for the project course INFO 3604**

## Overview
Tenjin is a mobile teacher's assistant application developed by Decoders as their final year project. 

The application automates the awarding and allocation of credit points to students based on their grades in the various in-course assessments, quizzes and assignments as well as facilitates the sharing of exclusive in-course material to students. There's a catch though, for a student to gain access to this in-course material, they must first 'buy' or 'purchase' the material using their credit points and this material can **only** be viewed in the application, that is, students are prohibited from sharing the materials.

The application facilitates user registration and authentication for both teachers and students.

The application allows teachers to upload a student gradesheet which is then used to calculate and allocate credit points to students. It also allows teachers to view, add, update and delete courses at their desire. Teachers can also upload, view, edit document details (such as name, course code, etc) as well as delete documents. The application also allows teachers to view their students. 

Tenjin allows students to view the tally of acquired credit points by course so that the student can keep track of their 'spending.' The app also allows students to view courses they are enrolled in as well as the respectful documents within those courses. The student is also allowed to 'pay' for or 'purchase' a document in order to view it.

## Contents
+ [Technologies Used](https://github.com/laurij95/De-Coders-Tenjin/blob/master/README.md#technologies-used)
+ [Project Structure](https://github.com/laurij95/De-Coders-Tenjin/blob/master/README.md#project-structure)
+ [Installation](https://github.com/laurij95/De-Coders-Tenjin/blob/master/README.md#installation)
+ [How To Use](https://github.com/laurij95/De-Coders-Tenjin/blob/master/README.md#how-to-use)
  + [For Teachers](https://github.com/laurij95/De-Coders-Tenjin/blob/master/README.md#for-teachers)
  + [For Students](https://github.com/laurij95/De-Coders-Tenjin/blob/master/README.md#for-students)


## Technologies Used
Several technologies were utilised to ensure that Tenjin met its core requirements, some of which include:
* **Flutter framework with Dart API**
* **PHP Programming Language**
* **Flutter plugins and packages**
  + firebase_auth: version 0.15.5+3
  + cloud_firestore: version 0.13.4+2
  + provider: version 4.0.4
  + path_provider: version 0.4.0
  + shared_preferences: version 0.5.4
  + percent_indicator: version 2.1.1+1
  + file_picker: version 1.5.1
  + csv: version 4.0.3
  + mysql1: version 0.17.1
* **Firebase and Firestore**
* **XAMPP with MariaDB and Apache HTTP server**

## Project Structure:
+ **Final Application**

  As the name states, this is the final product of the project, this repository holds the culminated code for all of the previous iterations as well as bug and logic fixes.
  
+ **Finalised Screenshots**
  
  These are screenshots of the system. They have been divided into the Teacher and Student screens and have further been subdivided according to their functionalities.
  
+ **Prototypes**

  These are the chunks of functionality created after each iteration of the project
  
+ **Redesigned Prototypes**

  These are the prototypes that have been reformed with added design features and functionalities.
  
+ **README.md**

  The file that serves as the user manual. This file seeks to inform the user about the application as well as how to use it.
  
+ **tenjin-2.png**

  This is Tenjin's Logo.

## Installation
This section will guide users through Tenjin's installation process.

### Environment Setup
1. Download [XAMPP](https://www.apachefriends.org/index.html) for your respective OS
2. Set up, install and launch XAMPP, ensure that all servers are running
3. Go to your browser and type in `localhost` or your `IP address` in the search bar, once you are greeeted with XAMPP's splash page, you have successfully set up XAMPP, Congrats!
4. Install your preferred IDE (We worked with Android Studio and Visual Studio Code)
5. Install [Flutter](https://flutter.dev/docs/get-started/install) for your respective OS
6. *If* you are using **Android Studio**, please go to plugins and search for `Flutter` and install it, the Flutter plugin is coupled with the Dart API plugin so you will not have to download Dart separately (YAY)
7. *If* you are using **Visual Studio Code**, please go to extensions and search for the `Flutter` and `Dart` extensions and install them.

### Code Configuration
After you have set up your environment, you'll need to make some changes to your code once you have downloaded it
1. Download or clone this repository and stick it in your `HTDOCS` folder, alternatively you can take only the `tenjindb` folder and insert it into the `HTDOCS` folder.
2. You will need your IP address for the paths in this application, if you do not know what your IP address is, here are some commands that you can enter in your command line / terminal:
  + `Windows: ipconfig`
  + `Mac OS: ipconfig getifaddr en0` (this is if you are using a wireless connection)
  + `Mac OS: ipconfig getifaddr en1` (this is if you are using an ethernet connection)
  + `Linux: ifconfig`
3. There are several files that use the IP address to connect to the backend database via the HTTP server. In each of these files you will have to replace the original IP address with your IP address. Search for `10.0.2.2` in your IDE and change all instances of it to your IP address.
4. Run the application

## How to Use
This section guides users through the different actions that a particular user can take.

### FOR TEACHERS

---
#### Login
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Login%20-%20Profile/login.png" alt="Teacher Login">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Login%20-%20Profile/1.png" alt="Teacher Home Page">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Login%20-%20Profile/2.png" alt="Teacher Profile and Logout">
</p>

---
#### Courses
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Courses/1.png" alt="Course Page">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Courses/2.png" alt="Course Page">
</p>

##### Add Course
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Courses/3.png" alt="TAdd Course">
</p>

##### Update Course
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Courses/4.png" alt="Update Course">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Courses/5.png" alt="Update Course Warning">
</p>

##### Delete Courses
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Courses/6.png" alt="Delete Course">
</p>

---
#### Documents
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/1.png" alt="Document Page">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/1.1.png" alt="Document Page Info">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/2.png" alt="Document Page Info">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/2.1.png" alt="Course Documents Page Info">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/3.png" alt="Teacher Profile and Logout">
</p>

##### Update Document
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/4.png" alt="Document Update">
</p>

##### Open Document
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/5.png" alt="Open Document">
</p>

##### Delete Document
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Documents/6.png" alt="Delete Document">
</p>

---
#### Upload Files
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Upload%20Files/1.png" alt="Import Files Page">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Upload%20Files/2.png" alt="Import Files Page Info">
</p>

##### Uploading a File
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Upload%20Files/3.png" alt="Upload File Part 1">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Upload%20Files/4.png" alt="Upload File Part 2">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Upload%20Files/5.png" alt="Upload File Part 3">
</p>

---
#### Upload Student Database
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Student%20Upload/1.png" alt="Upload Student Database Page">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Student%20Upload/2.png" alt="Upload Student Database Page Info">
</p>

##### Uploading a Student Database
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Student%20Upload/3.png" alt="Upload File Part 1">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Student%20Upload/4.png" alt="Upload File Screen Info">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Student%20Upload/5.png" alt="Upload File Part 2">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Student%20Upload/6.png" alt="Upload File Part 3">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Student%20Upload/7.png" alt="Upload File Part 4">
</p>

---
#### Upload Grades
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Grades/1.png" alt="Upload Grade Screen">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Grades/2.png" alt="Upload Grade Screen Info">
</p>

##### Uploading Grades
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Grades/3.png" alt="Upload File Part 1">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Grades/4.png" alt="Upload File Info">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Grades/5.png" alt="Upload File Part 2">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Grades/6.png" alt="Upload File Part 3">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Grades/7.png" alt="Upload File Part 4">
</p>

---
#### View Students
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Students/1.png" alt="View Students Page">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Students/2.png" alt="View Students Page Info">
</p>

##### Viewing Students
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Students/3.png" alt="Viewing Students">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/View%20Students/4.png" alt="View Students Info">
</p>

---
### FOR STUDENTS

---
#### Login
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Student/1.png" alt="Student Login">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Student/2.png" alt="Student Home Page">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Student/2.1.png" alt="Student Profile">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Student/2.2.png" alt="Edit Student Profile">
</p>

#### Courses
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Student/3.png" alt="Dashboard Page with Courses">
</p>

#### Documents
##### View Documents
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Student/4.png" alt="View Course Documents">
</p>

##### Unlock Document
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Student/5.png" alt="Document Purchase">
</p>

---


**Group Members:**
+ Shahanaz Alex
+ Matthew Cyrus
+ Laurel Jackson
