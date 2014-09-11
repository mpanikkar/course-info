
-- Having a 'drop database' line here means you can run the script over and over again until you get it right.
-- This script could be used to create your entire database in one go; you could share it with teammates or the professor very easily.

-- This is a sample database to hold "things".

drop database if exists thingbase;
create database thingbase;

-- The following line is not SQL but is a psql command for switching to the specified database to run all the following commands.
-- If you don't do this, the tables will be created in the default database 'postgres' instead of your new database.
-- If the database is already created, you could specify the database on the command line like this: psql -U postgres -d database -f filepath

\c thingbase;


-- Now we're in the database we created.  Let's make some tables.

-- I like to put a 'drop table' command just before my 'create table' command.  
-- That way I can run the same script over and over until I get it right.

-- This is an example: a table of "things"

drop table if exists things;
create table things (
  id		serial			PRIMARY KEY,
  name		varchar(20)		NOT NULL,
  weight	numeric	,
  color		char(6)
  );
  
-- You can create another table right after that, since we're already working in the right place.

drop table if exists stuff;
create table stuff (
  id			serial			PRIMARY KEY,
  code			char(3)			UNIQUE,
  description	varchar(40)
  );