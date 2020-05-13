<?php

include 'conn.php';

//$studentID = $_POST['StudentID'];
$Coursecode = $_POST['Coursecode'];
$Email = $_POST['Email'];
//$studentID =816000799;

//$queryResult=$connect->query("UPDATE student_credits set `numofcredits`= `numofcredits`- 1   WHERE StudentID='$studentID' ");

//$studentID =816000799;
//$Coursecode ='Comp3606';

/*$queryResult=$connect->query("UPDATE student_credits 
set 
`numofcredits`= CASE WHEN `numofcredits`!=0 THEN `numofcredits`- 1 ELSE `numofcredits` END
WHERE StudentID='$studentID' AND CourseCode='$Coursecode' "); */

$queryResult=$connect->query("UPDATE course_students
set 
`Numofcredits`= CASE WHEN `Numofcredits`!=0 THEN `Numofcredits`- 1 ELSE `Numofcredits` END
WHERE Email='$Email' AND CourseID='$Coursecode'");

if($queryResult === TRUE){
    echo "success";
}else {
    echo "error";
}

$connect->close();
return;





?>