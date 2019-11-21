CREATE TABLE book
(
id integer primary key autoincrement not null,
title text not null,
url text not null,
price integer not null,
has integer not null
);

CREATE TABLE user
(
id integer primary key autoincrement not null,
name text not null,
password text not null
);
