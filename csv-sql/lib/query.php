<?php
require_once 'connection.php';

/* @param SQL query
 * do SQL script and return connection when true 
 */
function query($query)
{
  global $connection;
  $result = $connection->query($query);
  $state = null;
  if ($result)
  {
    //$query . ' |> success';
    echo "|> success \n";
    $state = $result;
  } else {
    echo $query . " |> error \n";
    echo $connection->error;
    $state = false;
  }
  print_r($result);
  $result->close();
  return $state;
}

function mquery($query)
{
  global $connection;
  $result = $connection->multi_query($query);
  $state = null;
  if ($result)
  {
    do {
      $sresult = $connection->store_result();
      if ($sresult)
      {
        $sresult->free();
      } else {
        print_r($sresult);
      }
    } while ($connection->more_results() && $connection->next_result());
  }
  return $sresult;
}
?>
