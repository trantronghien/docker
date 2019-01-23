<?php
$host = 'mysql';
echo $host;
$user = 'user';
$pass = '123456';
$db = 'myDb';
$conn = new mysqli($host, $user, $pass , $db);

if ($conn->connect_error) {
   die("Connection failed: " . $conn->connect_error);
} 
echo "Connected to MySQL successfully!";
?>