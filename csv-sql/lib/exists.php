<?php
require_once 'connection.php';
require_once 'query.php';
require_once 'functions.php';
require_once 'fields.php';

function exists($row)
{
  global $connection, $fields;
  
  // build sql query
  $sql = "select * from csv where name = ";
  $fullname = $row[$fields['fullname']];
  escapify($fullname);
  $sql .= $fullname;

  $result = $connection->query($sql);
  $count = $result->num_rows;
  $result->close();

  return $count >= 1;
}

function mexists($rows)
{
}
?>