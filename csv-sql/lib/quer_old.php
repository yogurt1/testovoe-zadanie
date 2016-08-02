<?php
require_once 'connection.php';

/* @param SQL query
 * do SQL script and return connection when true 
 */
function query($query)
{
  global $connection;
  $result = $connection->multi_query($query);
  $state = null;
  if ($result === TRUE)
  {
    //$query . ' |> success';
    echo "|> success \n";
    $state = $connection;
  }
  else
  {
    echo $query . " |> error \n";
    echo $connection->error;
    $state = false;
  }
  $result->close();
  return $state;
}
?>
