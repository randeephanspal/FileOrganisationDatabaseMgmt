use fodbproject;

select * from buildings;
select * from TypePrerequisite;

-- 1
select distinct b.builderNo, b.BuildingAddress, b.Building_type from buildings b 
left join inspection_history ih on ih.building=b.buildingAddress where 
ih.building is null or b.buildingAddress in (select distinct building from inspection_history
where building not in(select distinct building from inspection_history where type in ('FNL','FN2','FN3')));

-- 2
select id,inspectorsName from inspectors where id in (
select inspectorid from inspection_history where score<75);


-- 3 
select distinct type from inspection_history 
where score >=75 and type not in (select distinct type from inspection_history where score<75);

-- 4
select sum(ti.cost) as TotalInspectionCost from typeinfo as ti
inner join inspection i on i.type=ti.type
inner join inspection_history ih on ih.type=i.code
inner join buildings as b on b.BuildingAddress=ih.building where b.builderNo = 12345;

-- 5
select avg(score) from inspection_history where inspectorid in (
select id from inspectors where id=102);

-- 6
select sum(ti.cost) as RenenueReceived from typeinfo ti
join inspection i on ti.type = i.type
join inspection_history ih on ih.type = i.code where month(date) = 10;

-- 7
Create view workextype as
select ih.type from inspectors i
join inspection_history ih on ih.inspectorid=i.id 
where TIMESTAMPDIFF(YEAR,i.hiredate,ih.date) > 15
and Year(date)=2018;

select sum(ti.cost) as InspectorRenenue from typeinfo ti
join inspection i on ti.type = i.type
join workextype wt on wt.type = i.code;

-- 8
insert into buildings values (34567, '1420 Main St., Lewisville TX.', 'residential', 1600, '2018-11-20');
select * from buildings where builderNo=34567;
-- 9
insert into inspection_history values ('2018-11-21','FRM',104,50,'work not finished','1420 Main St. Lewisville TX');
select * from inspection_history;

-- 10
update typeinfo
set cost = 150
where type in (select type from inspection where code = 'ELE');

select * from typeinfo where type = 'Electrical';


-- 11
insert into inspection_history values ('2018-11-22','ELE',104,60,'lights not completed','1420 Main St., Lewisville TX');

select * from inspection_history where inspectorid=105;

-- 12 
update inspection_history
set notes = 'all work completed per checklist'
where inspectorid = 105 and type='FRM' and date='2018-11-02';
select * from inspection_history where inspectorid = 105 and type='FRM' and date='2018-11-02';

-- 13
insert into inspection_history values ('2018-11-28','POL',103,50,'work not finished','100 Winding Wood, Fort Worth, TX');



-- 14
DELIMITER //
CREATE TRIGGER trig_Inspector_retire
BEFORE INSERT
ON inspection_history FOR EACH ROW 
BEGIN 
	if (new.date) > '2018-12-01' and (new.inspectorid) = 101 then
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = "Inspector 101 has retired";
END IF;
END; //
DELIMITER ;

INSERT INTO inspection_history VALUES 
('2018-12-32','TTT',107,100,'testting','testting');


-- Trigger: handle prerequisite
DELIMITER //
CREATE TRIGGER trig_TypePrerequisite
BEFORE INSERT
ON TypePrerequisite FOR EACH ROW 
BEGIN 
	if (new.prerequisite) not in (select distinct code from Inspection) then
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = "Incorrect Prerequisite";
END IF;
END; //
DELIMITER ;

select * from Inspection;
insert into TypePrerequisite values ('FN3','PPP');
delete from TypePrerequisite where prerequisite = 'PPP';