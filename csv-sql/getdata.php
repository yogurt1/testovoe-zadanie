<?php
include_once 'functions.php';
$temp = null;
$rows = [];
$fields = [
  'fullname' => 0,
  'email' => 1,
  'born' => 2,
  'registred' => 3,
  'status' => 4
];

if (($handle = fopen('data.csv', 'r')) !== FALSE)
{
  for ($n = 0; ($row = fgetcsv($handle, 1000, ";")) !== FALSE; $n++)
  {
    if ($n === 0)
    {
      continue; // skip CSV header
    }

    bitify($row[$fields['status']]); // convert on/off to 1/0
    
    integrify($row[$fields['registred']]); // convert registred date to unix timestamp
    
    $rows[$n] = $row;
  }
}

$random_row = $rows[rand(0, count($rows))]; // toggle status in random row
toggle($random_row[$fields['registred']]);

//print_r($rows);
?>
