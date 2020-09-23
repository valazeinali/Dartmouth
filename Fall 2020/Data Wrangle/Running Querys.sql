-- September 22nd notes
-------------------------------------------
-- Showing good use case for group by
SELECT parentcustomeridname, avg(tri_age) 
FROM dbo.Demographics 
GROUP BY parentcustomeridname
-------------------------------------------
-- Creating a table in our database and inserting a value into it
CREATE table vzeinali.mytable(ID int)

insert into vzeinali.mytable 
values(1)

select * from vzeinali.mytable 
-------------------------------------------
-- Making a copy of Demographics from the master database into our database
select * into vzeinali.Demographics from dbo.Demographics
-------------------------------------------
-- Adding new column to our exsisting table and set the col to 
alter table vzeinali.Demographics 
add age int
select * from vzeinali.Demographics

update vzeinali.Demographics
set age = tri_age 
where tri_age > 30
select * from vzeinali.Demographics
-------------------------------------------
-- Creating a new table "average_age" that has averages of all the possible parentcustomernames
select parentcustomeridname, avg(tri_age) as average_age into vzeinali.parent_avgage from dbo.Demographics
group by parentcustomeridname 

select * from vzeinali.parent_avgage
-------------------------------------------
-- How to convert types (char to numeric) *does not actually change in table, only in command

select * from dbo.Demographics
where try_convert(int,gendercode) = 2

