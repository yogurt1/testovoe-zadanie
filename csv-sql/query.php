<?php
$connection = new mysqli('localhost', 'root', '');
if ($connection->connect_error)
{
  die('Connection failed: ' . $connection->connect_error);
}

/* @param SQL query
 * do SQL script and return state
 */
function query($query)
{
  global $connection;
  if ($connection->query($query) === TRUE)
  {
    echo $query . ' |> success';
    return $connection;
  }
  else
  {
    echo $query . ' |> error';
    return false;
  }
}
?>
