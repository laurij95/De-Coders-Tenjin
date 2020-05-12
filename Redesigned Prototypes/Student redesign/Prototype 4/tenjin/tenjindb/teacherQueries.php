<?php 
header('Content-type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "tenjindb";
$table = "course_students";

$action = $_POST["action"];

$conn = new mysqli($servername, $username, $password, $dbname);
    if($conn->connect_error){
        die("Connection Failed:" . $conn->connect_error);
        return;
    }


if ("GET_ALL" == $action){
    $coursecode = $_POST["coursecode"];
    $db_data = array();
    $sql = "SELECT studentid, courseID, fname, lname, email, Numofcredits from $table WHERE courseID= '$coursecode'";
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