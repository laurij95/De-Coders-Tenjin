<?php

include 'conn.php';

$coursecode=$_POST['Coursecode'];
$Name=$_POST['Name'];

 $queryResult=$connect->query("SELECT * FROM file_uploads WHERE course_id='$coursecode' AND file_name='$Name'");

 $result = array();

 while ($fetchdata=$queryResult->fetch_assoc())
 {
     $result[] = $fetchdata;
 }

echo json_encode($result)

?>
