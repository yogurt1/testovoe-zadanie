<?php
require_once 'connection.php';
require_once 'query.php';
require_once 'fields.php';

function _insert($row) // old per-row insert
{
  global $connection;
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

function insert($rows)
{
  global $connection, $fields;
  $values = array();
  $sql = 'insert into csv values ';
  foreach ($rows as $i => $row)
  {
    $sql .= '(';
    foreach ($fields as $field => $i)
    {
      switch ($field)
      {
        case 'fullname':
        case 'born':
        case 'email':
          //$row[$i] = $connection->real_escape_string($row[$i]);
          $row[$i] = '"' . $row[$i] . '"';
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
  print_r($sql);
  $connection->query($sql);
  print_r($connection->error);
}
?>
