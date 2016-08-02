<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once 'lib/query.php';
require_once 'lib/insert.php';
require_once 'lib/getdata.php';

// Migration
mquery(file_get_contents('migration.sql'));

/*foreach ($rows as $row) {
  insert($row);
}*/
insert($rows); // assembling one INSERT with multiple rows much faster than one INSERT per row

$connection->close();
?>
