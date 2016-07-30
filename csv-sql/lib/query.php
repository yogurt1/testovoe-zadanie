<?php
require_once 'connection.php';

/* @param SQL query
 * do SQL script and return connection when true 
 */
function query($query)
{
  global $connection;
  if ($connection->multi_query($query) === TRUE)
  {
    //$query . ' |> success';
    echo "|> success \n";
    return $connection;
  }
  else
  {
    echo $query . " |> error \n";
    echo $connection->error;
    return false;
  }
}
?>
