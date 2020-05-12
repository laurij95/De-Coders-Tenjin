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
once the last prototype is finalised then this will be added

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
1. Download or clone this repository and stick it in your `HTDOCS` folder
2. You will need your IP address for the paths in this application, if you do not know what your IP address is, here are some commands that you can enter in your command line / terminal:
  + `Windows: ipconfig`
  + `Mac OS: ipconfig getifaddr en0` (this is if you are using a wireless connection)
  + `Mac OS: ipconfig getifaddr en1` (this is if you are using an ethernet connection)
  + `Linux: ifconfig`
3. There are several files that use the IP address to connect to the backend database via the HTTP server. In each of these files you will have to replace the original IP address with your IP address
  + In `login_page.dart` on line 33 : 
  
    `final response = await http.post("http://192.168.100.12/tenjindb/login.php",` 
    
    change the `192.168.100.12` to your IP address
    
  + In `register_page.dart` on line 35 : 

    `var url="http://192.168.100.12/tenjindb/register.php",` 

    change the `192.168.100.12` to your IP address
    
  + In `viewCourses.dart` on line 20 : 

    `final response = await http.post("http://192.168.100.12/tenjindb/getcourses.php",` 

    change the `192.168.100.12` to your IP address

  + In `student_file.dart` on line 51 : 

    `final result = await http.get("http://192.168.100.12/tenjindb/studentcourse.php");` 

    change the `192.168.100.12` to your IP address

  + In `courseServices.dart` on line 7 : 

    `static const ROOT = 'http://192.168.100.12/tenjindb/CourseQueries.php';` 

    change the `192.168.100.12` to your IP address
  
  4. Run the application
  
  



## How to Use
This section guides users through the different actions that a particular user can take.

### FOR TEACHERS
#### Signing up / Registering
---
#### Login
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Login%20-%20Profile/login.png" alt="Teacher Login">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Login%20-%20Profile/1.png" alt="Teacher Login">
</p>
<p align="center">
  <img src="https://github.com/laurij95/De-Coders-Tenjin/blob/master/Finalized%20Screenshots/Teacher/Login%20-%20Profile/2.png" alt="Teacher Login">
</p>

---
#### Courses
##### Add Course
##### Update Course 
##### Delete Courses
---
#### Documents
##### Upload Document
##### Update Document
##### Delete Document
---
### FOR STUDENTS
#### Signing up / Registering
---
#### Login
---

#### Courses
##### View Courses
---
#### Documents
##### View Documents
##### Buy / Unlock a Document
---



**Group Members:**
+ Shahanaz Alex
+ Matthew Cyrus
+ Laurel Jackson
