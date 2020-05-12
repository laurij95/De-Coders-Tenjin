<?php

include 'conn.php';

//$studentID=$_POST['StudentID'];
//$studentID=816000799;
$coursecode=$_POST['CourseCode'];


/*$queryResult=$connect->query("SELECT * FROM student_credits WHERE `numofcredits` = 0 AND `CourseCode` = '$coursecode' "); */
$queryResult=$connect->query("SELECT * FROM course_students WHERE `numofcredits` = 0 AND `CourseID` = '$coursecode' ");

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