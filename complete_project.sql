Create Database project;
use project;
-- drop database project;

Create table inspection_types(
inspectiontype_id char(4) primary key,
code char(3),
type varchar(20),
prerequisite char(10),
cost integer
);
	
Create table inspectors(
Id integer primary key,
InspectorsName varchar(20),
HireDate Date,
unique (id));

Create table builders(
LicenceNo integer,
BuildersName varchar(15),
BuilderAddress varchar(20),
street varchar(50),
state char(3), 
primary key (LicenceNo)
);

Create table buildings(
builderNo integer,
street varchar(50) primary key,
city varchar(25),	
state char(3),
Building_type enum('commercial','residential'),
size integer,
DataFirstActivity Date,
foreign key (builderNo) references builders(LicenceNo));

Create table inspection_history(
date Date,
type char(3),
inspectorid integer,
score integer,
notes varchar(40),
street varchar(50),
city varchar(50),	
state char(3),
foreign key (street) references buildings(street),
foreign key (inspectorid) references inspectors(Id));

Create table pending_inspections(
date Date,
type char(3),
building_street varchar(50),
building_city varchar(50),
building_state char(3));

------------------------------------------------------------------------------------------
INSERT INTO inspection_types VALUES ('I01','FRM', 'Framing',null,100),('I02','PLU','Plumbing','FRM',100),
('I03','POL','Pool','PLU',50),('I04','ELE','Electrical','FRM',100),('I05','SAF','Safety',null,50),
('I06','HAC','Heating/Cooling','ELE',100),('I07','FNL','Final','HAC',200),('I08','FNL','Final','PLU',200),
('I09','FN2','Final-2 needed','ELE',150),('I10','FN2','Final-2 needed','PLU',150),
('I11','FN3','Final-plumbing','PLU',150),('I12','HIS','Historical accuracy',null,100);

INSERT INTO inspectors VALUES (101,'Inspector-1','1984-08-11'),(102,'Inspector-2','1994-08-11'),(103,'Inspector-4','2004-08-11'),
(104,'Inspector-5','2014-01-11'), (105,'Inspector-6','2018-01-11');

INSERT INTO builders VALUES (12345,'Builder-1','01 Main St','Dallas','TX'),
(23456,'Builder-2','01 Industrial Ave','Dallas','TX'),(34567,'Builder-3','01 Main Winding','Dallas','TX'),
(45678,'Builder-4','01 Winding Wood','Plano','TX'),(12321,'Builder-5','01 Cherry Bark Lane','Plano','TX');

INSERT INTO buildings VALUES 
(12345,'100 Main St.','Dallas','TX','commercial',250000,'1999-12-31'),
(12345,'300 Oak St.','Dallas','TX','residential',3000,'2000-01-01'),
(12345,'302 Oak St.','Dallas','TX','residential',4000,'2001-02-01'),
(12345,'304 Oak St.','Dallas','TX','residential',1500,'2002-03-01'),
(12345,'306 Oak St.','Dallas','TX','residential',1500,'2003-04-01'),
(12345,'308 Oak St.','Dallas','TX','residential',2000,'2003-04-01'),
(23456,'100 Industrial Ave.','Fort Worth','TX','commercial',100000,'2005-06-01'),
(23456,'101 Industrial Ave.','Fort Worth','TX','commercial',80000,'2005-06-01'),
(23456,'102 Industrial Ave.','Fort Worth','TX','commercial',75000,'2005-06-01'),
(23456,'103 Industrial Ave.','Fort Worth','TX','commercial',50000,'2005-06-01'),
(23456,'104 Industrial Ave.','Fort Worth','TX','commercial',80000,'2005-06-01'),
(23456,'105 Industrial Ave.','Fort Worth','TX','commercial',90000,'2005-06-01'),
(45678,'100 Winding Wood','Carrollton','TX','residential',2500,null),
(45678,'102 Winding Wood','Carrollton','TX','residential',2800,null),
(12321,'210 Cherry Bark Lane','Plano','TX','residential',3200,'2016-10-01'),
(12321,'212 Cherry Bark Lane','Plano','TX','residential',null,null),
(12321,'214 Cherry Bark Lane','Plano','TX','residential',null,null),
(12321,'216 Cherry Bark Lane','Plano','TX','residential',null,null);

INSERT INTO inspection_history VALUES 
('2018-11-06','FRM',105,100,'okay','100 Industrial Ave.','Fort Worth','TX'),
('2018-11-08','PLU',102,100,'no leaks','100 Industrial Ave.','Fort Worth','TX'),
('2018-11-12','POL',102,80,'pool equipment okay','100 Industrial Ave.','Fort Worth','TX'),
('2018-11-14','FN3',102,100,'no problems noted','100 Industrial Ave.','Fort Worth','TX'),
('2018-10-01','FRM',103,100,'no problems noted','100 Winding Wood','Carrollton','TX'),
('2018-10-20','PLU',103,100,'everything working','100 Winding Wood','Carrollton','TX'),	
('2018-10-25','ELE',103,100,'no problems noted','100 Winding Wood','Carrollton','TX'),
('2018-11-02','HAC',103,100,'no problems noted','100 Winding Wood','Carrollton','TX'),	
('2018-11-14','FNL',103,90,'REJECT TOO MANY','100 Winding Wood','Carrollton','TX'),	
('2018-11-01','FRM',103,100,'no problems noted','102 Winding Wood','Carrollton','TX'),	
('2018-11-02','PLU',103,90,'minor leak, corrected','102 Winding Wood','Carrollton','TX'),
('2018-11-03','ELE',103,80,'exposed junction box','102 Winding Wood','Carrollton','TX'),
('2018-11-02','FRM',105,100,'tbd','105 Industrial Ave.','Fort Worth','TX'),	
('2018-10-01','FRM',101,100,'no problems noted','300 Oak St.','Dallas','TX'),	
('2018-10-02','PLU',101,90,'minor leak, corrected','300 Oak St.','Dallas','TX'),	
('2018-10-03','ELE',101,80,'exposed junction box','300 Oak St.','Dallas','TX'),	
('2018-10-04','HAC',101,80,'duct needs taping','300 Oak St.','Dallas','TX'),	
('2018-10-05','FNL',101,90,'ready for owner','300 Oak St.','Dallas','TX'),	
('2018-10-01','FRM',102,100,'no problems noted','302 Oak St.','Dallas','TX'),	
('2018-10-02','PLU',102,25,'massive leaks','302 Oak St.','Dallas','TX'),	
('2018-10-08','PLU',102,50,'still leaking','302 Oak St.','Dallas','TX'),	
('2018-10-12','FRM',103,85,'no issues but messy','210 Cherry Bark Lane','Plano','TX'),	
('2018-10-14','SAF',104,100,'no problems noted','210 Cherry Bark Lane','Plano','TX'),	
('2018-11-04','PLU',103,80,'duct needs sealing','210 Cherry Bark Lane','Plano','TX'),	
('2018-11-05','POL',105,90,'ready for owner','210 Cherry Bark Lane','Plano','TX'),	
('2018-10-12','PLU',102,80,'no leaks, but messy','302 Oak St.','Dallas','TX'),	
('2018-10-14','ELE',102,100,'no problems noted','302 Oak St.','Dallas','TX'),	
('2018-11-01','HAC',102,80,'duct needs taping','302 Oak St.','Dallas','TX'),	
('2018-11-02','FNL',102,90,'ready for owner','302 Oak St.','Dallas','TX');

INSERT INTO pending_inspections VALUES 
('2018-09-01','FNL','105 Industrial Ave.','Fort Worth','TX'),
('2018-10-26','FRM','212 Cherry Bark Lane','Plano','TX'),
('2018-11-04','PLU','212 Cherry Bark Lane','Plano','TX');
-----------------------------------------------------------
select * from pending_inspections;
select * from buildings;
select * from builders;
select * from inspectors;
select * from inspection_history;
select * from inspection_types;
------------------------------------------------------------
drop trigger trig_inspection_code;

-- Trigger 1: type code 3 chars
DELIMITER //
CREATE TRIGGER trig_inspection_code
BEFORE INSERT
ON inspection_types FOR EACH ROW 
BEGIN 
	if length(new.code) < 3 then
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = "Inspection Code should be 3 chars";
END IF;
END; //
DELIMITER ;

INSERT INTO inspection_types VALUES ('I29','TES','Historical accuracy',null,100);

drop trigger trig_inspector_id;
-- Trigger 2: 3 digits inspector_id
DELIMITER //
CREATE TRIGGER trig_inspector_id
BEFORE INSERT
ON inspectors FOR EACH ROW 
BEGIN 
	if length(new.Id) > 3 or length(new.Id) < 3 then
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = "Inspector_id should be 3 digits";
END IF;
END; //
DELIMITER ;


INSERT INTO inspectors VALUES (10,'Inspector-1','1984-08-11');


-- Trigger 3: 5 digit licenceno 
DELIMITER //
CREATE TRIGGER trig_builders_licence
BEFORE INSERT
ON builders FOR EACH ROW 
BEGIN 
	if length(new.LicenceNo) > 5 or length(new.LicenceNo) < 5 then
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = "LicenceNo should be 5 digits";
END IF;
END; //
DELIMITER ;

INSERT INTO builders VALUES (123,'Builder-1','01 Main St','Dallas','TX');

select* from builders; 




DELIMITER //
CREATE TRIGGER trig_inspection_history
BEFORE INSERT
ON inspection_history FOR EACH ROW 
BEGIN 
	declare countID int;
  set countID = (select count(*) from inspection_history 
  where (inspection_history.inspectorid = new.inspectorid and (MONTH(  `date` ) = (MONTH(  new.`date` )))));
    if  countID >= 5 then
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "Max limit exceeded";
	END IF;
END; //
DELIMITER ;
