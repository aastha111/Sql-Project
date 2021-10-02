first i would like to correct the questions that emp_id in employeestable and designation should be same else we cannnot use join.

CREATED EMPLOYEES TABLE
---------------------------------------------------------------------------------------------
CREATE TABLE EMPLOYEESTABLE(
EMP_ID varchar(5) NOT NULL,
FIRST_NAME varchar(50),
LAST_NAME varchar(50),
SALARY MONEY,
JOINING_DATE DATETIME,
DEPARTMENT varchar(50),
PRIMARY KEY(EMP_ID));
-------------------------------------------------------------------
insert into EMPLOYEESTABLE(EMP_ID,FIRST_NAME,LAST_NAME,SALARY,JOINING_DATE,DEPARTMENT)
values --(001,'Manish',' Agarwal', 700000, '2019-04-20 09:00:00','HR'),
(002,'Niranjan',' Bose', 20000, '2019-02-11 09:00:00','DA'),
(003,'Vivek',' Singh', 100000, '2019-01-20 09:00:00','DA'),
(004,'Asutosh',' Kapoor', 700000, '2019-03-20 09:00:00','HR'),
(005,'Vihaan',' Banerjee', 300000, '2019-06-11 09:00:00','DA'),
(006,'Atul',' Diwedi', 400000, '2019-05-11 09:00:00','Account'),
(007,'Satyendra',' Tripathi', 95000, '2019-03-20 09:00:00','Account'),
(008,'Kritika',' Bhatt', 80000, '2019-02-11 09:00:00','DA')

---------------------------------------------------------------------------------------------
CREATED VARIABLES DETAIL TABLE
---------------------------------------------------------------------------------------------
CREATE TABLE VARIABLESDETAILS(
EMP_REF_ID varchar(5) NOT NULL,
VARIABLES_DATE DATETIME,
VARIABLES_AMOUNT MONEY,
FOREIGN KEY(EMP_REF_ID) REFERENCES
DESIGNATIONTABLE(EMP_REF_ID)
) ;
----------------------------------------------------------------------------------------------------
INSERT INTO VARIABLESDETAILS(EMP_REF_ID,VARIABLES_DATE,VARIABLES_AMOUNT)
VALUES(1, '2019-02-20 00:00:00' ,15000),
(2,' 2019-06-11 00:00:00' ,30000),
(3, '2019-02-20 00:00:00' ,42000),
(4, '2019-02-20 00:00:00' ,14500),
(5, '2019-06-11 00:00:00' ,25000)
-----------------------------------------------------------------------------------------------
created designation table
-----------------------------------------------------------------------------------------------

CREATE TABLE DESIGNATIONTABLE(
EMP_REF_ID varchar(5) NOT NULL,
EMP_TITLE varchar(50),
AFFECTED_FROM DATETIME
PRIMARY KEY(EMP_REF_ID)
) ;
----------------------------------------------------------------------------------------------
INSERT INTO DESIGNATIONTABLE(EMP_REF_ID,EMP_TITLE,AFFECTED_FROM)
VALUES(1,'Assitant Manager', '2019-02-20 09:00:00'),
(2,'Senior Analyst', '2019-01-11 00:00:00'),
(8,'Senior Analyst',' 2019-04-06 00:00:00'),
(5, 'Manager', '2019-10-06 00:00:00'),
(4,'Assitant Manager',' 2019-12-06 00:00:00'),
(7,'Team Lead ', '2019-06-06 00:00:00'),
(6,'Team Lead', '2019-09-06 00:00:00'),
(3,'Senior Analyst', '2019-08-06 00:00:00')


-----------------------------------------------------------------------------------------------

Select * from EMPLOYEESTABLE
Select * from VARIABLESDETAILS
Select * from DESIGNATIONTABLE
-------------------------------------------------------------------------------------------------
Q2. Four types of join  are as follows:
1. Inner Join
2. Left Join
3. Right Join
4. Full Join

----------------------------------------------------------------------------------------------------
1.In inner value we get the matching values from both the tables
----------------------------------------------------------------------------------------------------------------------------------------

select EMPLOYEESTABLE.EMP_ID,EMPLOYEESTABLE.FIRST_NAME,VARIABLESDETAILS.VARIABLES_AMOUNT
from EMPLOYEESTABLE
inner join VARIABLESDETAILS
on EMPLOYEESTABLE.EMP_ID=VARIABLESDETAILS.EMP_REF_ID

-----------------------------------------------------------------------------------------------------
2.In left join we had all 8 records from employees table and rest are null becoz it displays all records from left.
-------------------------------------------------------------------------------------------------------------

select EMPLOYEESTABLE.EMP_ID,EMPLOYEESTABLE.FIRST_NAME,VARIABLESDETAILS.VARIABLES_AMOUNT
from EMPLOYEESTABLE
left join VARIABLESDETAILS
on EMPLOYEESTABLE.EMP_ID=VARIABLESDETAILS.EMP_REF_ID

------------------------------------------------------------------------------------------------------
3.In right join we had only 5 records from employees table becoz in second table their is only 5 rowz that matchs the left table.
---------------------------------------------------------------------------------------------------------------

select EMPLOYEESTABLE.EMP_ID,EMPLOYEESTABLE.FIRST_NAME,VARIABLESDETAILS.VARIABLES_AMOUNT
from EMPLOYEESTABLE
right join VARIABLESDETAILS
on EMPLOYEESTABLE.EMP_ID=VARIABLESDETAILS.EMP_REF_ID

------------------------------------------------------------------------------------------------------------------
4.In outer join it shows all thhe records from both the tables
------------------------------------------------------------------------------------------------------------------

select EMPLOYEESTABLE.EMP_ID,EMPLOYEESTABLE.FIRST_NAME,VARIABLESDETAILS.VARIABLES_AMOUNT
from EMPLOYEESTABLE
full join VARIABLESDETAILS
on EMPLOYEESTABLE.EMP_ID=VARIABLESDETAILS.EMP_REF_ID

------------------------------------------------------------------------------------------------------------------------

Select * from EMPLOYEESTABLE
Select * from VARIABLESDETAILS
Select * from DESIGNATIONTABLE

--------------------------------------------------------------------------------------------------------------
Q2.
a)employee details who have highest and least variables
--------------------------------------------------------------------------------------------------------------
 select FIRST_NAME,LAST_NAME,DEPARTMENT, SALARY,VARIABLES_AMOUNT from EMPLOYEESTABLE
 join VARIABLESDETAILS
 on EMPLOYEESTABLE.EMP_ID = VARIABLESDETAILS.EMP_REF_ID
 where VARIABLES_AMOUNT =(select Max(VARIABLES_AMOUNT) from VARIABLESDETAILS) or
 VARIABLES_AMOUNT =(select Min(VARIABLES_AMOUNT) from VARIABLESDETAILS)

--------------------------------------------------------------------------------------------------------------
b)for the whole year sum of the salary and variables
 ----------------------------------------------------------------------------------------------------------------

Select E.EMP_ID ,E.FIRST_NAME,E.LAST_NAME,( E.SALARY+V.VARIABLES_AMOUNT ) as TOTAL INTO  A
from EMPLOYEESTABLE as E
LEFT join VARIABLESDETAILS as V
on E.EMP_ID = V.EMP_REF_ID

---------------------------------------------------------------------------------------------------------------------
SELECT * from A
--------------------------------------------------------------------------------------------------------------------
 Gave the ranking to the salary+ variables as total
--------------------------------------------------------------------------------------------------------------------
Select *,
rank() over ( Order by Total Desc) as ranking
into  RANKTABLE
from A
---------------------------------------------------------------------------------------------------------------------
select * FROM RANKTABLE
---------------------------------------------------------------------------------------------------------------------
select R.EMP_ID,R.FIRST_NAME,R.TOTAL,R.ranking,D.EMP_TITLE from RANKTABLE AS R join DESIGNATIONTABLE as D
ON R.EMP_ID =D.EMP_REF_ID
where ranking = 1 OR ranking = 4

---------------------------------------------------------------------------------------------------------------------
c)    The SQL CROSS JOIN produces a result set which is the number of rows in the first table multiplied by the 
number of rows in the second table if no WHERE clause is used along with CROSS JOIN
---------------------------------------------------------------------------------------------------------------------
SELECT EMPLOYEESTABLE.FIRST_NAME,DESIGNATIONTABLE.EMP_TITLE
  FROM EMPLOYEESTABLE
  CROSS JOIN DESIGNATIONTABLE
 WHERE DESIGNATIONTABLE.EMP_REF_ID = DESIGNATIONTABLE.EMP_REF_ID
 
 --------------------------------------------------------------------------------------------------------------------
d) Clause used with select statement and order of execution as follows:

1.FROM clause
2.ON clause
3.OUTER clause
4.WHERE clause
5.GROUP BY clause
6.SELECT clause
7.DISTINCT clause
8.ORDER BY clause
9. clause

Q3.
A stored procedure is a prepared code that you can save, so the code can be reused over and over again.
Not need to write again and again just execute the stored procedure.
-----------------------------------------------------------------------------------------------------------------------------
a).DETAILS OF THE EMPLOYEE WHO HAS GOT THEIR DESIGNATION UPDATED BETWEEN JULY TO DECEMEBER
-----------------------------------------------------------------------------------------------------------------------------

Select  E.EMP_ID, E.FIRST_NAME, E.LAST_NAME,E.SALARY,D.EMP_TITLE,D.AFFECTED_FROM
from EMPLOYEESTABLE AS E
JOIN DESIGNATIONTABLE AS D
ON E.EMP_ID = D.EMP_REF_ID
WHERE AFFECTED_FROM BETWEEN '2019-07-01' AND '2019-12-01'

---------------------------------------------------------------------------------------------------------------------------
STORED procedures of question 2 a)
 
---------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE highestandlowest()

BEGIN
     select FIRST_NAME,LAST_NAME,DEPARTMENT, SALARY,VARIABLES_AMOUNT from EMPLOYEESTABLE
      join VARIABLESDETAILS
      on EMPLOYEESTABLE.EMP_ID = VARIABLESDETAILS.EMP_REF_ID
      where VARIABLES_AMOUNT =(select Max(VARIABLES_AMOUNT) from VARIABLESDETAILS) or
      VARIABLES_AMOUNT =(select Min(VARIABLES_AMOUNT) from VARIABLESDETAILS)

END 
-----------------------------------------------------------------------------------------------------------------------------
