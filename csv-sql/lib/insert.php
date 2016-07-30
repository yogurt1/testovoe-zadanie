<?php
require_once 'connection.php';

function insert($row)
{
  global $connection;
  $sql = "insert into csv values (?, ?, ?, ?, ?)";
  $stmt = $connection->prepare($sql);
  $stmt->bind_param('sssii', $row[0], $row[1], $row[2], $row[3], $row[4]);
  $stmt->execute();
  $stmt->close();
}
?>