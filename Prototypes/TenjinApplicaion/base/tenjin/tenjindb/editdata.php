<?php

include 'conn.php';

$username = $_POST['username'];
$password = $_POST['password'];
$FirstName=$_POST['FirstName'];
$LastName=$_POST['LastName'];
$Email=$_POST['Email'];
$prevusername = $_POST['prevusername'];

	
$sql = "UPDATE student_login SET username = '$username', password = '$password',
    FirstName = '$FirstName',LastName = '$LastName',Email = '$Email' WHERE username = '$prevusername'";

    if($connect->query($sql) === TRUE){
        echo "success";
        print("Success");
    }else {
        echo "error";
        print("error");
    }

    $connect->close();

    return;
    

?>

