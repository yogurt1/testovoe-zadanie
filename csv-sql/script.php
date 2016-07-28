<?php
include_once 'query.php';

// Migration
query(file_get_contents('migration.sql'));

$connection->close();
?>
