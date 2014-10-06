
-- 3NF Relational Database "source system" for PostgreSQL
-- for use with ch. 3 of Kimball & Ross's "The Data Warehouse Toolkit" (3rd ed.)



-- There's no CREATE DATABASE command here, so you have to create a database 
-- on your own, then run this script within that database.




-- Drop all tables (if they already exist).
-- This is so we can run the script repeatedly if needed.
-- The CASCADE keyword will delete any foreign keys, views, or
--  other objects that include the table, which would otherwise
--  prevent deletion.

DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS brand CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS transxn CASCADE;
DROP TABLE IF EXISTS store CASCADE;




CREATE TABLE category (
    -- departments, categories, and subcategories are all represented by this table
    categoryid      serial          NOT NULL    PRIMARY KEY,
    description     varchar(15),
    parent_cat      integer         NULL    references category(categoryid) 
);

CREATE TABLE brand (
    brandid         serial          NOT NULL    PRIMARY KEY,
    brandname       varchar(15)
);

CREATE TABLE product (
    sku             char(10)        NOT NULL    PRIMARY KEY,
    description     varchar(25),
    category        integer         references category(categoryid),
    brand           integer         references brand(brandid),
    unitprice       money
);

CREATE TABLE store (
    storeid         smallserial          NOT NULL    PRIMARY KEY,
    store_name      varchar(30),
    streetaddr      varchar(30),
    city            varchar(20),
    stateprov       char(2),
    postalcode      char(6),
    manager         varchar(25)
);

CREATE TABLE transxn (
    transxnid       serial          NOT NULL    PRIMARY KEY,
    transxndate     date            DEFAULT now(),
    store           smallint         references store(storeid)
);

