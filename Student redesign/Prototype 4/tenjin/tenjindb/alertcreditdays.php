<?php

include 'conn.php';

//$studentID=$_POST['StudentID'];
//$studentID=816000799;
$coursecode=$_POST['CourseCode'];
$Email=$_POST['Email'];


/*$queryResult=$connect->query("SELECT * FROM student_credits WHERE `numofcredits` = 0 AND `CourseCode` = '$coursecode' "); */
$queryResult=$connect->query("SELECT * FROM course_students WHERE `numofcredits` = 0 AND `CourseID` = '$coursecode' AND `Email`
IN (SELECT Email FROM course_students WHERE `Email` = '$Email') ");

/*if($queryResult === TRUE){
    echo "success";
}else {g
    echo "error";
}

$connect->close();
return;

*/

$result=array();

while($fetchData=$queryResult->fetch_assoc())
{
    $result[]=$fetchData;
}

echo json_encode($result)

?>