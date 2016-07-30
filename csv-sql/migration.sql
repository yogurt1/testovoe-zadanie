create database if not exists testovoe;
use testovoe;
create table if not exists csv (
  name varchar(255) not null,  
  email varchar(255) not null,
  born date not null,
  registred integer not null,
  status tinyint(1) not null
) engine=InnoDB default charset=utf8;

