<?php

include 'conn.php';

$username = $_POST['username'];
$password = $_POST['password'];
$First_Name=$_POST['FirstName'];
$Last_Name=$_POST['LastName'];
$Email=$_POST['Email'];
$level="member";

//"SELECT * FROM students_login WHERE username='".$username."' and password='".$password."'"

//"INSERT INTO `students_login`(`username`, `password`, `level`, `FirstName`, `LastName`, `Email`) VALUES ($username,$password,$level,$First_Name,$Last_Name,$Email)"

$connect->query("INSERT INTO student_login (username, password, level, FirstName, LastName, Email) 
VALUES ('".$username."','".$password."','".$level."','".$First_Name."','".$Last_Name."','".$Email."')");


?>