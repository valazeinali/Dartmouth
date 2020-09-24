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
-------------------------------------------
-------------------------------------------
-------------------------------------------



-- September 24th notes

-- AGG functions
-------------------------------------------
select count(contactid) from dbo.Demographics

select count(distinct contactid) from dbo.Demographics

select count(distinct dbo.Demographics.address1_stateorprovince) from dbo.Demographics

select min(tri_age) from dbo.Demographics

select max(tri_age) from dbo.Demographics

-------------------------------------------

select parentcustomeridname,min(tri_age) as Minimum_Age FROM dbo.Demographics
where tri_age > 40
group by parentcustomeridname 
order by Minimum_Age desc

-- same thing but a subset
select parentcustomeridname,min(tri_age) as Minimum_Age FROM dbo.Demographics
where tri_age > 40 and try_convert(int, gendercode)=1
group by parentcustomeridname 
order by Minimum_Age desc

select parentcustomeridname,min(tri_age) as Minimum_Age FROM dbo.Demographics
where tri_age > 40 and try_convert(int, gendercode)=2
group by parentcustomeridname 
order by Minimum_Age desc

select parentcustomeridname,min(tri_age) as Minimum_Age FROM dbo.Demographics
where  try_convert(int, gendercode) is null
group by parentcustomeridname 
order by Minimum_Age desc

-- same as above
select parentcustomeridname,min(tri_age) as Minimum_Age FROM dbo.Demographics
where  gendercode = 'null'
group by parentcustomeridname 
order by Minimum_Age desc

-------------------------------------------

select parentcustomeridname,avg(tri_age) as Total_Age from dbo.Demographics 
group by parentcustomeridname 

-------------------------------------------
-- Text Mining

select * from dbo.Demographics 
where parentcustomeridname LIKE 'd%'

SELECT DISTINCT parentcustomeridname from dbo.Demographics
WHERE parentcustomeridname  like '%hitch%'

select * from dbo.Demographics 
where try_convert(char,tri_age) LIKE '%4'

-------------------------------------------
-- JOINS

-- joining two tables and then storing the output into a new table into my folder
select * into vzeinali.conditions from qbs181.dbo.Demographics d
inner join 
dbo.conditions b 
on
d.contactid = b.tri_patientid 


-------------------------------------------

-- HOMEWORK QUIZ 

-- #1
select parentcustomeridname,count(tri_name) as hyper_count from vzeinali.conditions
WHERE parentcustomeridname = 'Dartmouth-Hitchcock' AND tri_name = 'Hypertension' 
group by parentcustomeridname 


-- #2
select tri_name, avg(tri_age) as avg_age from vzeinali.conditions
WHERE  tri_name = 'Hypertension' OR tri_name = 'COPD' OR tri_name = 'CHF'
group by tri_name 


-- #3
select gendercode, tri_name, count(tri_age) as count_it from vzeinali.conditions
WHERE  (tri_name = 'Hypertension' OR tri_name = 'COPD' OR tri_name = 'CHF') AND (try_convert(int,gendercode) = 2 or 
try_convert(int,gendercode) = 1)
group by gendercode, tri_name 


-------------------------------------------

