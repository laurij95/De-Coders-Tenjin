<?php
header('Content-type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "tenjindb";
$table = "file_uploads";

$action = $_POST["action"];

$conn = new mysqli($servername, $username, $password, $dbname);
    if($conn->connect_error){
        die("Connection Failed:" . $conn->connect_error);
        return;
    }

if ("GET_ALL" == $action){
    //$userid = $_POST["userid"];
    $coursecode = $_POST["coursecode"];
    $db_data = array();
    $sql = "SELECT id, teacher_id, course_id, file_name, file_url from $table WHERE course_id = '$coursecode'";
    $result = $conn->query($sql);
    if($result->num_rows > 0 ){
        while ($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $conn->close();
    return;
}

?>