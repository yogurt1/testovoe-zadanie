<?php
$connection = new mysqli('localhost', 'root', '');
$connection->set_charset('utf8');

if ($connection->connect_error)
{
  die('Connection failed: ' . $connection->connect_error);
}
?>