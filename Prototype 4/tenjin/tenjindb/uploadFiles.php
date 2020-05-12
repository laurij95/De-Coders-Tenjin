<?php

include 'conn.php';

$action = $_POST["action"];
$table = "file_uploads";


if("UPLOAD_FILE" == $action){
    $teacherID = $_POST['teacherID'];
    $courseCode = $_POST['courseCode'];
    $fileName = $_POST['fileName'] ;
    $fileUrl = $_POST['fileUrl'] ;


    $sql = "INSERT INTO $table (teacher_id,course_id,file_name,file_url) VALUES ('$teacherID','$courseCode','$fileName','$fileUrl')";
    $result = $connect->query($sql);
    echo "success";
    $connect->close();
    return;
      
}


?>