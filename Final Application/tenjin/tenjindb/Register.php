<?php
/*
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

*/

include 'conn.php';

    $table = "student_login";

    $sql = "CREATE TABLE IF NOT EXISTS $table (`username` int(25) NOT NULL,
            `password` varchar(25) NOT NULL,
            `level` text NOT NULL,
            `FirstName` text NOT NULL,
            `LastName` text NOT NULL,
            `Email` varchar(255) NOT NULL
         )";

    if ($connect -> query($sql) === TRUE) {

        $username = $_POST['username'];
        $password = $_POST['password'];
        $First_Name=$_POST['FirstName'];
        $Last_Name=$_POST['LastName'];
        $Email=$_POST['Email'];
        $level="member";

        $connect->query("INSERT INTO student_login (username, password, level, FirstName, LastName, Email) 
        VALUES ('".$username."','".$password."','".$level."','".$First_Name."','".$Last_Name."','".$Email."')");
    

    }else
    {
        echo "error";
    }
    
    $connect->close();

    return;


?>