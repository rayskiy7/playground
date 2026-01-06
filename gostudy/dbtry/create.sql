DROP DATABASE IF EXISTS users;
CREATE DATABASE users;

\c users;

CREATE TABLE users(
    id SERIAL,
    username VARCHAR(100) PRIMARY KEY
);

CREATE TABLE userdata(
    userid Int NOT NULL,
    name VARCHAR(100),
    secondname VARCHAR(100),
    descr VARCHAR(200)
);