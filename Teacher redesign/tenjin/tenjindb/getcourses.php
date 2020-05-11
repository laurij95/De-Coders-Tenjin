<?php

include 'conn.php';

$Email=$_POST['Email'];
//$Email='mattcy@live.com';
//$username=$_POST['username'];
//$test='mattcy@live.com' ;

//$queryResult=$connect->query("SELECT * FROM courses");

//print($Email);


/*$queryResult=$connect->query("SELECT cs.coursename, cs.coursecode
FROM courses cs 
WHERE cs.coursecode IN (
SELECT c.CourseID FROM course_students c 
NATURAL JOIN student_login s WHERE s.Email='$Email')" ); */

//$queryResult=$connect->query("SSELECT c.CourseID, s.Email FROM ((course_students c INNER JOIN courses cs ON cs.coursecode = c.CourseID) INNER JOIN student_login s ON s.Email='$Email') " );

/*$queryResult=$connect->query("SELECT cd.StudentID, cd.numofcredits, cd.CourseCode
FROM student_credits cd
INNER JOIN course_students cs ON cs.CourseID=cd.CourseCode
WHERE cd.StudentID='$username'" ); */

$queryResult=$connect->query("SELECT `CourseID`, `Email`, `Numofcredits` FROM `course_students` WHERE `Email`='$Email'");
 
$result=array();

while($fetchData=$queryResult->fetch_assoc())
{
    $result[]=$fetchData;
}

echo json_encode($result);

?>