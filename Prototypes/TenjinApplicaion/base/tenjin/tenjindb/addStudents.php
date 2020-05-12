<?php

include 'conn.php';

$action = $_POST["action"];
$table = "course_students";

if("CREATE_TABLE" == $action){
    $sql = "CREATE TABLE IF NOT EXISTS $table (studentid INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, courseID VARCHAR(10) NOT NULL, fname VARCHAR(255) NOT NULL, lname VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL)";

    if($connect -> query($sql) === TRUE){
        echo "success";
    }else{
        echo "error";
    }
    $connect->close();
    return;
}

if("ADD_STUDENT" == $action){
    $courseID = $_POST["courseID"];
    $fname = $_POST["fname"];
    $lname = $_POST["lname"];
    $email = $_POST["email"];

    $sql = "INSERT INTO $table (courseID,fname,lname,email) VALUES ('$courseID', '$fname', '$lname', '$email')";
    $result = $connect->query($sql);
    echo "success";
    $connect->close();
    return;
}

?>