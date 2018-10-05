-- Assignment 3 - Queries 
-- David Agaybi - 991491884
-- Date: 10/4/2018

-- Q1

SELECT * FROM s2.baseoption;
SELECT * FROM s2.car;
SELECT * FROM s2.customer;
SELECT * FROM s2.employee;
SELECT * FROM s2.invoption;
SELECT * FROM s2.options;
SELECT * FROM s2.prospect;
SELECT * FROM s2.saleinv;
SELECT * FROM s2.servinv;
SELECT * FROM s2.servwork;


-- Q2

SELECT COUNT(*) 
FROM s2.saleinv
WHERE fire = 'Y'
OR collision = 'Y'
OR liability = 'Y'
OR property = 'Y'


-- Q3

SELECT * 
FROM s2.customer 
JOIN s2.prospect ON s2.customer.cname = s2.prospect.cname
WHERE make = 'JAGUAR'
AND color = 'BLUE'


-- Q4

SELECT DISTINCT s2.customer.cname, s2.customer.chphone
FROM s2.customer
JOIN s2.car ON s2.customer.cname = s2.car.cname
WHERE make = 'JAGUAR'
AND model = 'XJR'
AND s2.customer.cbphone IS NULL
ORDER BY cname DESC


-- Q5

SELECT ROUND(AVG(s2.servinv.totalcost)) 
FROM s2.servinv
JOIN s2.car ON s2.servinv.serial = s2.car.serial
WHERE s2.car.make = 'MERCEDES'
AND s2.car.cyear = '2016'


-- Q6

SELECT s2.customer.cname, s2.customer.chphone, s2.customer.cbphone
FROM s2.customer
JOIN s2.saleinv ON s2.customer.cname = s2.saleinv.cname
JOIN s2.servinv ON s2.saleinv.cname = s2.servinv.cname
WHERE s2.customer.cname IN s2.saleinv.cname
AND s2.customer.cname NOT IN s2.servinv.cname


-- Q7

SELECT a.cname || a.cstreet || a.ccity || a.cprov || a.cpostal || b.make || b.model
FROM s2.customer a, s2.car b, s2.saleinv c
WHERE a.cname = b.cname
AND b.cname = c.cname
AND a.cname = c.cname
AND totalprice = (SELECT MAX(totalprice) FROM s2.saleinv)


-- Q8

SELECT round(AVG(a.totalcost)), COUNT(*) 
FROM s2.servinv a, s2.saleinv b, s2.car c
WHERE a.cname = b.cname
AND a.serial = c.serial
AND c.make IN ('LAND ROVER', 'MERCEDES', 'JAGUAR')
AND b.saledate BETWEEN '2014-02-01' AND '2018-01-01'


-- Q9

SELECT salesman 
FROM s2.saleinv
GROUP BY salesman
HAVING COUNT(salesman) <= 3


-- Q10

SELECT a.cname 
FROM s2.saleinv a, s2.options b, s2.invoption c
WHERE a.saleinv = c.saleinv
AND b.ocode = c.ocode
AND b.odesc = 'SUN ROOF'


-- Q11

SELECT b.serial, b.make, b.model, a.ocode, c.odesc, c.olist
FROM s2.baseoption a, s2.car b, s2.options c
WHERE a.serial = b.serial
AND a.ocode = c.ocode
AND b.cname IS NULL
AND b.cyear = '2014'


-- Q12

SELECT a.cname, SUM(c.saleprice)
FROM s2.customer a, s2.saleinv b, s2.invoption c
WHERE a.cname = b.cname
AND b.saleinv = c.saleinv
AND a.ccity = 'BRAMPTON'
GROUP BY a.cname
HAVING SUM(c.saleprice) >=500
ORDER BY a.cname ASC


-- Q13

SELECT DISTINCT a.cname, a.cstreet || a.ccity || a.cprov || a.cpostal || a.chphone,
b.make, b.model, b.cyear, b.color
FROM s2.customer a, s2.prospect b, s2.car c
WHERE a.cname = b.cname
AND b.make = c.make
AND b.model = c.model
AND b.cyear = c.cyear
AND b.color = c.color
AND c.cname IS NULL
ORDER BY cname ASC



