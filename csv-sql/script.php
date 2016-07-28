<?php
include_once 'lib/query.php';
include_once 'lib/getdata.php';

// Migration
query(file_get_contents('migration.sql'));

$connection->close();
?>
