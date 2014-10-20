
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
DROP TABLE IF EXISTS transxn_line CASCADE;
DROP TABLE IF EXISTS brand CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS transxn CASCADE;
DROP TABLE IF EXISTS store CASCADE;




CREATE TABLE category (
    -- departments, categories, and subcategories are all represented by this table
    categoryid      serial          NOT NULL    PRIMARY KEY,
    description     varchar(25),
    parent_cat      integer         NULL    references category(categoryid) 
);

CREATE TABLE brand (
    brandid         serial          NOT NULL    PRIMARY KEY,
    brandname       varchar(25)
);

CREATE TABLE product (
    sku             char(10)        NOT NULL    PRIMARY KEY,
    description     varchar(35),
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

CREATE TABLE transxn_line (
    transxn         integer         references transxn(transxnid),
    product         char(10)        references product(sku),
    quantity        smallint,
    PRIMARY KEY (product,transxn)
);


-- create some stores
insert into store (storeid,store_name,streetaddr,city,stateprov,postalcode,manager) values (1,'Downtown Phoenix','123 central street','Phoenix','AZ','85123','Bob Jones');
insert into store (storeid,store_name,streetaddr,city,stateprov,postalcode,manager) values (2,'Uptown Phoenix','456 upper ave','Phoenix','AZ','85321','Nancy Johnson');
insert into store (storeid,store_name,streetaddr,city,stateprov,postalcode,manager) values (3,'Santa Fe','500 west st','Santa Fe','NM','77526','Harry Lopez');
insert into store (storeid,store_name,streetaddr,city,stateprov,postalcode,manager) values (4,'LA flagship store','222 Washington Ave','Beverly Hills','CA','90210','Mary Smith');
insert into store (storeid,store_name,streetaddr,city,stateprov,postalcode,manager) values (5,'Tuscon','1001 nowhere road','Tucson','AZ','85558','Max Chung');






-- create the top-level category which "department" categories fall under
INSERT INTO category ( categoryid, description, parent_cat ) values (0,'uncategorized',0);


-- create brand names
insert into brand (brandid,brandname) values(1,'Happy Juice');
insert into brand (brandid,brandname) values(2,'Fruity Juice');
insert into brand (brandid,brandname) values(3,'Super Fruit');
insert into brand (brandid,brandname) values(4,'RC');
insert into brand (brandid,brandname) values(5,'Coke');
insert into brand (brandid,brandname) values(6,'Barqs');
insert into brand (brandid,brandname) values(7,'Napa Valley');
insert into brand (brandid,brandname) values(8,'Vin de France');
insert into brand (brandid,brandname) values(9,'Alaska Vineyards');
insert into brand (brandid,brandname) values(10,'Old Millwater');
insert into brand (brandid,brandname) values(11,'Bud');
insert into brand (brandid,brandname) values(12,'Tsingtao');
insert into brand (brandid,brandname) values(13,'Guinness');
insert into brand (brandid,brandname) values(14,'Tempe Microbrew');
insert into brand (brandid,brandname) values(15,'Scotch Distillery');
insert into brand (brandid,brandname) values(16,'Cubas Best');
insert into brand (brandid,brandname) values(17,'EuroRum');
insert into brand (brandid,brandname) values(18,'CookieSelect');
insert into brand (brandid,brandname) values(19,'SweetTooth');
insert into brand (brandid,brandname) values(20,'Blue Ribbon');
insert into brand (brandid,brandname) values(21,'Idaho Pride');
insert into brand (brandid,brandname) values(22,'Pretend Mexican');
insert into brand (brandid,brandname) values(23,'Werthers');
insert into brand (brandid,brandname) values(24,'Gold Medal');
insert into brand (brandid,brandname) values(25,'Local Oven');
insert into brand (brandid,brandname) values(26,'BorderSouth');
insert into brand (brandid,brandname) values(27,'Aunt Millie');
insert into brand (brandid,brandname) values(28,'QueenCreek Olive Mill');
insert into brand (brandid,brandname) values(29,'O-Changs');
insert into brand (brandid,brandname) values(30,'General Kelloggs');


-- create products and categories
insert into category (categoryid, description, parent_cat) values (1,'Beverage',0);
insert into category (categoryid, description, parent_cat) values (5,'Juice',1);
insert into category (categoryid, description, parent_cat) values (17,'Orange Juice',5);
insert into product (sku,category,brand,description,unitprice) values ('abc1234567',17,1,'Fresh Squeezed 48oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000007',17,2,'Orange-Pineapple 46oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000008',17,2,'Orange-Banana 46oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000009',17,3,'Extra Pulpy 38oz',4.99);
insert into category (categoryid, description, parent_cat) values (18,'Apple Juice',5);
insert into product (sku,category,brand,description,unitprice) values ('abc1000011',18,1,'Apple Juice 48oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000012',18,1,'Apple Cider 44oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000013',18,2,'Apple-Cherry 46oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000014',18,3,'Sour Apple 38oz',4.99);
insert into category (categoryid, description, parent_cat) values (19,'Blended Juice',5);
insert into product (sku,category,brand,description,unitprice) values ('abc1000015',19,2,'Orange-Banana 46oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000016',19,2,'Pomegranate-Lime 46oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000018',19,3,'Fig-Banana Smoothie 16oz',4.99);
insert into category (categoryid, description, parent_cat) values (20,'Misc Juice',5);
insert into product (sku,category,brand,description,unitprice) values ('abc1000199',20,3,'Blueberry Smoothie 16oz',4.99);
insert into product (sku,category,brand,description,unitprice) values ('bde1010121',20,1,'Pineapple Juice 48oz',4.99);
insert into category (categoryid, description, parent_cat) values (6,'Soft Drinks',1);
insert into category (categoryid, description, parent_cat) values (21,'Cola',6);
insert into product (sku,category,brand,description,unitprice) values ('abc1010102',21,4,'Cola 6-pack',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000025',21,4,'Cola 24-pack',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000026',21,5,'Classic 20-pack',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000227',21,5,'Classic 6-pack',4.99);
insert into category (categoryid, description, parent_cat) values (22,'Root Beer',6);
insert into product (sku,category,brand,description,unitprice) values ('abc1000028',22,4,'Root Beer 6-pack',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000029',22,6,'Home Style Rootbeer 6-pack',4.99);
insert into category (categoryid, description, parent_cat) values (7,'Wine',1);
insert into category (categoryid, description, parent_cat) values (23,'Red Wine',7);
insert into product (sku,category,brand,description,unitprice) values ('abc1000033',23,7,'Merlot',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000034',23,7,'Cabernet',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000035',23,8,'Caberlot',4.99);
insert into category (categoryid, description, parent_cat) values (24,'White Wine',7);
insert into product (sku,category,brand,description,unitprice) values ('abc1000036',24,8,'Pinot Grigio',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000037',24,8,'Riesling',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000038',24,7,'White Zinfandel',4.99);
insert into category (categoryid, description, parent_cat) values (25,'Rose Wine',7);
insert into product (sku,category,brand,description,unitprice) values ('abc1000039',25,7,'Pink Zinfandel',4.99);
insert into category (categoryid, description, parent_cat) values (26,'Box Wine',7);
insert into product (sku,category,brand,description,unitprice) values ('abc1000040',26,9,'Chianti-in-a-box',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000044',26,9,'Pinot-in-a-box',4.99);
insert into category (categoryid, description, parent_cat) values (8,'Beer',1);
insert into category (categoryid, description, parent_cat) values (27,'Domestic Beer',8);
insert into product (sku,category,brand,description,unitprice) values ('abc1000047',27,10,'Lite Beer 12-pk',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000048',27,10,'Original 12-pk',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000049',27,11,'Classic 12-pk',4.99);
insert into category (categoryid, description, parent_cat) values (28,'Import Beer',8);
insert into product (sku,category,brand,description,unitprice) values ('abc1000051',28,12,'Tsingtao 12-pk',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000052',28,13,'Guinness Stout 6-pk',4.99);
insert into category (categoryid, description, parent_cat) values (29,'Microbrew',8);
insert into product (sku,category,brand,description,unitprice) values ('abc1000054',29,14,'Tempe Microbrew 8-pk',4.99);
insert into category (categoryid, description, parent_cat) values (9,'Liquor',1);
insert into category (categoryid, description, parent_cat) values (30,'Whiskey',9);
insert into product (sku,category,brand,description,unitprice) values ('abc1000057',30,9,'Paper Bag Whiskey',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000058',30,15,'Black Label',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000059',30,15,'Blue Label',4.99);
insert into category (categoryid, description, parent_cat) values (31,'Rum',9);
insert into product (sku,category,brand,description,unitprice) values ('abc1000061',31,9,'Paper Bag Rum',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000062',31,16,'Dark Rum',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000063',31,16,'Light Rum',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000064',31,17,'Coconut Rum',4.99);
insert into category (categoryid, description, parent_cat) values (2,'Snacks',0);
insert into category (categoryid, description, parent_cat) values (10,'Cookies',2);
insert into category (categoryid, description, parent_cat) values (32,'Chocolate Cookies',10);
insert into product (sku,category,brand,description,unitprice) values ('abc1000068',32,18,'Extra Chippy',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000069',32,19,'Chewy Chippers',4.99);
insert into category (categoryid, description, parent_cat) values (33,'Sandwich Cookies',10);
insert into product (sku,category,brand,description,unitprice) values ('abc1000071',33,19,'Extra Sticky',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000072',33,20,'Vanilla Stuffed',4.99);
insert into category (categoryid, description, parent_cat) values (34,'Sugar Cookies',10);
insert into product (sku,category,brand,description,unitprice) values ('abc1000074',34,20,'Dentists Bane',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000075',34,18,'Christmas Cookies',4.99);
insert into category (categoryid, description, parent_cat) values (11,'Chips',2);
insert into category (categoryid, description, parent_cat) values (35,'Potato Chips',11);
insert into product (sku,category,brand,description,unitprice) values ('abc1000078',35,21,'Ripple Chips',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000079',35,21,'Kettle Chips',4.99);
insert into category (categoryid, description, parent_cat) values (36,'Corn Chips',11);
insert into product (sku,category,brand,description,unitprice) values ('abc1000081',36,22,'Nacho Chips',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000082',36,22,'Party Dip Chips',4.99);
insert into category (categoryid, description, parent_cat) values (12,'Candy',2);
insert into category (categoryid, description, parent_cat) values (37,'Hard Candies',12);
insert into product (sku,category,brand,description,unitprice) values ('abc1000085',37,23,'Butterscotch Candies',4.99);
insert into category (categoryid, description, parent_cat) values (38,'Chocolates',12);
insert into product (sku,category,brand,description,unitprice) values ('abc1000087',38,19,'Cookie bars',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000088',38,23,'Assorted Chocolates',4.99);
insert into category (categoryid, description, parent_cat) values (3,'Bakery',0);
insert into category (categoryid, description, parent_cat) values (13,'Bread',3);
insert into category (categoryid, description, parent_cat) values (39,'White Bread',13);
insert into product (sku,category,brand,description,unitprice) values ('abc1000092',39,24,'White loaf',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000093',39,25,'White sandwich loaf',4.99);
insert into category (categoryid, description, parent_cat) values (40,'Wheat Bread',13);
insert into product (sku,category,brand,description,unitprice) values ('abc1000095',40,24,'Wheat loaf',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000096',40,25,'Whole wheat loaf',4.99);
insert into category (categoryid, description, parent_cat) values (41,'Tortillas',13);
insert into product (sku,category,brand,description,unitprice) values ('abc1000098',41,22,'Large tortillas',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000099',41,26,'Medium tortilla pack',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000100',41,26,'Small tortilla pack',4.99);
insert into category (categoryid, description, parent_cat) values (42,'Hot Dog Buns',13);
insert into product (sku,category,brand,description,unitprice) values ('abc1000101',42,24,'Hotdog buns',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000103',42,25,'Hotdog rolls party size',4.99);
insert into category (categoryid, description, parent_cat) values (14,'Pastry',3);
insert into category (categoryid, description, parent_cat) values (43,'Pie',14);
insert into product (sku,category,brand,description,unitprice) values ('abc1000106',43,3,'Fig Pie',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000107',43,25,'Pear Pie',4.99);
insert into category (categoryid, description, parent_cat) values (44,'Cake',14);
insert into product (sku,category,brand,description,unitprice) values ('abc1000109',44,25,'Carrot cake',4.99);
insert into category (categoryid, description, parent_cat) values (45,'Donuts',14);
insert into product (sku,category,brand,description,unitprice) values ('abc1000111',45,19,'Dozen Donuts',4.99);
insert into category (categoryid, description, parent_cat) values (4,'Staples',0);
insert into category (categoryid, description, parent_cat) values (15,'Baking Supplies',4);
insert into category (categoryid, description, parent_cat) values (46,'Flour',15);
insert into product (sku,category,brand,description,unitprice) values ('abc1000115',46,24,'Bread flour',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000116',46,25,'Unbleached flour',4.99);
insert into category (categoryid, description, parent_cat) values (47,'Sugar',15);
insert into product (sku,category,brand,description,unitprice) values ('abc1000118',47,25,'Cake sugar',4.99);
insert into category (categoryid, description, parent_cat) values (48,'Baking Powder',15);
insert into product (sku,category,brand,description,unitprice) values ('abc1000120',48,27,'Baking powder can',4.99);
insert into category (categoryid, description, parent_cat) values (49,'Vegetable Oil',15);
insert into product (sku,category,brand,description,unitprice) values ('abc1000122',49,27,'Canola oil',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000123',49,28,'Olive oil',4.99);
insert into category (categoryid, description, parent_cat) values (16,'Cereals',4);
insert into category (categoryid, description, parent_cat) values (50,'Rice',16);
insert into product (sku,category,brand,description,unitprice) values ('abc1000126',50,29,'25lb Rice',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000127',50,29,'50lb Rice',4.99);
insert into category (categoryid, description, parent_cat) values (51,'Pasta',16);
insert into product (sku,category,brand,description,unitprice) values ('abc1000129',51,28,'Handmade spaghetti',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000130',51,29,'Rice noodles',4.99);
insert into category (categoryid, description, parent_cat) values (52,'Breakfast Cereal',16);
insert into product (sku,category,brand,description,unitprice) values ('abc1000132',52,30,'Wheatie-Os',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000133',52,30,'Raisin Flakes',4.99);
insert into product (sku,category,brand,description,unitprice) values ('abc1000134',52,24,'Bland Granola',4.99);




-- create some transactions

insert into transxn (transxnid,transxndate,store) values (1,'2013-10-01',4);
insert into transxn (transxnid,transxndate,store) values (2,'2013-10-02',4);
insert into transxn (transxnid,transxndate,store) values (3,'2013-10-03',5);
insert into transxn (transxnid,transxndate,store) values (4,'2013-10-04',3);
insert into transxn (transxnid,transxndate,store) values (5,'2013-10-05',3);
insert into transxn (transxnid,transxndate,store) values (6,'2013-10-06',3);
insert into transxn (transxnid,transxndate,store) values (7,'2013-10-07',5);
insert into transxn (transxnid,transxndate,store) values (8,'2013-10-08',4);
insert into transxn (transxnid,transxndate,store) values (9,'2013-10-09',3);
insert into transxn (transxnid,transxndate,store) values (10,'2013-10-10',2);
insert into transxn (transxnid,transxndate,store) values (11,'2013-10-11',2);
insert into transxn (transxnid,transxndate,store) values (12,'2013-10-12',3);
insert into transxn (transxnid,transxndate,store) values (13,'2013-10-13',3);
insert into transxn (transxnid,transxndate,store) values (14,'2013-10-14',1);
insert into transxn (transxnid,transxndate,store) values (15,'2013-10-15',1);
insert into transxn (transxnid,transxndate,store) values (16,'2013-10-16',4);
insert into transxn (transxnid,transxndate,store) values (17,'2013-10-17',5);
insert into transxn (transxnid,transxndate,store) values (18,'2013-10-18',1);
insert into transxn (transxnid,transxndate,store) values (19,'2013-10-19',3);
insert into transxn (transxnid,transxndate,store) values (20,'2013-10-20',4);
insert into transxn (transxnid,transxndate,store) values (21,'2013-10-21',2);
insert into transxn (transxnid,transxndate,store) values (22,'2013-10-22',5);
insert into transxn (transxnid,transxndate,store) values (23,'2013-10-23',3);
insert into transxn (transxnid,transxndate,store) values (24,'2013-10-24',4);
insert into transxn (transxnid,transxndate,store) values (25,'2013-10-25',2);
insert into transxn (transxnid,transxndate,store) values (26,'2013-10-26',4);
insert into transxn (transxnid,transxndate,store) values (27,'2013-10-27',5);
insert into transxn (transxnid,transxndate,store) values (28,'2013-10-28',3);
insert into transxn (transxnid,transxndate,store) values (29,'2013-10-29',4);
insert into transxn (transxnid,transxndate,store) values (30,'2013-10-30',5);
insert into transxn (transxnid,transxndate,store) values (31,'2013-10-31',2);
insert into transxn (transxnid,transxndate,store) values (32,'2013-11-01',2);
insert into transxn (transxnid,transxndate,store) values (33,'2013-11-02',3);
insert into transxn (transxnid,transxndate,store) values (34,'2013-11-03',5);
insert into transxn (transxnid,transxndate,store) values (35,'2013-11-04',4);
insert into transxn (transxnid,transxndate,store) values (36,'2013-11-05',1);
insert into transxn (transxnid,transxndate,store) values (37,'2013-11-06',5);
insert into transxn (transxnid,transxndate,store) values (38,'2013-11-07',4);
insert into transxn (transxnid,transxndate,store) values (39,'2013-11-08',1);
insert into transxn (transxnid,transxndate,store) values (40,'2013-11-09',2);
insert into transxn (transxnid,transxndate,store) values (41,'2013-11-10',2);
insert into transxn (transxnid,transxndate,store) values (42,'2013-11-11',1);
insert into transxn (transxnid,transxndate,store) values (43,'2013-11-12',1);
insert into transxn (transxnid,transxndate,store) values (44,'2013-11-13',5);
insert into transxn (transxnid,transxndate,store) values (45,'2013-11-14',2);
insert into transxn (transxnid,transxndate,store) values (46,'2013-11-15',1);
insert into transxn (transxnid,transxndate,store) values (47,'2013-11-16',5);
insert into transxn (transxnid,transxndate,store) values (48,'2013-11-17',5);
insert into transxn (transxnid,transxndate,store) values (49,'2013-11-18',4);
insert into transxn (transxnid,transxndate,store) values (50,'2013-11-19',1);
insert into transxn (transxnid,transxndate,store) values (51,'2013-11-20',3);
insert into transxn (transxnid,transxndate,store) values (52,'2013-11-21',1);
insert into transxn (transxnid,transxndate,store) values (53,'2013-11-22',2);
insert into transxn (transxnid,transxndate,store) values (54,'2013-11-23',1);
insert into transxn (transxnid,transxndate,store) values (55,'2013-11-24',3);
insert into transxn (transxnid,transxndate,store) values (56,'2013-11-25',2);
insert into transxn (transxnid,transxndate,store) values (57,'2013-11-26',5);
insert into transxn (transxnid,transxndate,store) values (58,'2013-11-27',3);
insert into transxn (transxnid,transxndate,store) values (59,'2013-11-28',5);
insert into transxn (transxnid,transxndate,store) values (60,'2013-11-29',4);
insert into transxn (transxnid,transxndate,store) values (61,'2013-11-30',4);
insert into transxn (transxnid,transxndate,store) values (62,'2013-12-01',4);
insert into transxn (transxnid,transxndate,store) values (63,'2013-12-02',5);
insert into transxn (transxnid,transxndate,store) values (64,'2013-12-03',5);
insert into transxn (transxnid,transxndate,store) values (65,'2013-12-04',2);
insert into transxn (transxnid,transxndate,store) values (66,'2013-12-05',5);
insert into transxn (transxnid,transxndate,store) values (67,'2013-12-06',4);
insert into transxn (transxnid,transxndate,store) values (68,'2013-12-07',4);
insert into transxn (transxnid,transxndate,store) values (69,'2013-12-08',4);
insert into transxn (transxnid,transxndate,store) values (70,'2013-12-09',3);
insert into transxn (transxnid,transxndate,store) values (71,'2013-12-10',3);
insert into transxn (transxnid,transxndate,store) values (72,'2013-12-11',3);
insert into transxn (transxnid,transxndate,store) values (73,'2013-12-12',3);
insert into transxn (transxnid,transxndate,store) values (74,'2013-12-13',3);
insert into transxn (transxnid,transxndate,store) values (75,'2013-12-14',4);
insert into transxn (transxnid,transxndate,store) values (76,'2013-12-15',5);
insert into transxn (transxnid,transxndate,store) values (77,'2013-12-16',4);
insert into transxn (transxnid,transxndate,store) values (78,'2013-12-17',4);
insert into transxn (transxnid,transxndate,store) values (79,'2013-12-18',2);
insert into transxn (transxnid,transxndate,store) values (80,'2013-12-19',4);
insert into transxn (transxnid,transxndate,store) values (81,'2013-12-20',5);
insert into transxn (transxnid,transxndate,store) values (82,'2013-12-21',5);
insert into transxn (transxnid,transxndate,store) values (83,'2013-12-22',5);
insert into transxn (transxnid,transxndate,store) values (84,'2013-12-23',4);
insert into transxn (transxnid,transxndate,store) values (85,'2013-12-24',4);
insert into transxn (transxnid,transxndate,store) values (86,'2013-12-25',2);
insert into transxn (transxnid,transxndate,store) values (87,'2013-12-26',2);
insert into transxn (transxnid,transxndate,store) values (88,'2013-12-27',5);
insert into transxn (transxnid,transxndate,store) values (89,'2013-12-28',5);
insert into transxn (transxnid,transxndate,store) values (90,'2013-12-29',4);
insert into transxn (transxnid,transxndate,store) values (91,'2013-12-30',4);
insert into transxn (transxnid,transxndate,store) values (92,'2013-12-31',1);
insert into transxn (transxnid,transxndate,store) values (93,'2014-01-01',4);
insert into transxn (transxnid,transxndate,store) values (94,'2014-01-02',3);
insert into transxn (transxnid,transxndate,store) values (95,'2014-01-03',5);
insert into transxn (transxnid,transxndate,store) values (96,'2014-01-04',3);
insert into transxn (transxnid,transxndate,store) values (97,'2014-01-05',5);
insert into transxn (transxnid,transxndate,store) values (98,'2014-01-06',4);
insert into transxn (transxnid,transxndate,store) values (99,'2014-01-07',2);
insert into transxn (transxnid,transxndate,store) values (100,'2014-01-08',2);
insert into transxn (transxnid,transxndate,store) values (101,'2014-01-09',3);
insert into transxn (transxnid,transxndate,store) values (102,'2014-01-10',2);
insert into transxn (transxnid,transxndate,store) values (103,'2014-01-11',5);
insert into transxn (transxnid,transxndate,store) values (104,'2014-01-12',2);
insert into transxn (transxnid,transxndate,store) values (105,'2014-01-13',4);
insert into transxn (transxnid,transxndate,store) values (106,'2014-01-14',4);
insert into transxn (transxnid,transxndate,store) values (107,'2014-01-15',1);
insert into transxn (transxnid,transxndate,store) values (108,'2014-01-16',4);
insert into transxn (transxnid,transxndate,store) values (109,'2014-01-17',3);
insert into transxn (transxnid,transxndate,store) values (110,'2014-01-18',3);
insert into transxn (transxnid,transxndate,store) values (111,'2014-01-19',3);
insert into transxn (transxnid,transxndate,store) values (112,'2014-01-20',5);
insert into transxn (transxnid,transxndate,store) values (113,'2014-01-21',2);
insert into transxn (transxnid,transxndate,store) values (114,'2014-01-22',5);
insert into transxn (transxnid,transxndate,store) values (115,'2014-01-23',5);
insert into transxn (transxnid,transxndate,store) values (116,'2014-01-24',2);
insert into transxn (transxnid,transxndate,store) values (117,'2014-01-25',5);
insert into transxn (transxnid,transxndate,store) values (118,'2014-01-26',4);
insert into transxn (transxnid,transxndate,store) values (119,'2014-01-27',3);
insert into transxn (transxnid,transxndate,store) values (120,'2014-01-28',5);
insert into transxn (transxnid,transxndate,store) values (121,'2014-01-29',5);
insert into transxn (transxnid,transxndate,store) values (122,'2014-01-30',1);
insert into transxn (transxnid,transxndate,store) values (123,'2014-01-31',1);
insert into transxn (transxnid,transxndate,store) values (124,'2014-02-01',2);
insert into transxn (transxnid,transxndate,store) values (125,'2014-02-02',5);
insert into transxn (transxnid,transxndate,store) values (126,'2014-02-03',4);
insert into transxn (transxnid,transxndate,store) values (127,'2014-02-04',2);
insert into transxn (transxnid,transxndate,store) values (128,'2014-02-05',4);
insert into transxn (transxnid,transxndate,store) values (129,'2014-02-06',1);
insert into transxn (transxnid,transxndate,store) values (130,'2014-02-07',2);
insert into transxn (transxnid,transxndate,store) values (131,'2014-02-08',3);
insert into transxn (transxnid,transxndate,store) values (132,'2014-02-09',2);
insert into transxn (transxnid,transxndate,store) values (133,'2014-02-10',1);
insert into transxn (transxnid,transxndate,store) values (134,'2014-02-11',3);
insert into transxn (transxnid,transxndate,store) values (135,'2014-02-12',2);
insert into transxn (transxnid,transxndate,store) values (136,'2014-02-13',1);
insert into transxn (transxnid,transxndate,store) values (137,'2014-02-14',5);
insert into transxn (transxnid,transxndate,store) values (138,'2014-02-15',2);
insert into transxn (transxnid,transxndate,store) values (139,'2014-02-16',2);
insert into transxn (transxnid,transxndate,store) values (140,'2014-02-17',1);
insert into transxn (transxnid,transxndate,store) values (141,'2014-02-18',1);
insert into transxn (transxnid,transxndate,store) values (142,'2014-02-19',3);
insert into transxn (transxnid,transxndate,store) values (143,'2014-02-20',5);
insert into transxn (transxnid,transxndate,store) values (144,'2014-02-21',5);
insert into transxn (transxnid,transxndate,store) values (145,'2014-02-22',5);
insert into transxn (transxnid,transxndate,store) values (146,'2014-02-23',2);
insert into transxn (transxnid,transxndate,store) values (147,'2014-02-24',1);
insert into transxn (transxnid,transxndate,store) values (148,'2014-02-25',2);
insert into transxn (transxnid,transxndate,store) values (149,'2014-02-26',1);
insert into transxn (transxnid,transxndate,store) values (150,'2014-02-27',4);
insert into transxn (transxnid,transxndate,store) values (151,'2014-02-28',5);
insert into transxn (transxnid,transxndate,store) values (152,'2014-03-01',3);
insert into transxn (transxnid,transxndate,store) values (153,'2014-03-02',1);
insert into transxn (transxnid,transxndate,store) values (154,'2014-03-03',1);
insert into transxn (transxnid,transxndate,store) values (155,'2014-03-04',4);
insert into transxn (transxnid,transxndate,store) values (156,'2014-03-05',2);
insert into transxn (transxnid,transxndate,store) values (157,'2014-03-06',4);
insert into transxn (transxnid,transxndate,store) values (158,'2014-03-07',4);
insert into transxn (transxnid,transxndate,store) values (159,'2014-03-08',1);
insert into transxn (transxnid,transxndate,store) values (160,'2014-03-09',1);
insert into transxn (transxnid,transxndate,store) values (161,'2014-03-10',1);
insert into transxn (transxnid,transxndate,store) values (162,'2014-03-11',2);
insert into transxn (transxnid,transxndate,store) values (163,'2014-03-12',2);
insert into transxn (transxnid,transxndate,store) values (164,'2014-03-13',3);
insert into transxn (transxnid,transxndate,store) values (165,'2014-03-14',3);
insert into transxn (transxnid,transxndate,store) values (166,'2014-03-15',4);
insert into transxn (transxnid,transxndate,store) values (167,'2014-03-16',1);
insert into transxn (transxnid,transxndate,store) values (168,'2014-03-17',5);
insert into transxn (transxnid,transxndate,store) values (169,'2014-03-18',5);
insert into transxn (transxnid,transxndate,store) values (170,'2014-03-19',3);
insert into transxn (transxnid,transxndate,store) values (171,'2014-03-20',2);
insert into transxn (transxnid,transxndate,store) values (172,'2014-03-21',3);
insert into transxn (transxnid,transxndate,store) values (173,'2014-03-22',1);
insert into transxn (transxnid,transxndate,store) values (174,'2014-03-23',1);
insert into transxn (transxnid,transxndate,store) values (175,'2014-03-24',5);
insert into transxn (transxnid,transxndate,store) values (176,'2014-03-25',3);
insert into transxn (transxnid,transxndate,store) values (177,'2014-03-26',1);
insert into transxn (transxnid,transxndate,store) values (178,'2014-03-27',3);
insert into transxn (transxnid,transxndate,store) values (179,'2014-03-28',1);
insert into transxn (transxnid,transxndate,store) values (180,'2014-03-29',3);
insert into transxn (transxnid,transxndate,store) values (181,'2014-03-30',5);
insert into transxn (transxnid,transxndate,store) values (182,'2014-03-31',3);
insert into transxn (transxnid,transxndate,store) values (183,'2014-04-01',5);
insert into transxn (transxnid,transxndate,store) values (184,'2014-04-02',4);
insert into transxn (transxnid,transxndate,store) values (185,'2014-04-03',1);
insert into transxn (transxnid,transxndate,store) values (186,'2014-04-04',4);
insert into transxn (transxnid,transxndate,store) values (187,'2014-04-05',2);
insert into transxn (transxnid,transxndate,store) values (188,'2014-04-06',5);
insert into transxn (transxnid,transxndate,store) values (189,'2014-04-07',3);
insert into transxn (transxnid,transxndate,store) values (190,'2014-04-08',3);
insert into transxn (transxnid,transxndate,store) values (191,'2014-04-09',5);
insert into transxn (transxnid,transxndate,store) values (192,'2014-04-10',1);
insert into transxn (transxnid,transxndate,store) values (193,'2014-04-11',3);
insert into transxn (transxnid,transxndate,store) values (194,'2014-04-12',2);
insert into transxn (transxnid,transxndate,store) values (195,'2014-04-13',3);
insert into transxn (transxnid,transxndate,store) values (196,'2014-04-14',2);
insert into transxn (transxnid,transxndate,store) values (197,'2014-04-15',1);
insert into transxn (transxnid,transxndate,store) values (198,'2014-04-16',4);
insert into transxn (transxnid,transxndate,store) values (199,'2014-04-17',5);
insert into transxn (transxnid,transxndate,store) values (200,'2014-04-18',5);
insert into transxn (transxnid,transxndate,store) values (201,'2014-04-19',2);
insert into transxn (transxnid,transxndate,store) values (202,'2014-04-20',4);
insert into transxn (transxnid,transxndate,store) values (203,'2014-04-21',4);
insert into transxn (transxnid,transxndate,store) values (204,'2014-04-22',1);
insert into transxn (transxnid,transxndate,store) values (205,'2014-04-23',4);
insert into transxn (transxnid,transxndate,store) values (206,'2014-04-24',4);
insert into transxn (transxnid,transxndate,store) values (207,'2014-04-25',3);
insert into transxn (transxnid,transxndate,store) values (208,'2014-04-26',2);
insert into transxn (transxnid,transxndate,store) values (209,'2014-04-27',2);
insert into transxn (transxnid,transxndate,store) values (210,'2014-04-28',1);
insert into transxn (transxnid,transxndate,store) values (211,'2014-04-29',4);
insert into transxn (transxnid,transxndate,store) values (212,'2014-04-30',3);
insert into transxn (transxnid,transxndate,store) values (213,'2014-05-01',3);
insert into transxn (transxnid,transxndate,store) values (214,'2014-05-02',3);
insert into transxn (transxnid,transxndate,store) values (215,'2014-05-03',3);
insert into transxn (transxnid,transxndate,store) values (216,'2014-05-04',1);
insert into transxn (transxnid,transxndate,store) values (217,'2014-05-05',2);
insert into transxn (transxnid,transxndate,store) values (218,'2014-05-06',5);
insert into transxn (transxnid,transxndate,store) values (219,'2014-05-07',1);
insert into transxn (transxnid,transxndate,store) values (220,'2014-05-08',2);
insert into transxn (transxnid,transxndate,store) values (221,'2014-05-09',1);
insert into transxn (transxnid,transxndate,store) values (222,'2014-05-10',1);
insert into transxn (transxnid,transxndate,store) values (223,'2014-05-11',2);
insert into transxn (transxnid,transxndate,store) values (224,'2014-05-12',5);
insert into transxn (transxnid,transxndate,store) values (225,'2014-05-13',1);
insert into transxn (transxnid,transxndate,store) values (226,'2014-05-14',4);
insert into transxn (transxnid,transxndate,store) values (227,'2014-05-15',5);
insert into transxn (transxnid,transxndate,store) values (228,'2014-05-16',4);
insert into transxn (transxnid,transxndate,store) values (229,'2014-05-17',2);
insert into transxn (transxnid,transxndate,store) values (230,'2014-05-18',3);
insert into transxn (transxnid,transxndate,store) values (231,'2014-05-19',3);
insert into transxn (transxnid,transxndate,store) values (232,'2014-05-20',3);
insert into transxn (transxnid,transxndate,store) values (233,'2014-05-21',3);
insert into transxn (transxnid,transxndate,store) values (234,'2014-05-22',1);
insert into transxn (transxnid,transxndate,store) values (235,'2014-05-23',4);
insert into transxn (transxnid,transxndate,store) values (236,'2014-05-24',3);
insert into transxn (transxnid,transxndate,store) values (237,'2014-05-25',4);
insert into transxn (transxnid,transxndate,store) values (238,'2014-05-26',5);
insert into transxn (transxnid,transxndate,store) values (239,'2014-05-27',5);
insert into transxn (transxnid,transxndate,store) values (240,'2014-05-28',3);
insert into transxn (transxnid,transxndate,store) values (241,'2014-05-29',5);
insert into transxn (transxnid,transxndate,store) values (242,'2014-05-30',1);
insert into transxn (transxnid,transxndate,store) values (243,'2014-05-31',5);
insert into transxn (transxnid,transxndate,store) values (244,'2014-06-01',1);
insert into transxn (transxnid,transxndate,store) values (245,'2014-06-02',2);
insert into transxn (transxnid,transxndate,store) values (246,'2014-06-03',5);
insert into transxn (transxnid,transxndate,store) values (247,'2014-06-04',4);
insert into transxn (transxnid,transxndate,store) values (248,'2014-06-05',3);
insert into transxn (transxnid,transxndate,store) values (249,'2014-06-06',1);
insert into transxn (transxnid,transxndate,store) values (250,'2014-06-07',4);



-- add transxn line data

insert into transxn_line( transxn, product, quantity ) values (1,'abc1000064',1);
insert into transxn_line( transxn, product, quantity ) values (1,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (1,'abc1000028',3);
insert into transxn_line( transxn, product, quantity ) values (1,'abc1000087',1);
insert into transxn_line( transxn, product, quantity ) values (1,'abc1000078',3);
insert into transxn_line( transxn, product, quantity ) values (1,'abc1000118',4);
insert into transxn_line( transxn, product, quantity ) values (1,'abc1010102',1);
insert into transxn_line( transxn, product, quantity ) values (2,'abc1000100',4);
insert into transxn_line( transxn, product, quantity ) values (2,'abc1000085',3);
insert into transxn_line( transxn, product, quantity ) values (2,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (3,'abc1000026',2);
insert into transxn_line( transxn, product, quantity ) values (3,'abc1000120',1);
insert into transxn_line( transxn, product, quantity ) values (3,'abc1000052',3);
insert into transxn_line( transxn, product, quantity ) values (4,'abc1000069',1);
insert into transxn_line( transxn, product, quantity ) values (4,'abc1000044',1);
insert into transxn_line( transxn, product, quantity ) values (4,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (4,'abc1000049',1);
insert into transxn_line( transxn, product, quantity ) values (4,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (4,'abc1000052',2);
insert into transxn_line( transxn, product, quantity ) values (5,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (5,'abc1000057',3);
insert into transxn_line( transxn, product, quantity ) values (5,'abc1000115',1);
insert into transxn_line( transxn, product, quantity ) values (5,'abc1000079',3);
insert into transxn_line( transxn, product, quantity ) values (5,'abc1000127',3);
insert into transxn_line( transxn, product, quantity ) values (6,'abc1000015',1);
insert into transxn_line( transxn, product, quantity ) values (6,'abc1000044',1);
insert into transxn_line( transxn, product, quantity ) values (7,'abc1000068',3);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000012',3);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000036',2);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000040',1);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000103',2);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000057',3);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000052',3);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000028',2);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000071',4);
insert into transxn_line( transxn, product, quantity ) values (8,'abc1000081',4);
insert into transxn_line( transxn, product, quantity ) values (8,'bde1010121',2);
insert into transxn_line( transxn, product, quantity ) values (9,'abc1000133',4);
insert into transxn_line( transxn, product, quantity ) values (9,'abc1000040',2);
insert into transxn_line( transxn, product, quantity ) values (9,'abc1000026',3);
insert into transxn_line( transxn, product, quantity ) values (9,'abc1000058',4);
insert into transxn_line( transxn, product, quantity ) values (10,'abc1000085',2);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000099',1);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000062',4);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000103',2);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000082',1);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000116',2);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000033',4);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000132',3);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000038',4);
insert into transxn_line( transxn, product, quantity ) values (11,'abc1000227',2);
insert into transxn_line( transxn, product, quantity ) values (12,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (12,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (12,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (12,'abc1000078',4);
insert into transxn_line( transxn, product, quantity ) values (12,'abc1000120',2);
insert into transxn_line( transxn, product, quantity ) values (12,'abc1000052',3);
insert into transxn_line( transxn, product, quantity ) values (13,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (13,'abc1000120',2);
insert into transxn_line( transxn, product, quantity ) values (13,'abc1000100',2);
insert into transxn_line( transxn, product, quantity ) values (13,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (13,'abc1000123',1);
insert into transxn_line( transxn, product, quantity ) values (13,'abc1000012',4);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000133',4);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000069',1);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000106',4);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000040',3);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000092',1);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000015',4);
insert into transxn_line( transxn, product, quantity ) values (14,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (15,'abc1000118',2);
insert into transxn_line( transxn, product, quantity ) values (15,'abc1000044',4);
insert into transxn_line( transxn, product, quantity ) values (15,'abc1000120',1);
insert into transxn_line( transxn, product, quantity ) values (15,'abc1000040',3);
insert into transxn_line( transxn, product, quantity ) values (15,'abc1000015',1);
insert into transxn_line( transxn, product, quantity ) values (15,'abc1000071',4);
insert into transxn_line( transxn, product, quantity ) values (15,'abc1000116',1);
insert into transxn_line( transxn, product, quantity ) values (16,'abc1000075',1);
insert into transxn_line( transxn, product, quantity ) values (17,'abc1000118',4);
insert into transxn_line( transxn, product, quantity ) values (18,'abc1000087',2);
insert into transxn_line( transxn, product, quantity ) values (18,'abc1000096',2);
insert into transxn_line( transxn, product, quantity ) values (18,'abc1000088',3);
insert into transxn_line( transxn, product, quantity ) values (19,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000199',3);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000028',1);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000096',3);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000008',1);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000101',1);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1010102',2);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000026',1);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000120',3);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000123',3);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000132',4);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000093',1);
insert into transxn_line( transxn, product, quantity ) values (19,'abc1000068',4);
insert into transxn_line( transxn, product, quantity ) values (20,'abc1000012',4);
insert into transxn_line( transxn, product, quantity ) values (20,'abc1000062',2);
insert into transxn_line( transxn, product, quantity ) values (20,'abc1000088',3);
insert into transxn_line( transxn, product, quantity ) values (20,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (20,'abc1000079',2);
insert into transxn_line( transxn, product, quantity ) values (20,'abc1000016',1);
insert into transxn_line( transxn, product, quantity ) values (21,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (21,'abc1000098',4);
insert into transxn_line( transxn, product, quantity ) values (21,'abc1000061',2);
insert into transxn_line( transxn, product, quantity ) values (21,'abc1000122',4);
insert into transxn_line( transxn, product, quantity ) values (22,'abc1000037',1);
insert into transxn_line( transxn, product, quantity ) values (22,'abc1000038',2);
insert into transxn_line( transxn, product, quantity ) values (23,'abc1000093',1);
insert into transxn_line( transxn, product, quantity ) values (24,'abc1000100',1);
insert into transxn_line( transxn, product, quantity ) values (24,'abc1000037',2);
insert into transxn_line( transxn, product, quantity ) values (25,'abc1000059',1);
insert into transxn_line( transxn, product, quantity ) values (26,'abc1000009',4);
insert into transxn_line( transxn, product, quantity ) values (26,'abc1000082',4);
insert into transxn_line( transxn, product, quantity ) values (26,'abc1000107',2);
insert into transxn_line( transxn, product, quantity ) values (26,'abc1000079',1);
insert into transxn_line( transxn, product, quantity ) values (26,'abc1000120',1);
insert into transxn_line( transxn, product, quantity ) values (26,'abc1000087',4);
insert into transxn_line( transxn, product, quantity ) values (27,'abc1000044',4);
insert into transxn_line( transxn, product, quantity ) values (28,'abc1000088',1);
insert into transxn_line( transxn, product, quantity ) values (28,'abc1000051',4);
insert into transxn_line( transxn, product, quantity ) values (28,'abc1000227',4);
insert into transxn_line( transxn, product, quantity ) values (28,'abc1000116',2);
insert into transxn_line( transxn, product, quantity ) values (28,'abc1000109',4);
insert into transxn_line( transxn, product, quantity ) values (28,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (29,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (30,'abc1000036',1);
insert into transxn_line( transxn, product, quantity ) values (30,'abc1000071',3);
insert into transxn_line( transxn, product, quantity ) values (30,'abc1000106',1);
insert into transxn_line( transxn, product, quantity ) values (30,'abc1000107',3);
insert into transxn_line( transxn, product, quantity ) values (31,'abc1000028',1);
insert into transxn_line( transxn, product, quantity ) values (31,'abc1000016',1);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000122',3);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000051',4);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000071',4);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (32,'bde1010121',3);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000092',4);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000068',2);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1234567',4);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000052',3);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000079',2);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000130',4);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000088',3);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000118',4);
insert into transxn_line( transxn, product, quantity ) values (32,'abc1000028',1);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1000120',4);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1000048',3);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1000057',1);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1010102',2);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1000008',4);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1234567',4);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1000134',2);
insert into transxn_line( transxn, product, quantity ) values (33,'abc1000014',1);
insert into transxn_line( transxn, product, quantity ) values (34,'abc1000107',4);
insert into transxn_line( transxn, product, quantity ) values (34,'abc1000078',1);
insert into transxn_line( transxn, product, quantity ) values (35,'abc1000049',3);
insert into transxn_line( transxn, product, quantity ) values (36,'abc1000095',4);
insert into transxn_line( transxn, product, quantity ) values (36,'abc1000036',3);
insert into transxn_line( transxn, product, quantity ) values (36,'abc1000127',3);
insert into transxn_line( transxn, product, quantity ) values (36,'abc1000063',3);
insert into transxn_line( transxn, product, quantity ) values (36,'abc1000008',2);
insert into transxn_line( transxn, product, quantity ) values (36,'abc1000029',2);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000101',4);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000199',1);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000227',1);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000133',3);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000081',4);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000007',2);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000074',4);
insert into transxn_line( transxn, product, quantity ) values (37,'bde1010121',1);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000052',2);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000016',1);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000118',3);
insert into transxn_line( transxn, product, quantity ) values (37,'abc1000058',4);
insert into transxn_line( transxn, product, quantity ) values (38,'abc1000035',4);
insert into transxn_line( transxn, product, quantity ) values (39,'abc1000018',1);
insert into transxn_line( transxn, product, quantity ) values (39,'abc1000061',2);
insert into transxn_line( transxn, product, quantity ) values (39,'abc1000016',1);
insert into transxn_line( transxn, product, quantity ) values (39,'abc1000122',3);
insert into transxn_line( transxn, product, quantity ) values (39,'abc1000039',1);
insert into transxn_line( transxn, product, quantity ) values (39,'abc1000096',4);
insert into transxn_line( transxn, product, quantity ) values (39,'abc1000071',3);
insert into transxn_line( transxn, product, quantity ) values (40,'bde1010121',1);
insert into transxn_line( transxn, product, quantity ) values (40,'abc1000072',2);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000134',2);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000103',3);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000227',3);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000115',4);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000057',3);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000087',3);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000048',4);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000026',4);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000052',1);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000062',4);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000074',3);
insert into transxn_line( transxn, product, quantity ) values (41,'abc1000078',1);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000118',2);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000127',1);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000074',3);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000087',4);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000047',3);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000061',2);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (42,'abc1000072',1);
insert into transxn_line( transxn, product, quantity ) values (43,'abc1000058',2);
insert into transxn_line( transxn, product, quantity ) values (44,'abc1000036',1);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000014',3);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000085',3);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000127',3);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000118',4);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000133',3);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000078',3);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000116',2);
insert into transxn_line( transxn, product, quantity ) values (45,'abc1000049',1);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000026',3);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000133',1);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000069',1);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000096',4);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000035',1);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000008',3);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000061',2);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000038',1);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000126',2);
insert into transxn_line( transxn, product, quantity ) values (46,'abc1000101',1);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000096',3);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000120',1);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000133',3);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000115',1);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000035',3);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000013',2);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000106',4);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000029',1);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000227',1);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000026',4);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000049',3);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000011',1);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000036',4);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000101',2);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000052',3);
insert into transxn_line( transxn, product, quantity ) values (47,'abc1000069',1);
insert into transxn_line( transxn, product, quantity ) values (48,'abc1000199',1);
insert into transxn_line( transxn, product, quantity ) values (48,'abc1000079',4);

insert into transxn_line( transxn, product, quantity ) values (48,'abc1234567',2);
insert into transxn_line( transxn, product, quantity ) values (48,'abc1000025',2);
insert into transxn_line( transxn, product, quantity ) values (48,'abc1000092',1);

insert into transxn_line( transxn, product, quantity ) values (48,'abc1000040',4);
insert into transxn_line( transxn, product, quantity ) values (48,'abc1000127',3);
insert into transxn_line( transxn, product, quantity ) values (48,'abc1000087',2);
insert into transxn_line( transxn, product, quantity ) values (48,'abc1000101',1);
insert into transxn_line( transxn, product, quantity ) values (49,'abc1000107',3);
insert into transxn_line( transxn, product, quantity ) values (49,'abc1000057',1);
insert into transxn_line( transxn, product, quantity ) values (49,'abc1000061',1);
insert into transxn_line( transxn, product, quantity ) values (50,'abc1000100',4);
insert into transxn_line( transxn, product, quantity ) values (50,'abc1000069',1);
insert into transxn_line( transxn, product, quantity ) values (50,'abc1000008',1);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000068',4);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000087',3);

insert into transxn_line( transxn, product, quantity ) values (51,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000063',4);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000018',1);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000051',1);

insert into transxn_line( transxn, product, quantity ) values (51,'abc1000122',1);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000029',4);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000052',2);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000013',1);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000074',2);
insert into transxn_line( transxn, product, quantity ) values (51,'abc1000033',3);

insert into transxn_line( transxn, product, quantity ) values (52,'abc1000028',3);


insert into transxn_line( transxn, product, quantity ) values (53,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (53,'abc1000069',4);

insert into transxn_line( transxn, product, quantity ) values (53,'abc1000109',2);
insert into transxn_line( transxn, product, quantity ) values (53,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (53,'abc1000093',2);
insert into transxn_line( transxn, product, quantity ) values (53,'abc1000049',4);
insert into transxn_line( transxn, product, quantity ) values (53,'abc1000036',2);
insert into transxn_line( transxn, product, quantity ) values (54,'abc1000013',3);


insert into transxn_line( transxn, product, quantity ) values (55,'abc1000199',1);
insert into transxn_line( transxn, product, quantity ) values (55,'abc1000132',1);
insert into transxn_line( transxn, product, quantity ) values (56,'abc1000095',3);
insert into transxn_line( transxn, product, quantity ) values (56,'abc1000036',3);
insert into transxn_line( transxn, product, quantity ) values (56,'abc1000034',1);
insert into transxn_line( transxn, product, quantity ) values (56,'abc1000106',3);
insert into transxn_line( transxn, product, quantity ) values (56,'abc1000068',2);
insert into transxn_line( transxn, product, quantity ) values (57,'abc1000100',3);
insert into transxn_line( transxn, product, quantity ) values (57,'abc1000120',4);
insert into transxn_line( transxn, product, quantity ) values (57,'abc1000109',2);
insert into transxn_line( transxn, product, quantity ) values (58,'abc1000111',2);

insert into transxn_line( transxn, product, quantity ) values (59,'abc1000029',2);

insert into transxn_line( transxn, product, quantity ) values (59,'abc1000028',3);

insert into transxn_line( transxn, product, quantity ) values (59,'abc1000087',4);

insert into transxn_line( transxn, product, quantity ) values (59,'abc1000133',4);
insert into transxn_line( transxn, product, quantity ) values (59,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (59,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (60,'abc1000115',4);
insert into transxn_line( transxn, product, quantity ) values (60,'abc1000025',2);
insert into transxn_line( transxn, product, quantity ) values (60,'abc1000092',3);
insert into transxn_line( transxn, product, quantity ) values (60,'abc1000047',4);
insert into transxn_line( transxn, product, quantity ) values (60,'abc1000052',1);
insert into transxn_line( transxn, product, quantity ) values (60,'abc1000007',1);
insert into transxn_line( transxn, product, quantity ) values (61,'abc1000069',4);
insert into transxn_line( transxn, product, quantity ) values (61,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (62,'abc1000227',2);
insert into transxn_line( transxn, product, quantity ) values (63,'abc1000007',4);
insert into transxn_line( transxn, product, quantity ) values (64,'abc1000129',2);
insert into transxn_line( transxn, product, quantity ) values (64,'abc1000059',2);
insert into transxn_line( transxn, product, quantity ) values (64,'abc1000048',3);
insert into transxn_line( transxn, product, quantity ) values (64,'abc1000087',4);
insert into transxn_line( transxn, product, quantity ) values (65,'abc1000129',1);
insert into transxn_line( transxn, product, quantity ) values (65,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (65,'abc1000123',2);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000008',3);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000012',2);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000007',2);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000101',2);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000132',3);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000068',4);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000074',3);

insert into transxn_line( transxn, product, quantity ) values (66,'abc1000036',4);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000048',3);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000011',3);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000116',4);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000085',2);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000078',3);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000040',1);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000047',1);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000051',2);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000107',2);

insert into transxn_line( transxn, product, quantity ) values (66,'abc1000029',2);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000122',3);
insert into transxn_line( transxn, product, quantity ) values (66,'abc1000009',3);
insert into transxn_line( transxn, product, quantity ) values (67,'abc1000107',1);
insert into transxn_line( transxn, product, quantity ) values (67,'abc1000079',2);
insert into transxn_line( transxn, product, quantity ) values (68,'abc1000037',4);
insert into transxn_line( transxn, product, quantity ) values (68,'abc1000058',4);
insert into transxn_line( transxn, product, quantity ) values (68,'abc1000132',4);
insert into transxn_line( transxn, product, quantity ) values (69,'abc1000133',1);
insert into transxn_line( transxn, product, quantity ) values (69,'abc1000088',3);

insert into transxn_line( transxn, product, quantity ) values (69,'abc1000111',4);


insert into transxn_line( transxn, product, quantity ) values (69,'abc1000103',4);
insert into transxn_line( transxn, product, quantity ) values (69,'abc1000095',4);
insert into transxn_line( transxn, product, quantity ) values (69,'abc1000126',3);
insert into transxn_line( transxn, product, quantity ) values (69,'bde1010121',1);
insert into transxn_line( transxn, product, quantity ) values (69,'abc1000098',2);
insert into transxn_line( transxn, product, quantity ) values (69,'abc1000039',4);

insert into transxn_line( transxn, product, quantity ) values (69,'abc1000092',4);
insert into transxn_line( transxn, product, quantity ) values (70,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (70,'abc1000029',3);
insert into transxn_line( transxn, product, quantity ) values (70,'abc1000130',4);
insert into transxn_line( transxn, product, quantity ) values (70,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (70,'abc1000059',2);
insert into transxn_line( transxn, product, quantity ) values (70,'abc1000101',3);
insert into transxn_line( transxn, product, quantity ) values (71,'abc1000034',2);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000078',3);

insert into transxn_line( transxn, product, quantity ) values (72,'abc1000109',4);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000095',2);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000103',1);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000118',4);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000096',1);


insert into transxn_line( transxn, product, quantity ) values (72,'abc1000081',4);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000132',4);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (72,'abc1000133',1);

insert into transxn_line( transxn, product, quantity ) values (73,'abc1000071',2);
insert into transxn_line( transxn, product, quantity ) values (73,'abc1000026',1);
insert into transxn_line( transxn, product, quantity ) values (73,'abc1000072',3);
insert into transxn_line( transxn, product, quantity ) values (73,'abc1000134',2);

insert into transxn_line( transxn, product, quantity ) values (73,'abc1000098',1);
insert into transxn_line( transxn, product, quantity ) values (73,'abc1000016',4);
insert into transxn_line( transxn, product, quantity ) values (73,'abc1000058',4);
insert into transxn_line( transxn, product, quantity ) values (73,'abc1000036',1);

insert into transxn_line( transxn, product, quantity ) values (74,'abc1000120',3);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000118',4);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000038',3);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000129',3);


insert into transxn_line( transxn, product, quantity ) values (74,'abc1000095',3);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000074',2);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000058',3);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000061',2);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000107',2);

insert into transxn_line( transxn, product, quantity ) values (74,'abc1000096',4);

insert into transxn_line( transxn, product, quantity ) values (74,'abc1000085',3);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000069',3);


insert into transxn_line( transxn, product, quantity ) values (74,'abc1000068',2);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000044',3);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000028',1);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000071',1);
insert into transxn_line( transxn, product, quantity ) values (74,'abc1000039',2);
insert into transxn_line( transxn, product, quantity ) values (75,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000071',2);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000047',1);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000063',3);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000057',3);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000039',2);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000099',3);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000025',2);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000007',1);
insert into transxn_line( transxn, product, quantity ) values (76,'abc1000028',1);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000039',1);

insert into transxn_line( transxn, product, quantity ) values (77,'abc1000116',4);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000059',2);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000126',3);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000075',3);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000052',2);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000101',3);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000127',3);

insert into transxn_line( transxn, product, quantity ) values (77,'abc1000011',4);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000014',4);

insert into transxn_line( transxn, product, quantity ) values (77,'abc1000016',4);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000098',4);

insert into transxn_line( transxn, product, quantity ) values (77,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000035',2);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000092',4);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000049',3);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000068',4);
insert into transxn_line( transxn, product, quantity ) values (77,'abc1000038',2);
insert into transxn_line( transxn, product, quantity ) values (78,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (79,'abc1000133',2);
insert into transxn_line( transxn, product, quantity ) values (80,'abc1000048',3);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000058',4);

insert into transxn_line( transxn, product, quantity ) values (81,'abc1000011',3);

insert into transxn_line( transxn, product, quantity ) values (81,'abc1000075',2);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000079',3);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000099',3);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000039',1);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000098',4);

insert into transxn_line( transxn, product, quantity ) values (81,'abc1000068',4);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000109',4);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000126',1);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000199',3);

insert into transxn_line( transxn, product, quantity ) values (81,'abc1000227',2);
insert into transxn_line( transxn, product, quantity ) values (81,'abc1000103',1);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1234567',4);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000123',4);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000025',4);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000078',3);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000074',4);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000126',1);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000018',4);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000037',3);
insert into transxn_line( transxn, product, quantity ) values (82,'abc1000085',3);
insert into transxn_line( transxn, product, quantity ) values (83,'abc1000071',3);
insert into transxn_line( transxn, product, quantity ) values (83,'abc1000061',1);
insert into transxn_line( transxn, product, quantity ) values (83,'abc1000095',2);
insert into transxn_line( transxn, product, quantity ) values (83,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (83,'abc1000059',3);
insert into transxn_line( transxn, product, quantity ) values (84,'bde1010121',2);
insert into transxn_line( transxn, product, quantity ) values (84,'abc1000012',3);
insert into transxn_line( transxn, product, quantity ) values (85,'abc1000064',3);
insert into transxn_line( transxn, product, quantity ) values (85,'abc1000049',4);
insert into transxn_line( transxn, product, quantity ) values (85,'abc1234567',1);
insert into transxn_line( transxn, product, quantity ) values (86,'abc1000074',3);
insert into transxn_line( transxn, product, quantity ) values (86,'abc1000130',4);
insert into transxn_line( transxn, product, quantity ) values (86,'abc1000123',2);
insert into transxn_line( transxn, product, quantity ) values (86,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (86,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (86,'abc1000096',2);
insert into transxn_line( transxn, product, quantity ) values (87,'abc1000075',4);
insert into transxn_line( transxn, product, quantity ) values (87,'abc1000100',2);
insert into transxn_line( transxn, product, quantity ) values (88,'abc1000036',2);
insert into transxn_line( transxn, product, quantity ) values (88,'abc1000078',3);
insert into transxn_line( transxn, product, quantity ) values (88,'abc1000064',1);
insert into transxn_line( transxn, product, quantity ) values (88,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (89,'abc1000049',3);
insert into transxn_line( transxn, product, quantity ) values (89,'abc1000082',3);
insert into transxn_line( transxn, product, quantity ) values (89,'abc1000057',4);
insert into transxn_line( transxn, product, quantity ) values (89,'abc1000036',2);
insert into transxn_line( transxn, product, quantity ) values (89,'abc1000075',3);
insert into transxn_line( transxn, product, quantity ) values (89,'abc1000025',1);
insert into transxn_line( transxn, product, quantity ) values (90,'abc1000035',2);
insert into transxn_line( transxn, product, quantity ) values (91,'abc1000069',4);
insert into transxn_line( transxn, product, quantity ) values (91,'abc1000034',2);
insert into transxn_line( transxn, product, quantity ) values (91,'abc1000039',1);
insert into transxn_line( transxn, product, quantity ) values (91,'abc1000068',2);
insert into transxn_line( transxn, product, quantity ) values (91,'abc1000044',3);
insert into transxn_line( transxn, product, quantity ) values (92,'abc1000044',1);
insert into transxn_line( transxn, product, quantity ) values (92,'abc1000134',2);
insert into transxn_line( transxn, product, quantity ) values (92,'abc1000075',3);

insert into transxn_line( transxn, product, quantity ) values (92,'abc1000059',1);
insert into transxn_line( transxn, product, quantity ) values (92,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (92,'abc1000008',1);
insert into transxn_line( transxn, product, quantity ) values (92,'abc1000047',1);
insert into transxn_line( transxn, product, quantity ) values (92,'abc1000038',4);

insert into transxn_line( transxn, product, quantity ) values (93,'abc1000049',1);
insert into transxn_line( transxn, product, quantity ) values (93,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (93,'abc1000095',1);
insert into transxn_line( transxn, product, quantity ) values (93,'abc1000107',1);
insert into transxn_line( transxn, product, quantity ) values (93,'abc1000079',4);
insert into transxn_line( transxn, product, quantity ) values (93,'abc1000048',3);


insert into transxn_line( transxn, product, quantity ) values (93,'abc1000038',2);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000130',1);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000051',4);
insert into transxn_line( transxn, product, quantity ) values (94,'bde1010121',3);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000009',1);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000134',3);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000016',3);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000026',4);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000111',4);
insert into transxn_line( transxn, product, quantity ) values (94,'abc1000033',1);
insert into transxn_line( transxn, product, quantity ) values (95,'abc1000127',2);

insert into transxn_line( transxn, product, quantity ) values (95,'abc1000012',1);
insert into transxn_line( transxn, product, quantity ) values (95,'abc1234567',2);
insert into transxn_line( transxn, product, quantity ) values (95,'abc1000123',4);

insert into transxn_line( transxn, product, quantity ) values (95,'abc1000062',3);
insert into transxn_line( transxn, product, quantity ) values (95,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (95,'abc1000199',4);
insert into transxn_line( transxn, product, quantity ) values (95,'abc1000035',4);
insert into transxn_line( transxn, product, quantity ) values (95,'abc1000109',2);
insert into transxn_line( transxn, product, quantity ) values (96,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (96,'abc1000088',3);
insert into transxn_line( transxn, product, quantity ) values (96,'abc1000052',2);
insert into transxn_line( transxn, product, quantity ) values (96,'abc1000069',1);
insert into transxn_line( transxn, product, quantity ) values (96,'abc1000034',3);
insert into transxn_line( transxn, product, quantity ) values (97,'bde1010121',1);


insert into transxn_line( transxn, product, quantity ) values (97,'abc1000049',2);

insert into transxn_line( transxn, product, quantity ) values (97,'abc1000101',4);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000015',3);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1010102',4);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000103',3);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000093',4);

insert into transxn_line( transxn, product, quantity ) values (97,'abc1000111',1);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000044',4);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000123',1);

insert into transxn_line( transxn, product, quantity ) values (97,'abc1000095',3);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000106',3);


insert into transxn_line( transxn, product, quantity ) values (97,'abc1000035',3);
insert into transxn_line( transxn, product, quantity ) values (97,'abc1000130',2);
insert into transxn_line( transxn, product, quantity ) values (98,'abc1000096',2);

insert into transxn_line( transxn, product, quantity ) values (98,'abc1000123',1);



insert into transxn_line( transxn, product, quantity ) values (99,'abc1000107',3);
insert into transxn_line( transxn, product, quantity ) values (100,'abc1000029',2);
insert into transxn_line( transxn, product, quantity ) values (100,'abc1000122',3);
insert into transxn_line( transxn, product, quantity ) values (100,'abc1000034',1);
insert into transxn_line( transxn, product, quantity ) values (100,'abc1000028',3);
insert into transxn_line( transxn, product, quantity ) values (100,'abc1000025',1);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000134',3);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000039',2);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000107',1);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000074',2);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000040',2);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000101',2);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1234567',4);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000072',2);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000025',2);
insert into transxn_line( transxn, product, quantity ) values (101,'abc1000103',2);
insert into transxn_line( transxn, product, quantity ) values (102,'abc1000087',2);
insert into transxn_line( transxn, product, quantity ) values (102,'abc1000082',4);
insert into transxn_line( transxn, product, quantity ) values (102,'abc1000103',3);
insert into transxn_line( transxn, product, quantity ) values (102,'abc1000013',2);
insert into transxn_line( transxn, product, quantity ) values (102,'abc1000085',3);
insert into transxn_line( transxn, product, quantity ) values (102,'abc1000011',1);
insert into transxn_line( transxn, product, quantity ) values (102,'abc1000009',2);
insert into transxn_line( transxn, product, quantity ) values (103,'abc1000026',2);
insert into transxn_line( transxn, product, quantity ) values (103,'abc1000062',2);
insert into transxn_line( transxn, product, quantity ) values (103,'abc1000035',1);
insert into transxn_line( transxn, product, quantity ) values (103,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (103,'abc1000013',1);
insert into transxn_line( transxn, product, quantity ) values (103,'abc1000034',1);
insert into transxn_line( transxn, product, quantity ) values (104,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (104,'abc1000008',4);
insert into transxn_line( transxn, product, quantity ) values (104,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (104,'abc1000115',2);
insert into transxn_line( transxn, product, quantity ) values (104,'abc1000047',4);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000052',1);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000029',1);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000093',2);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000009',4);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000068',4);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000049',1);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000059',4);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000048',2);

insert into transxn_line( transxn, product, quantity ) values (105,'abc1000058',1);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000126',4);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000071',1);
insert into transxn_line( transxn, product, quantity ) values (105,'bde1010121',3);

insert into transxn_line( transxn, product, quantity ) values (105,'abc1000018',3);
insert into transxn_line( transxn, product, quantity ) values (105,'abc1000034',3);
insert into transxn_line( transxn, product, quantity ) values (106,'abc1000122',1);
insert into transxn_line( transxn, product, quantity ) values (106,'abc1000098',4);
insert into transxn_line( transxn, product, quantity ) values (107,'abc1000103',1);
insert into transxn_line( transxn, product, quantity ) values (107,'abc1000062',1);
insert into transxn_line( transxn, product, quantity ) values (108,'abc1000063',3);
insert into transxn_line( transxn, product, quantity ) values (108,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (108,'abc1000082',1);
insert into transxn_line( transxn, product, quantity ) values (108,'abc1000127',2);
insert into transxn_line( transxn, product, quantity ) values (108,'abc1000134',2);
insert into transxn_line( transxn, product, quantity ) values (109,'abc1000126',4);
insert into transxn_line( transxn, product, quantity ) values (109,'abc1000087',1);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000081',1);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000069',3);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000079',1);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000103',4);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000015',4);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000111',4);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000008',1);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000058',3);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000025',1);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1234567',4);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000106',4);
insert into transxn_line( transxn, product, quantity ) values (110,'bde1010121',1);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000082',3);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000133',3);
insert into transxn_line( transxn, product, quantity ) values (110,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (111,'abc1000057',2);
insert into transxn_line( transxn, product, quantity ) values (111,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (111,'abc1000074',3);
insert into transxn_line( transxn, product, quantity ) values (111,'abc1000069',4);
insert into transxn_line( transxn, product, quantity ) values (111,'abc1000037',4);
insert into transxn_line( transxn, product, quantity ) values (112,'abc1000058',1);
insert into transxn_line( transxn, product, quantity ) values (112,'abc1000047',4);
insert into transxn_line( transxn, product, quantity ) values (113,'abc1000014',3);
insert into transxn_line( transxn, product, quantity ) values (113,'abc1000015',1);
insert into transxn_line( transxn, product, quantity ) values (113,'abc1234567',1);
insert into transxn_line( transxn, product, quantity ) values (114,'abc1000126',1);
insert into transxn_line( transxn, product, quantity ) values (114,'abc1000028',3);
insert into transxn_line( transxn, product, quantity ) values (114,'abc1000133',4);
insert into transxn_line( transxn, product, quantity ) values (114,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (114,'abc1000035',4);
insert into transxn_line( transxn, product, quantity ) values (114,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (115,'abc1000109',1);



insert into transxn_line( transxn, product, quantity ) values (115,'abc1000130',4);
insert into transxn_line( transxn, product, quantity ) values (115,'abc1000047',2);

insert into transxn_line( transxn, product, quantity ) values (115,'abc1000116',4);
insert into transxn_line( transxn, product, quantity ) values (116,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (117,'abc1000126',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000096',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000109',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000087',1);



insert into transxn_line( transxn, product, quantity ) values (118,'abc1000062',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000049',3);

insert into transxn_line( transxn, product, quantity ) values (118,'abc1000134',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000036',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000101',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000071',4);

insert into transxn_line( transxn, product, quantity ) values (118,'abc1234567',2);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000133',2);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000007',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000068',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000013',1);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000051',1);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000064',1);

insert into transxn_line( transxn, product, quantity ) values (118,'abc1000092',2);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000126',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000040',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000123',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000035',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000075',1);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000081',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000038',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000052',4);

insert into transxn_line( transxn, product, quantity ) values (118,'abc1000072',1);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000107',4);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000100',3);
insert into transxn_line( transxn, product, quantity ) values (118,'abc1000028',1);


insert into transxn_line( transxn, product, quantity ) values (119,'abc1000044',2);
insert into transxn_line( transxn, product, quantity ) values (119,'abc1000059',1);
insert into transxn_line( transxn, product, quantity ) values (119,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (119,'abc1000082',2);
insert into transxn_line( transxn, product, quantity ) values (120,'abc1000044',1);
insert into transxn_line( transxn, product, quantity ) values (120,'abc1000101',1);
insert into transxn_line( transxn, product, quantity ) values (120,'abc1000132',3);
insert into transxn_line( transxn, product, quantity ) values (120,'abc1000037',1);
insert into transxn_line( transxn, product, quantity ) values (120,'abc1000007',1);
insert into transxn_line( transxn, product, quantity ) values (120,'abc1000095',4);
insert into transxn_line( transxn, product, quantity ) values (120,'abc1000028',4);

insert into transxn_line( transxn, product, quantity ) values (120,'abc1000227',3);

insert into transxn_line( transxn, product, quantity ) values (121,'abc1000047',3);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000072',4);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000016',4);


insert into transxn_line( transxn, product, quantity ) values (121,'abc1000098',4);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000029',4);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000034',2);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000126',4);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000044',4);
insert into transxn_line( transxn, product, quantity ) values (121,'abc1000040',4);





insert into transxn_line( transxn, product, quantity ) values (122,'abc1000129',2);

insert into transxn_line( transxn, product, quantity ) values (122,'abc1000122',1);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000227',2);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000118',1);

insert into transxn_line( transxn, product, quantity ) values (122,'abc1000115',4);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000096',2);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000100',3);


insert into transxn_line( transxn, product, quantity ) values (122,'abc1000013',4);


insert into transxn_line( transxn, product, quantity ) values (122,'abc1000085',1);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000087',2);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000134',1);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000040',1);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000093',3);



insert into transxn_line( transxn, product, quantity ) values (122,'abc1000064',3);

insert into transxn_line( transxn, product, quantity ) values (122,'abc1000039',1);


insert into transxn_line( transxn, product, quantity ) values (122,'abc1000015',4);

insert into transxn_line( transxn, product, quantity ) values (122,'abc1000130',4);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000072',1);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000107',2);
insert into transxn_line( transxn, product, quantity ) values (122,'abc1000014',1);


insert into transxn_line( transxn, product, quantity ) values (123,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (123,'abc1000085',4);
insert into transxn_line( transxn, product, quantity ) values (123,'abc1000064',4);
insert into transxn_line( transxn, product, quantity ) values (123,'abc1000118',3);
insert into transxn_line( transxn, product, quantity ) values (124,'abc1000033',4);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1000109',2);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1000034',2);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1000098',2);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1000199',1);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1000029',3);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1000039',1);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1000028',3);
insert into transxn_line( transxn, product, quantity ) values (125,'abc1010102',1);
insert into transxn_line( transxn, product, quantity ) values (126,'abc1000047',2);
insert into transxn_line( transxn, product, quantity ) values (126,'abc1000134',3);
insert into transxn_line( transxn, product, quantity ) values (127,'abc1000048',2);
insert into transxn_line( transxn, product, quantity ) values (127,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (128,'abc1000068',3);

insert into transxn_line( transxn, product, quantity ) values (128,'abc1000106',1);


insert into transxn_line( transxn, product, quantity ) values (128,'abc1000078',4);
insert into transxn_line( transxn, product, quantity ) values (128,'abc1000013',3);

insert into transxn_line( transxn, product, quantity ) values (128,'abc1000109',3);
insert into transxn_line( transxn, product, quantity ) values (128,'abc1000129',2);


insert into transxn_line( transxn, product, quantity ) values (128,'abc1000085',1);
insert into transxn_line( transxn, product, quantity ) values (129,'abc1000227',1);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000085',3);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000075',3);

insert into transxn_line( transxn, product, quantity ) values (130,'abc1000133',3);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000116',2);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000038',3);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000087',1);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000049',1);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000115',1);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000063',2);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000227',4);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000123',2);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000120',3);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000118',2);

insert into transxn_line( transxn, product, quantity ) values (130,'abc1000058',3);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000099',4);
insert into transxn_line( transxn, product, quantity ) values (130,'abc1000035',3);
insert into transxn_line( transxn, product, quantity ) values (131,'abc1000012',4);
insert into transxn_line( transxn, product, quantity ) values (131,'abc1000071',1);
insert into transxn_line( transxn, product, quantity ) values (131,'abc1000133',3);
insert into transxn_line( transxn, product, quantity ) values (131,'abc1000098',2);
insert into transxn_line( transxn, product, quantity ) values (132,'abc1000227',2);
insert into transxn_line( transxn, product, quantity ) values (132,'abc1000059',1);
insert into transxn_line( transxn, product, quantity ) values (132,'abc1000039',4);
insert into transxn_line( transxn, product, quantity ) values (132,'abc1000068',1);
insert into transxn_line( transxn, product, quantity ) values (132,'abc1000096',4);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1234567',2);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1000072',4);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1000118',4);

insert into transxn_line( transxn, product, quantity ) values (133,'abc1000061',4);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1000051',2);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (133,'abc1000116',4);

insert into transxn_line( transxn, product, quantity ) values (134,'abc1000011',3);
insert into transxn_line( transxn, product, quantity ) values (134,'abc1000064',2);



insert into transxn_line( transxn, product, quantity ) values (135,'abc1000074',1);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000227',2);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000101',3);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000107',3);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000115',3);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000096',1);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000122',4);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000011',1);



insert into transxn_line( transxn, product, quantity ) values (135,'abc1000099',4);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1010102',1);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000093',3);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000130',4);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000078',4);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000081',1);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000082',1);


insert into transxn_line( transxn, product, quantity ) values (135,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000044',3);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000014',3);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000134',2);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000035',4);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000133',3);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000106',1);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000075',1);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000049',4);

insert into transxn_line( transxn, product, quantity ) values (135,'abc1000064',4);
insert into transxn_line( transxn, product, quantity ) values (135,'abc1000092',4);
insert into transxn_line( transxn, product, quantity ) values (135,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (136,'abc1000082',4);
insert into transxn_line( transxn, product, quantity ) values (136,'abc1000100',3);
insert into transxn_line( transxn, product, quantity ) values (136,'abc1000029',1);
insert into transxn_line( transxn, product, quantity ) values (136,'abc1000012',3);
insert into transxn_line( transxn, product, quantity ) values (136,'abc1000098',1);
insert into transxn_line( transxn, product, quantity ) values (137,'abc1000038',2);
insert into transxn_line( transxn, product, quantity ) values (137,'abc1000096',4);
insert into transxn_line( transxn, product, quantity ) values (137,'abc1000072',1);
insert into transxn_line( transxn, product, quantity ) values (138,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (139,'abc1000011',3);
insert into transxn_line( transxn, product, quantity ) values (139,'abc1000012',2);
insert into transxn_line( transxn, product, quantity ) values (139,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (139,'abc1000014',1);
insert into transxn_line( transxn, product, quantity ) values (140,'abc1000015',3);
insert into transxn_line( transxn, product, quantity ) values (140,'abc1000009',3);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000101',1);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000008',3);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000047',4);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000057',1);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000127',1);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000111',3);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000075',3);
insert into transxn_line( transxn, product, quantity ) values (141,'abc1000079',4);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000088',4);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000085',4);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000096',2);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000016',3);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000028',3);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000037',2);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000007',4);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000199',2);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000044',4);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000107',1);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000058',1);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000082',1);
insert into transxn_line( transxn, product, quantity ) values (142,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000068',1);

insert into transxn_line( transxn, product, quantity ) values (143,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000106',2);

insert into transxn_line( transxn, product, quantity ) values (143,'abc1000127',1);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000012',3);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000034',4);



insert into transxn_line( transxn, product, quantity ) values (143,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000132',3);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000063',3);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000013',1);
insert into transxn_line( transxn, product, quantity ) values (143,'abc1000129',1);

insert into transxn_line( transxn, product, quantity ) values (143,'abc1000116',4);
insert into transxn_line( transxn, product, quantity ) values (144,'abc1000008',1);
insert into transxn_line( transxn, product, quantity ) values (144,'abc1000033',2);
insert into transxn_line( transxn, product, quantity ) values (144,'abc1000036',3);
insert into transxn_line( transxn, product, quantity ) values (144,'abc1000130',4);
insert into transxn_line( transxn, product, quantity ) values (144,'abc1000059',1);
insert into transxn_line( transxn, product, quantity ) values (145,'abc1000012',2);
insert into transxn_line( transxn, product, quantity ) values (146,'abc1000047',3);
insert into transxn_line( transxn, product, quantity ) values (147,'abc1000096',2);
insert into transxn_line( transxn, product, quantity ) values (148,'abc1000122',4);
insert into transxn_line( transxn, product, quantity ) values (148,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (148,'abc1000074',3);

insert into transxn_line( transxn, product, quantity ) values (149,'abc1000007',4);

insert into transxn_line( transxn, product, quantity ) values (149,'abc1000099',1);
insert into transxn_line( transxn, product, quantity ) values (149,'abc1000074',3);
insert into transxn_line( transxn, product, quantity ) values (149,'abc1000132',1);
insert into transxn_line( transxn, product, quantity ) values (149,'abc1000126',2);
insert into transxn_line( transxn, product, quantity ) values (149,'abc1000134',3);
insert into transxn_line( transxn, product, quantity ) values (149,'abc1000047',3);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000026',1);

insert into transxn_line( transxn, product, quantity ) values (150,'abc1000016',1);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000122',1);

insert into transxn_line( transxn, product, quantity ) values (150,'abc1000103',2);
insert into transxn_line( transxn, product, quantity ) values (150,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000040',2);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000018',2);

insert into transxn_line( transxn, product, quantity ) values (150,'abc1000012',2);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000087',1);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000134',1);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000011',2);

insert into transxn_line( transxn, product, quantity ) values (150,'abc1000126',2);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000013',1);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000133',4);
insert into transxn_line( transxn, product, quantity ) values (150,'abc1000123',4);
insert into transxn_line( transxn, product, quantity ) values (151,'abc1000106',4);
insert into transxn_line( transxn, product, quantity ) values (151,'abc1000068',1);
insert into transxn_line( transxn, product, quantity ) values (151,'abc1000078',3);
insert into transxn_line( transxn, product, quantity ) values (152,'abc1000118',1);
insert into transxn_line( transxn, product, quantity ) values (152,'abc1000048',3);
insert into transxn_line( transxn, product, quantity ) values (152,'abc1000018',2);
insert into transxn_line( transxn, product, quantity ) values (152,'abc1000116',2);
insert into transxn_line( transxn, product, quantity ) values (152,'abc1000029',4);
insert into transxn_line( transxn, product, quantity ) values (153,'abc1000063',4);
insert into transxn_line( transxn, product, quantity ) values (153,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (153,'abc1234567',3);
insert into transxn_line( transxn, product, quantity ) values (153,'abc1000123',2);
insert into transxn_line( transxn, product, quantity ) values (154,'abc1000009',2);
insert into transxn_line( transxn, product, quantity ) values (154,'abc1000039',4);
insert into transxn_line( transxn, product, quantity ) values (154,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (155,'abc1000049',1);
insert into transxn_line( transxn, product, quantity ) values (155,'abc1000134',3);
insert into transxn_line( transxn, product, quantity ) values (156,'abc1000120',2);
insert into transxn_line( transxn, product, quantity ) values (156,'abc1000101',1);
insert into transxn_line( transxn, product, quantity ) values (156,'abc1000009',1);
insert into transxn_line( transxn, product, quantity ) values (156,'abc1000040',3);
insert into transxn_line( transxn, product, quantity ) values (156,'abc1000016',4);
insert into transxn_line( transxn, product, quantity ) values (156,'abc1000082',2);
insert into transxn_line( transxn, product, quantity ) values (157,'abc1000013',2);
insert into transxn_line( transxn, product, quantity ) values (157,'abc1000095',3);
insert into transxn_line( transxn, product, quantity ) values (157,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (157,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (157,'abc1234567',4);
insert into transxn_line( transxn, product, quantity ) values (157,'abc1000111',1);
insert into transxn_line( transxn, product, quantity ) values (158,'abc1000034',3);
insert into transxn_line( transxn, product, quantity ) values (158,'abc1000071',1);
insert into transxn_line( transxn, product, quantity ) values (158,'abc1000115',4);
insert into transxn_line( transxn, product, quantity ) values (158,'abc1000118',3);
insert into transxn_line( transxn, product, quantity ) values (159,'abc1000034',3);
insert into transxn_line( transxn, product, quantity ) values (159,'abc1000016',2);


insert into transxn_line( transxn, product, quantity ) values (159,'abc1000126',4);
insert into transxn_line( transxn, product, quantity ) values (160,'abc1000057',2);
insert into transxn_line( transxn, product, quantity ) values (160,'abc1000134',1);


insert into transxn_line( transxn, product, quantity ) values (160,'abc1000079',3);
insert into transxn_line( transxn, product, quantity ) values (160,'abc1000127',2);
insert into transxn_line( transxn, product, quantity ) values (161,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (161,'abc1000081',4);
insert into transxn_line( transxn, product, quantity ) values (161,'abc1000062',1);
insert into transxn_line( transxn, product, quantity ) values (161,'abc1000028',3);
insert into transxn_line( transxn, product, quantity ) values (161,'abc1000085',1);
insert into transxn_line( transxn, product, quantity ) values (161,'abc1000100',1);
insert into transxn_line( transxn, product, quantity ) values (161,'abc1000123',2);

insert into transxn_line( transxn, product, quantity ) values (162,'abc1000118',1);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000132',1);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000120',4);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000015',4);
insert into transxn_line( transxn, product, quantity ) values (162,'bde1010121',3);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000058',3);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000133',1);

insert into transxn_line( transxn, product, quantity ) values (162,'abc1000093',2);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000107',3);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000095',2);
insert into transxn_line( transxn, product, quantity ) values (162,'abc1000088',3);
insert into transxn_line( transxn, product, quantity ) values (163,'bde1010121',1);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000072',4);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000052',1);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000026',4);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000081',2);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000014',3);

insert into transxn_line( transxn, product, quantity ) values (163,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000069',3);


insert into transxn_line( transxn, product, quantity ) values (163,'abc1000037',4);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000099',1);
insert into transxn_line( transxn, product, quantity ) values (163,'abc1000115',4);


insert into transxn_line( transxn, product, quantity ) values (163,'abc1000013',3);

insert into transxn_line( transxn, product, quantity ) values (163,'abc1000118',3);

insert into transxn_line( transxn, product, quantity ) values (164,'abc1000058',1);
insert into transxn_line( transxn, product, quantity ) values (165,'abc1000120',4);
insert into transxn_line( transxn, product, quantity ) values (165,'abc1000101',4);
insert into transxn_line( transxn, product, quantity ) values (165,'abc1000130',3);
insert into transxn_line( transxn, product, quantity ) values (165,'abc1000037',1);
insert into transxn_line( transxn, product, quantity ) values (165,'abc1000068',4);
insert into transxn_line( transxn, product, quantity ) values (165,'abc1000012',3);
insert into transxn_line( transxn, product, quantity ) values (165,'abc1000133',1);
insert into transxn_line( transxn, product, quantity ) values (166,'abc1000048',3);
insert into transxn_line( transxn, product, quantity ) values (166,'abc1000058',4);
insert into transxn_line( transxn, product, quantity ) values (167,'abc1000072',3);
insert into transxn_line( transxn, product, quantity ) values (168,'abc1000038',2);
insert into transxn_line( transxn, product, quantity ) values (168,'abc1000064',4);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000033',1);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000068',3);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000038',4);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000106',4);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000059',1);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000100',1);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000061',1);
insert into transxn_line( transxn, product, quantity ) values (169,'abc1000039',1);
insert into transxn_line( transxn, product, quantity ) values (170,'abc1000051',4);
insert into transxn_line( transxn, product, quantity ) values (170,'abc1000116',4);
insert into transxn_line( transxn, product, quantity ) values (171,'abc1000079',2);
insert into transxn_line( transxn, product, quantity ) values (171,'abc1000100',4);
insert into transxn_line( transxn, product, quantity ) values (171,'abc1000061',3);

insert into transxn_line( transxn, product, quantity ) values (171,'abc1000075',2);

insert into transxn_line( transxn, product, quantity ) values (171,'abc1000036',1);
insert into transxn_line( transxn, product, quantity ) values (171,'abc1000034',1);
insert into transxn_line( transxn, product, quantity ) values (171,'abc1000035',2);
insert into transxn_line( transxn, product, quantity ) values (172,'abc1000052',1);

insert into transxn_line( transxn, product, quantity ) values (172,'abc1000062',2);
insert into transxn_line( transxn, product, quantity ) values (172,'abc1000047',3);

insert into transxn_line( transxn, product, quantity ) values (173,'abc1000037',1);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000013',4);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000011',4);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000038',1);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000018',2);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000062',4);

insert into transxn_line( transxn, product, quantity ) values (173,'abc1000109',2);

insert into transxn_line( transxn, product, quantity ) values (173,'abc1000120',3);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000069',4);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000051',2);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000040',1);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000026',2);
insert into transxn_line( transxn, product, quantity ) values (173,'abc1000093',2);
insert into transxn_line( transxn, product, quantity ) values (174,'abc1000096',3);
insert into transxn_line( transxn, product, quantity ) values (174,'abc1000062',1);
insert into transxn_line( transxn, product, quantity ) values (175,'abc1000106',1);

insert into transxn_line( transxn, product, quantity ) values (175,'abc1000051',4);

insert into transxn_line( transxn, product, quantity ) values (175,'abc1000016',3);


insert into transxn_line( transxn, product, quantity ) values (175,'abc1010102',2);

insert into transxn_line( transxn, product, quantity ) values (175,'abc1000227',3);
insert into transxn_line( transxn, product, quantity ) values (175,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (175,'abc1000035',1);
insert into transxn_line( transxn, product, quantity ) values (175,'abc1000122',1);
insert into transxn_line( transxn, product, quantity ) values (175,'abc1000061',2);


insert into transxn_line( transxn, product, quantity ) values (175,'abc1000044',1);
insert into transxn_line( transxn, product, quantity ) values (175,'abc1000038',4);




insert into transxn_line( transxn, product, quantity ) values (175,'abc1000018',4);
insert into transxn_line( transxn, product, quantity ) values (175,'abc1000132',1);
insert into transxn_line( transxn, product, quantity ) values (176,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (176,'bde1010121',3);
insert into transxn_line( transxn, product, quantity ) values (176,'abc1000013',2);
insert into transxn_line( transxn, product, quantity ) values (177,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (177,'abc1000014',3);
insert into transxn_line( transxn, product, quantity ) values (177,'abc1000071',3);
insert into transxn_line( transxn, product, quantity ) values (177,'abc1000011',1);
insert into transxn_line( transxn, product, quantity ) values (178,'abc1000012',4);

insert into transxn_line( transxn, product, quantity ) values (178,'abc1000082',3);
insert into transxn_line( transxn, product, quantity ) values (178,'abc1000047',4);
insert into transxn_line( transxn, product, quantity ) values (178,'abc1000106',3);

insert into transxn_line( transxn, product, quantity ) values (178,'abc1000052',3);
insert into transxn_line( transxn, product, quantity ) values (178,'abc1000095',1);
insert into transxn_line( transxn, product, quantity ) values (178,'abc1000134',1);
insert into transxn_line( transxn, product, quantity ) values (178,'abc1000079',2);
insert into transxn_line( transxn, product, quantity ) values (179,'bde1010121',3);
insert into transxn_line( transxn, product, quantity ) values (179,'abc1000106',1);
insert into transxn_line( transxn, product, quantity ) values (179,'abc1000095',4);
insert into transxn_line( transxn, product, quantity ) values (179,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (179,'abc1000126',2);
insert into transxn_line( transxn, product, quantity ) values (179,'abc1000037',3);
insert into transxn_line( transxn, product, quantity ) values (179,'abc1000057',1);
insert into transxn_line( transxn, product, quantity ) values (180,'abc1000037',1);
insert into transxn_line( transxn, product, quantity ) values (180,'abc1000106',3);
insert into transxn_line( transxn, product, quantity ) values (180,'abc1000120',2);
insert into transxn_line( transxn, product, quantity ) values (180,'abc1000059',1);
insert into transxn_line( transxn, product, quantity ) values (180,'abc1000103',3);
insert into transxn_line( transxn, product, quantity ) values (180,'abc1000111',4);
insert into transxn_line( transxn, product, quantity ) values (181,'abc1000100',1);
insert into transxn_line( transxn, product, quantity ) values (181,'abc1000118',2);
insert into transxn_line( transxn, product, quantity ) values (181,'abc1000033',2);
insert into transxn_line( transxn, product, quantity ) values (181,'abc1000120',2);
insert into transxn_line( transxn, product, quantity ) values (181,'abc1000081',3);
insert into transxn_line( transxn, product, quantity ) values (181,'abc1000009',3);
insert into transxn_line( transxn, product, quantity ) values (181,'abc1000130',2);
insert into transxn_line( transxn, product, quantity ) values (182,'abc1000099',2);
insert into transxn_line( transxn, product, quantity ) values (182,'abc1000103',2);
insert into transxn_line( transxn, product, quantity ) values (182,'abc1000015',4);
insert into transxn_line( transxn, product, quantity ) values (182,'abc1000098',4);
insert into transxn_line( transxn, product, quantity ) values (182,'abc1000115',2);
insert into transxn_line( transxn, product, quantity ) values (182,'abc1000107',4);
insert into transxn_line( transxn, product, quantity ) values (182,'abc1000007',2);
insert into transxn_line( transxn, product, quantity ) values (183,'abc1000227',1);
insert into transxn_line( transxn, product, quantity ) values (183,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (183,'abc1000085',4);
insert into transxn_line( transxn, product, quantity ) values (183,'abc1000014',1);
insert into transxn_line( transxn, product, quantity ) values (184,'abc1000012',4);
insert into transxn_line( transxn, product, quantity ) values (184,'abc1000061',1);

insert into transxn_line( transxn, product, quantity ) values (184,'abc1000058',2);
insert into transxn_line( transxn, product, quantity ) values (184,'abc1000034',4);
insert into transxn_line( transxn, product, quantity ) values (184,'abc1000118',3);
insert into transxn_line( transxn, product, quantity ) values (184,'abc1000018',3);

insert into transxn_line( transxn, product, quantity ) values (185,'abc1000072',3);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000134',3);

insert into transxn_line( transxn, product, quantity ) values (185,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000015',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000111',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000038',4);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000092',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000120',4);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000048',3);

insert into transxn_line( transxn, product, quantity ) values (185,'abc1000064',1);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000081',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000093',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000033',3);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000028',2);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000012',3);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000132',4);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000199',1);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000058',3);
insert into transxn_line( transxn, product, quantity ) values (185,'abc1000095',4);
insert into transxn_line( transxn, product, quantity ) values (186,'abc1000071',4);
insert into transxn_line( transxn, product, quantity ) values (186,'abc1000014',1);
insert into transxn_line( transxn, product, quantity ) values (186,'abc1000099',2);
insert into transxn_line( transxn, product, quantity ) values (187,'abc1000199',1);
insert into transxn_line( transxn, product, quantity ) values (187,'abc1000109',1);
insert into transxn_line( transxn, product, quantity ) values (187,'abc1000007',1);
insert into transxn_line( transxn, product, quantity ) values (187,'abc1000034',1);
insert into transxn_line( transxn, product, quantity ) values (187,'abc1000014',2);
insert into transxn_line( transxn, product, quantity ) values (188,'abc1000120',1);
insert into transxn_line( transxn, product, quantity ) values (188,'abc1000199',2);
insert into transxn_line( transxn, product, quantity ) values (188,'abc1000052',1);
insert into transxn_line( transxn, product, quantity ) values (189,'abc1000044',4);
insert into transxn_line( transxn, product, quantity ) values (189,'abc1000013',2);
insert into transxn_line( transxn, product, quantity ) values (189,'abc1000029',1);
insert into transxn_line( transxn, product, quantity ) values (189,'bde1010121',4);
insert into transxn_line( transxn, product, quantity ) values (189,'abc1000079',3);
insert into transxn_line( transxn, product, quantity ) values (190,'abc1000025',4);
insert into transxn_line( transxn, product, quantity ) values (190,'abc1000074',3);
insert into transxn_line( transxn, product, quantity ) values (190,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1000039',1);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1000085',4);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1000123',4);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1000071',1);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1000052',2);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1000092',3);
insert into transxn_line( transxn, product, quantity ) values (191,'abc1000028',2);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000072',4);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000092',2);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000047',4);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000011',2);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000118',4);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000051',3);
insert into transxn_line( transxn, product, quantity ) values (192,'abc1000062',1);
insert into transxn_line( transxn, product, quantity ) values (193,'abc1000071',1);
insert into transxn_line( transxn, product, quantity ) values (193,'abc1000082',4);
insert into transxn_line( transxn, product, quantity ) values (193,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (193,'abc1000052',1);
insert into transxn_line( transxn, product, quantity ) values (193,'abc1000014',1);
insert into transxn_line( transxn, product, quantity ) values (194,'abc1000012',4);
insert into transxn_line( transxn, product, quantity ) values (194,'abc1000071',4);
insert into transxn_line( transxn, product, quantity ) values (194,'abc1000034',4);
insert into transxn_line( transxn, product, quantity ) values (194,'abc1000092',4);
insert into transxn_line( transxn, product, quantity ) values (195,'abc1000074',3);
insert into transxn_line( transxn, product, quantity ) values (195,'abc1000078',4);
insert into transxn_line( transxn, product, quantity ) values (196,'abc1000074',2);
insert into transxn_line( transxn, product, quantity ) values (196,'abc1000047',3);
insert into transxn_line( transxn, product, quantity ) values (197,'abc1000037',3);
insert into transxn_line( transxn, product, quantity ) values (198,'abc1000101',1);
insert into transxn_line( transxn, product, quantity ) values (198,'abc1000068',2);
insert into transxn_line( transxn, product, quantity ) values (198,'abc1000088',3);


insert into transxn_line( transxn, product, quantity ) values (198,'abc1000013',1);
insert into transxn_line( transxn, product, quantity ) values (199,'abc1000082',1);
insert into transxn_line( transxn, product, quantity ) values (199,'abc1000015',3);
insert into transxn_line( transxn, product, quantity ) values (199,'abc1000057',3);
insert into transxn_line( transxn, product, quantity ) values (199,'abc1000096',1);
insert into transxn_line( transxn, product, quantity ) values (199,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (199,'abc1000026',2);
insert into transxn_line( transxn, product, quantity ) values (200,'abc1000227',1);
insert into transxn_line( transxn, product, quantity ) values (201,'abc1000088',3);

insert into transxn_line( transxn, product, quantity ) values (201,'abc1000116',2);
insert into transxn_line( transxn, product, quantity ) values (201,'abc1000100',4);
insert into transxn_line( transxn, product, quantity ) values (201,'abc1000012',3);
insert into transxn_line( transxn, product, quantity ) values (201,'abc1000029',1);

insert into transxn_line( transxn, product, quantity ) values (201,'abc1000074',2);
insert into transxn_line( transxn, product, quantity ) values (202,'abc1000107',3);
insert into transxn_line( transxn, product, quantity ) values (202,'abc1000047',3);
insert into transxn_line( transxn, product, quantity ) values (203,'abc1000014',2);
insert into transxn_line( transxn, product, quantity ) values (203,'abc1000120',1);
insert into transxn_line( transxn, product, quantity ) values (203,'abc1000081',4);
insert into transxn_line( transxn, product, quantity ) values (203,'abc1000035',3);
insert into transxn_line( transxn, product, quantity ) values (204,'abc1234567',2);
insert into transxn_line( transxn, product, quantity ) values (205,'abc1000118',1);
insert into transxn_line( transxn, product, quantity ) values (205,'abc1000123',3);
insert into transxn_line( transxn, product, quantity ) values (206,'abc1000111',4);
insert into transxn_line( transxn, product, quantity ) values (206,'abc1000082',1);
insert into transxn_line( transxn, product, quantity ) values (207,'abc1000075',4);
insert into transxn_line( transxn, product, quantity ) values (208,'abc1000109',4);
insert into transxn_line( transxn, product, quantity ) values (208,'abc1000008',3);
insert into transxn_line( transxn, product, quantity ) values (209,'abc1000063',3);
insert into transxn_line( transxn, product, quantity ) values (209,'abc1000009',1);
insert into transxn_line( transxn, product, quantity ) values (209,'abc1000099',4);
insert into transxn_line( transxn, product, quantity ) values (209,'abc1000122',1);
insert into transxn_line( transxn, product, quantity ) values (209,'abc1000095',4);
insert into transxn_line( transxn, product, quantity ) values (210,'abc1000116',1);
insert into transxn_line( transxn, product, quantity ) values (210,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (210,'abc1000016',3);
insert into transxn_line( transxn, product, quantity ) values (211,'abc1000133',4);
insert into transxn_line( transxn, product, quantity ) values (211,'abc1000074',4);
insert into transxn_line( transxn, product, quantity ) values (211,'abc1000092',2);
insert into transxn_line( transxn, product, quantity ) values (211,'abc1000075',4);


insert into transxn_line( transxn, product, quantity ) values (211,'abc1000088',4);
insert into transxn_line( transxn, product, quantity ) values (211,'abc1000098',1);


insert into transxn_line( transxn, product, quantity ) values (212,'abc1010102',2);
insert into transxn_line( transxn, product, quantity ) values (212,'abc1000035',1);
insert into transxn_line( transxn, product, quantity ) values (212,'abc1000103',2);
insert into transxn_line( transxn, product, quantity ) values (212,'abc1000101',3);
insert into transxn_line( transxn, product, quantity ) values (212,'abc1000051',4);
insert into transxn_line( transxn, product, quantity ) values (212,'abc1000095',1);
insert into transxn_line( transxn, product, quantity ) values (213,'abc1000057',1);

insert into transxn_line( transxn, product, quantity ) values (214,'abc1000048',1);

insert into transxn_line( transxn, product, quantity ) values (214,'abc1000028',1);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000120',4);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000093',1);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000107',1);

insert into transxn_line( transxn, product, quantity ) values (214,'abc1010102',3);

insert into transxn_line( transxn, product, quantity ) values (214,'bde1010121',1);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000126',4);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000036',4);

insert into transxn_line( transxn, product, quantity ) values (214,'abc1000122',1);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000081',1);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000130',4);

insert into transxn_line( transxn, product, quantity ) values (214,'abc1000100',3);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000068',1);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000015',3);

insert into transxn_line( transxn, product, quantity ) values (214,'abc1000034',1);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000026',4);
insert into transxn_line( transxn, product, quantity ) values (214,'abc1000008',3);




insert into transxn_line( transxn, product, quantity ) values (214,'abc1000227',2);

insert into transxn_line( transxn, product, quantity ) values (215,'abc1000103',1);

insert into transxn_line( transxn, product, quantity ) values (215,'abc1000009',2);
insert into transxn_line( transxn, product, quantity ) values (215,'abc1000072',2);
insert into transxn_line( transxn, product, quantity ) values (215,'abc1000078',1);
insert into transxn_line( transxn, product, quantity ) values (215,'abc1000008',2);
insert into transxn_line( transxn, product, quantity ) values (215,'abc1000061',3);
insert into transxn_line( transxn, product, quantity ) values (215,'abc1000039',3);
insert into transxn_line( transxn, product, quantity ) values (215,'abc1000096',1);



insert into transxn_line( transxn, product, quantity ) values (215,'abc1000049',2);
insert into transxn_line( transxn, product, quantity ) values (216,'abc1000129',3);
insert into transxn_line( transxn, product, quantity ) values (216,'abc1000122',2);
insert into transxn_line( transxn, product, quantity ) values (217,'abc1000069',2);
insert into transxn_line( transxn, product, quantity ) values (217,'abc1000081',2);
insert into transxn_line( transxn, product, quantity ) values (217,'abc1000033',3);
insert into transxn_line( transxn, product, quantity ) values (217,'abc1000044',1);
insert into transxn_line( transxn, product, quantity ) values (217,'abc1000008',3);
insert into transxn_line( transxn, product, quantity ) values (217,'abc1000092',1);
insert into transxn_line( transxn, product, quantity ) values (218,'abc1000057',4);

insert into transxn_line( transxn, product, quantity ) values (219,'abc1000018',3);


insert into transxn_line( transxn, product, quantity ) values (219,'abc1000049',1);
insert into transxn_line( transxn, product, quantity ) values (219,'abc1000009',3);

insert into transxn_line( transxn, product, quantity ) values (220,'abc1000126',1);
insert into transxn_line( transxn, product, quantity ) values (221,'abc1000025',2);
insert into transxn_line( transxn, product, quantity ) values (222,'abc1000129',4);
insert into transxn_line( transxn, product, quantity ) values (222,'abc1000087',3);
insert into transxn_line( transxn, product, quantity ) values (222,'abc1000118',1);
insert into transxn_line( transxn, product, quantity ) values (222,'abc1000069',4);
insert into transxn_line( transxn, product, quantity ) values (222,'abc1000062',4);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000081',4);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000069',4);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000095',2);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000096',1);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000058',1);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000106',1);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000018',3);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000038',2);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000061',4);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000013',1);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000071',4);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1000126',3);
insert into transxn_line( transxn, product, quantity ) values (223,'abc1234567',4);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000085',3);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000009',1);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000047',1);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1234567',2);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000130',1);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000123',2);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000100',2);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000127',1);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000013',3);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000096',4);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000044',3);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000057',2);
insert into transxn_line( transxn, product, quantity ) values (224,'abc1000103',3);
insert into transxn_line( transxn, product, quantity ) values (225,'abc1000062',2);
insert into transxn_line( transxn, product, quantity ) values (225,'abc1000127',3);
insert into transxn_line( transxn, product, quantity ) values (225,'abc1000093',4);
insert into transxn_line( transxn, product, quantity ) values (226,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (226,'abc1000123',2);
insert into transxn_line( transxn, product, quantity ) values (226,'abc1000087',3);
insert into transxn_line( transxn, product, quantity ) values (227,'abc1000034',2);
insert into transxn_line( transxn, product, quantity ) values (228,'abc1000033',3);
insert into transxn_line( transxn, product, quantity ) values (228,'abc1000118',1);
insert into transxn_line( transxn, product, quantity ) values (229,'bde1010121',1);
insert into transxn_line( transxn, product, quantity ) values (229,'abc1000115',3);
insert into transxn_line( transxn, product, quantity ) values (229,'abc1000085',4);
insert into transxn_line( transxn, product, quantity ) values (230,'abc1000134',4);
insert into transxn_line( transxn, product, quantity ) values (230,'abc1000199',1);
insert into transxn_line( transxn, product, quantity ) values (231,'abc1000048',2);
insert into transxn_line( transxn, product, quantity ) values (231,'abc1000007',1);
insert into transxn_line( transxn, product, quantity ) values (231,'abc1000098',4);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000011',1);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000075',4);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000012',4);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000132',1);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000106',2);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000033',4);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000227',3);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000098',3);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000058',1);
insert into transxn_line( transxn, product, quantity ) values (232,'abc1000028',4);
insert into transxn_line( transxn, product, quantity ) values (233,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (233,'abc1000088',4);
insert into transxn_line( transxn, product, quantity ) values (233,'abc1000115',1);
insert into transxn_line( transxn, product, quantity ) values (233,'abc1000007',2);
insert into transxn_line( transxn, product, quantity ) values (233,'abc1000134',1);
insert into transxn_line( transxn, product, quantity ) values (234,'abc1000052',4);
insert into transxn_line( transxn, product, quantity ) values (234,'abc1000062',4);
insert into transxn_line( transxn, product, quantity ) values (235,'abc1000133',3);
insert into transxn_line( transxn, product, quantity ) values (235,'abc1000134',1);
insert into transxn_line( transxn, product, quantity ) values (235,'abc1010102',3);
insert into transxn_line( transxn, product, quantity ) values (236,'abc1000058',1);
insert into transxn_line( transxn, product, quantity ) values (236,'abc1000199',3);
insert into transxn_line( transxn, product, quantity ) values (236,'abc1000082',1);
insert into transxn_line( transxn, product, quantity ) values (237,'abc1000059',4);
insert into transxn_line( transxn, product, quantity ) values (237,'abc1000013',2);
insert into transxn_line( transxn, product, quantity ) values (237,'abc1000064',2);
insert into transxn_line( transxn, product, quantity ) values (237,'abc1000107',1);
insert into transxn_line( transxn, product, quantity ) values (238,'abc1000008',2);
insert into transxn_line( transxn, product, quantity ) values (238,'abc1000038',2);



insert into transxn_line( transxn, product, quantity ) values (238,'abc1000029',1);
insert into transxn_line( transxn, product, quantity ) values (238,'abc1000051',4);

insert into transxn_line( transxn, product, quantity ) values (238,'abc1234567',2);
insert into transxn_line( transxn, product, quantity ) values (238,'abc1000099',2);
insert into transxn_line( transxn, product, quantity ) values (238,'abc1000057',3);
insert into transxn_line( transxn, product, quantity ) values (239,'abc1000132',4);
insert into transxn_line( transxn, product, quantity ) values (239,'abc1000037',1);
insert into transxn_line( transxn, product, quantity ) values (239,'abc1000082',2);
insert into transxn_line( transxn, product, quantity ) values (240,'abc1000130',4);

insert into transxn_line( transxn, product, quantity ) values (240,'abc1000072',1);
insert into transxn_line( transxn, product, quantity ) values (240,'abc1000033',1);

insert into transxn_line( transxn, product, quantity ) values (240,'abc1000029',4);
insert into transxn_line( transxn, product, quantity ) values (240,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (240,'abc1000012',4);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000069',1);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000012',4);

insert into transxn_line( transxn, product, quantity ) values (241,'abc1000111',2);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000029',1);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000129',2);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000092',3);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000015',3);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000093',1);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1234567',2);

insert into transxn_line( transxn, product, quantity ) values (241,'abc1000051',2);
insert into transxn_line( transxn, product, quantity ) values (241,'abc1000101',2);
insert into transxn_line( transxn, product, quantity ) values (242,'abc1000103',1);

insert into transxn_line( transxn, product, quantity ) values (242,'abc1000035',1);
insert into transxn_line( transxn, product, quantity ) values (242,'abc1000049',3);
insert into transxn_line( transxn, product, quantity ) values (242,'abc1000047',3);

insert into transxn_line( transxn, product, quantity ) values (242,'abc1000111',2);
insert into transxn_line( transxn, product, quantity ) values (243,'abc1000095',1);
insert into transxn_line( transxn, product, quantity ) values (243,'abc1000199',4);
insert into transxn_line( transxn, product, quantity ) values (243,'abc1000063',1);
insert into transxn_line( transxn, product, quantity ) values (243,'abc1000033',2);
insert into transxn_line( transxn, product, quantity ) values (243,'abc1000079',3);
insert into transxn_line( transxn, product, quantity ) values (243,'abc1000015',1);
insert into transxn_line( transxn, product, quantity ) values (244,'abc1000123',4);
insert into transxn_line( transxn, product, quantity ) values (245,'abc1000063',1);
insert into transxn_line( transxn, product, quantity ) values (245,'abc1000115',1);
insert into transxn_line( transxn, product, quantity ) values (245,'abc1000088',3);
insert into transxn_line( transxn, product, quantity ) values (245,'abc1000011',3);
insert into transxn_line( transxn, product, quantity ) values (245,'abc1000074',4);
insert into transxn_line( transxn, product, quantity ) values (246,'abc1000099',1);
insert into transxn_line( transxn, product, quantity ) values (246,'abc1000057',4);
insert into transxn_line( transxn, product, quantity ) values (246,'abc1000088',4);
insert into transxn_line( transxn, product, quantity ) values (246,'abc1000132',1);
insert into transxn_line( transxn, product, quantity ) values (246,'abc1000038',1);

insert into transxn_line( transxn, product, quantity ) values (247,'abc1000012',4);

insert into transxn_line( transxn, product, quantity ) values (247,'abc1000034',2);


insert into transxn_line( transxn, product, quantity ) values (247,'abc1000088',4);
insert into transxn_line( transxn, product, quantity ) values (247,'abc1000081',2);
insert into transxn_line( transxn, product, quantity ) values (247,'abc1000036',3);
insert into transxn_line( transxn, product, quantity ) values (247,'abc1000037',1);
insert into transxn_line( transxn, product, quantity ) values (247,'abc1000130',3);
insert into transxn_line( transxn, product, quantity ) values (247,'abc1000078',1);
insert into transxn_line( transxn, product, quantity ) values (247,'abc1000051',4);

insert into transxn_line( transxn, product, quantity ) values (247,'abc1000099',1);

insert into transxn_line( transxn, product, quantity ) values (247,'abc1000095',1);
insert into transxn_line( transxn, product, quantity ) values (248,'abc1000123',4);
insert into transxn_line( transxn, product, quantity ) values (248,'abc1000008',4);
insert into transxn_line( transxn, product, quantity ) values (248,'abc1000116',3);
insert into transxn_line( transxn, product, quantity ) values (248,'abc1000100',2);
insert into transxn_line( transxn, product, quantity ) values (249,'abc1000101',4);
insert into transxn_line( transxn, product, quantity ) values (249,'abc1000098',4);

insert into transxn_line( transxn, product, quantity ) values (249,'abc1000075',4);

insert into transxn_line( transxn, product, quantity ) values (250,'abc1000015',4);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000062',1);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000122',1);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000016',2);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000057',1);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000059',2);



insert into transxn_line( transxn, product, quantity ) values (250,'abc1000052',2);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000126',3);

insert into transxn_line( transxn, product, quantity ) values (250,'abc1000044',2);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000132',2);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000068',3);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000034',3);

insert into transxn_line( transxn, product, quantity ) values (250,'abc1000061',2);
insert into transxn_line( transxn, product, quantity ) values (250,'abc1000072',1);



insert into transxn_line( transxn, product, quantity ) values (250,'abc1000093',4);



