drop database if exists apim;
create database apim;
use apim;
source /tmp/apimgt-mysql.sql

drop database if exists registry;
create database registry;
use registry;
source /tmp/mysql.sql

drop database if exists userstore;
create database userstore;
use userstore;
source /tmp/mysql.sql
