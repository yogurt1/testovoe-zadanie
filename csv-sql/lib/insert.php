<?php
require_once 'connection.php';
require_once 'functions.php';
require_once 'query.php';
require_once 'fields.php';
require_once 'exists.php';

function insert($row) // old per-row insert
{
  global $connection;
  if (!exists($row))
  {
    $sql = 'insert into csv values (?, ?, ?, ?, ?)';
    $stmt = $connection->prepare($sql);

    if (!$stmt)
    {
      echo $sql . "\n";
      printf('errno: %d, error: %s', $connection->errno, $connection->error);
    }

    $stmt->bind_param('sssii', $row[0], $row[1], $row[2], $row[3], $row[4]);
    $stmt->execute();
    $stmt->close();
  }
}

function minsert($rows)
{
  global $connection, $fields;
  $values = array();
  $sql = 'insert into csv values ';
  foreach ($rows as $i => $row)
  {
    $sql .= '(';
    foreach ($fields as $field => $col)
    {
      switch ($field)
      {
        case 'fullname':
        case 'born':
        case 'email':
          escapify($row[$col]);
          break;
      }
      $sql .= $row[$i];
      $sql .= ',';
    }
    $sql = rtrim($sql, ',');
    $sql .= ')';
    $sql .= ',';
  }
  $sql = rtrim($sql, ',');
  query($sql);
}
?>
