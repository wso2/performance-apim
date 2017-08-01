drop database if exists apim;
create database apim;
use apim;
source ~/wso2am-2.1.0/dbscripts/apimgt/mysql5.7.sql

drop database if exists registry;
create database registry;
use registry;
source ~/wso2am-2.1.0/dbscripts/mysql5.7.sql

drop database if exists userstore;
create database userstore;
use userstore;
source ~/wso2am-2.1.0/dbscripts/mysql5.7.sql