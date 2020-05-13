<?php

$connect = new mysqli("localhost","root","","tenjindb");

if($connect)
{

}
else{
    echo "connection Failed";
    exit();
}