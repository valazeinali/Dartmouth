--- September 22nd notes
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

-- September 29th Class
-------------------------------------------
-- INNER JOIN
select * from Demographics d
inner join
Conditions c 
on 
d.contactid = c.tri_patientid

-- Be aware of duplicate entries always do count(*) and Distinct(d.contactid)


select count(*) from Demographics d
inner join
Conditions c 
on 
d.contactid = c.tri_patientid


select count(distinct d.contactid) from Demographics d
inner join
Conditions c 
on 
d.contactid = c.tri_patientid

-- Notice how there are duplicates since the primary key can have multiple entires


-- LEFT JOIN
select count(distinct d.contactid) from Demographics d
left join
Conditions c 
on 
d.contactid = c.tri_patientid

-- Find missing values
select d.contactid,c.tri_patientid from Demographics d
left join
Conditions c 
on 
d.contactid = c.tri_patientid
where c.tri_patientid is NULL 

-- RIGHT JOIN
select d.contactid,c.tri_patientid from Demographics d
right join
Conditions c 
on 
d.contactid = c.tri_patientid

-------------------------------------------
-- Joining all tables together
select * from Demographics a
inner join Conditions b
on 
a.contactid=b.tri_patientid
inner join Text c
on c.tri_contactId = a.contactid 
inner join PhoneCall d
on d.tri_CustomerIDEntityReference = b.tri_patientid


-------------------------------------------
--  Next lecture will go over this error.
-- October 1st 

-- Sandwich join
select top 10 * from Inpatient
union
select top 10 * from Outpatient

--------------------------------------------
select count(contactid),parentcustomeridname from Demographics
group by parentcustomeridname 
having count(contactid) > 100

select count(contactid),parentcustomeridname from Demographics
group by parentcustomeridname 
having avg(tri_age) > 70
ORDER by count(contactid) asc

select count(contactid),parentcustomeridname from Demographics
where parentcustomeridname like '%dartmouth%'
group by parentcustomeridname 
having avg(tri_age) < 50
ORDER by count(contactid) asc

select count(contactid),parentcustomeridname from Demographics
where parentcustomeridname like '%dartmouth%'
group by parentcustomeridname 
-------------------------------------------
-- in statement
-- these two are the same
select * from Demographics
where tri_age in (20,30,40)

select * from Demographics
where tri_age=20 or tri_age=30 or tri_age=40

-------------------------------------------
-- between statement
-- these two are the same
select * from Demographics
where tri_age between 20 and 30

select * from Demographics 
where tri_age > 19 AND tri_age < 31


-------------------------------------------
-- In class Excercise for October 1st
-- #1
select count(tri_name),tri_name from Demographics d
left join
Conditions c 
on 
d.contactid = c.tri_patientid
group by tri_name 
having count(tri_name) > 100

-- #2

select 'Inpatient Average Height (65 y/o+):',avg(MEAS_VALUE) from dbo.Flowsheets f 
left join
dbo.Inpatient i
on 
i.NEW_PAT_ENC_CSN_ID = f.PAT_ENC_CSN_ID
where f.DISP_NAME = 'Height' and i.DOB_CATEGORY = 'Over 64'

select 'Outpatient Average Height (65 y/o+):',avg(MEAS_VALUE) from dbo.Flowsheets f 
left join
dbo.Outpatient o
on 
o.NEW_PAT_ENC_CSN_ID = f.PAT_ENC_CSN_ID
where f.DISP_NAME = 'Height' and o.PATIENT_DOB_CATEGORY = 'Over 64'

-- #3
select * from Demographics a
inner join Conditions b
on 
a.contactid=b.tri_patientid
inner join Text c
on c.tri_contactId = a.contactid 
inner join PhoneCall d
on d.tri_CustomerIDEntityReference = b.tri_patientid