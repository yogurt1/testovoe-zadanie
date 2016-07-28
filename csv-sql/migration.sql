create database if not exists testovoe;
create table if not exists `users` (
  `fullname` varchar(255) not null,
  `email` varchar(255) not null,
  `born` date not null,
  `since` integer not null,
  `status` tinyint(1) not null
) engine=InnoDB default charset=utf8
