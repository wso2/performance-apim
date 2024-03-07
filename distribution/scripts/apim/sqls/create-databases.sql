drop database if exists apim;
create database apim character set latin1;
use apim;
source /tmp/apimgt-mysql.sql

drop database if exists registry;
create database registry character set latin1;
use registry;
source /tmp/mysql.sql

drop database if exists userstore;
create database userstore character set latin1;
use userstore;
source /tmp/mysql.sql
