<?php

include 'conn.php';

$action = $_POST["action"];
$table = "course_students";

if("UPLOAD_POINTS" == $action){
    $courseCode = $_POST['courseCode'];
    $email = $_POST['email'] ;
    $creditPoint = $_POST['creditPoint'] ;
    
    $point = 0;

    if($creditPoint == "one"){
        $point = 1;
    }


    $sql = "UPDATE $table SET Numofcredits = Numofcredits + '$point' WHERE courseID = '$courseCode' AND email = '$email'";
    $result = $connect->query($sql);
    echo "success";
    $connect->close();
    return;

}


?>