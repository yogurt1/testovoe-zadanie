<?php
require_once 'lib/query.php';
require_once 'lib/insert.php';
require_once 'lib/getdata.php';

// Migration
query(file_get_contents('migration.sql'));

foreach ($rows as $row) {
  insert($row);
}

$connection->close();
?>
