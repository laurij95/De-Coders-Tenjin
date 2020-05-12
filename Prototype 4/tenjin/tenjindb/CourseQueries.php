<?php

include 'conn.php';


$action = $_POST["action"];
$table = "courses";

if("CREATE_TABLE" == $action){
    $sql = "CREATE TABLE IF NOT EXISTS $table (courseid INT(6) NOT NULL AUTO_INCREMENT PRIMARY KEY, coursecode VARCHAR(10) NOT NULL, coursename VARCHAR(255) NOT NULL, userid VARCHAR(255) NOT NULL)";
    if ($connect -> query($sql) === TRUE) {
        echo "success";
    }else {
        echo "error";
    }
    $connect->close();
    return;
}

if ("GET_ALL" == $action){
    $userid = $_POST["userid"];
    $db_data = array();
    $sql = "SELECT courseid, coursecode, coursename from $table WHERE userid = '$userid'";
    $result = $connect->query($sql);
    if($result->num_rows > 0 ){
        while ($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $connect->close();
    return;
}

// if("CHECK_FOR_DUPLICATES" == $action){
//     $coursecode = $_POST["coursecode"];
//     $coursename = $_POST["coursename"];

//     $sql = "SELECT * from $table WHERE coursecode = '$coursecode' AND coursename = '$coursename'";
//     $result = $conn-> query($sql);
//     if($result!= NULL){
//         echo "success";
//     }else{
//         echo "error";
//     }
// }

if("ADD_COURSE" == $action){
    $coursecode = $_POST["coursecode"];
    $coursename = $_POST["coursename"];
    $userid = $_POST["userid"];

    $sql = "INSERT INTO $table (coursecode, coursename, userid) VALUES ('$coursecode', '$coursename', '$userid')";
    $result = $connect->query($sql);
    echo "success";
    $connect->close();
    return;
}

if("UPDATE_COURSE" == $action){
    $courseid = $_POST['courseid'];
    $coursecode = $_POST['coursecode'];
    $coursename = $_POST['coursename'];

    $sql = "UPDATE $table SET coursecode = '$coursecode', coursename = '$coursename' WHERE courseid = '$courseid'";
    if($connect->query($sql) === TRUE){
        echo "success";
    }else {
        echo "error";
    }
    $connect->close();
    return;
}

if("DELETE_COURSE" == $action){
    $courseid = $_POST['courseid'];
    $sql = "DELETE FROM $table WHERE courseid = '$courseid'";
    if($connect->query($sql) === TRUE){
        echo "success";
    }else {
        echo "error";
    }
    $connect->close();
    return;
}


?>