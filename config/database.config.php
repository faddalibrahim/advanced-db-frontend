<?php

require __DIR__ . '/credentials.config.php';

class Database
{
 private $host     = HOST;
 private $user     = USERNAME;
 private $password = PASSWORD;
 private $name     = DB_NAME;
 protected $conn;
 protected $connection_error;

 protected function connect()
 {
  $this->conn = null;

  try {
      //  database connection goes here

  } catch () {
    // database connection error goes here
  }

  return $this->conn;
 }
}
