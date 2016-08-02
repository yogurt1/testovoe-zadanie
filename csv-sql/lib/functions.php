<?php
require_once 'connection.php';

function bitify(&$status)
{
  if ($status == " On")
  {
    $status = 1;
  }
  else {
    $status = 0;
  }
}

date_default_timezone_set('Europe/Moscow');
$format = "Y-m-d H:i:s";

function integrify(&$date) // convert date to timestamp
{
  $date = (new DateTime($date))->getTimeStamp();
}

function deintegrify($timestamp)
{
  global $format;
  return date($format, $timestamp);
}


function toggle(&$status)
{
  switch ($status)
  {
    case 1:
      $status = 0;
      break;
    case 0:
      $status = 1;
      break;
  }
}

function escapify(&$cell)
{
  global $connection;
  $cell = $connection->real_escape_string($cell);
  $cell = '"' . $cell . '"'; //stringify
}
?>
