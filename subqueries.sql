select * from security_01
select *from Scty_Tran
select*from SCTY_PRICE

--1.Find out scty_code,company and sedol_code for those records for which market price is less than 500 
--and pricing factor is less than 100.
select Scty_code, Company,Sedol_code
FROM
 security_01
where Scty_code in (select  Sec_id  FROM SCTY_PRICE WHERE Mkt_Price<500 AND Pricing_factor <100)

--WE CANNOT LIST ANY COLUMN IN OUTER SELECT STATMENET 
--WHICH ARE PRESENT IN INNER SELECT SELECT STATEMENT
-- 1ST QUESTION CAN ALSO BE DONE WITH THE HELP OF JOINS 
 select Scty_code, Company,Sedol_code
from security_01 AS S
 inner join Scty_Tran AS ST
 on S.Scty_code = ST.Scty_code 
where Mkt_Price<500 and Pricing_factor <100

--5 find out security code ,currency,pricing factor for such record for which market_price is
--Greater than average market price of the same table 
--using the sql sub query
select Sec_id, Currency ,Pricing_factor from SCTY_PRICE where Mkt_price < (Select avg(Mkt_price) from SCTY_PRICE)

--2.Find out security code,market price,pricing factor for those records for which sedol code is 184732 and 543917.

select  Sec_id , Mkt_price , Pricing_factor   FROM SCTY_PRICE 
WHERE  Sec_id in (select Scty_code  from security_01 where Sedol_code in (184732,543917))

--3.Find out scty_code ,tin number for which trade date ranges from jan 1,2013 to dec 31,2013 and broker starts with 'i'
 select s.Scty_code ,Tin_number  FROM security_01 AS s
 WHERE s.Scty_code in (select  Scty_code from Scty_Tran  where  Trade_date between '01-01-2013'and '12-31-2013')


--4.Find out security code, sedol_code for which pricing_factor is less than 100 and Entry_date ranges from jan 1,2009 to jul 31,2013.

select Scty_code , Sedol_code from security_01 
WHERE Scty_code in (select Sec_id from SCTY_PRICE  WHERE SEC_ID IN
(SELECT Scty_code FROM Scty_Tran WHERE 
Entry_date BETWEEN '01-01-2009' AND '07-31-2013' AND  Pricing_factor <100) )
 
 --ASSIGNMENT 
--DIFFERNET TYPE OF QUERIES
--8
select pp.productid,name from Production.Product as pp where pp.ProductID in
(select ss.productid from sales.SalesOrderDetail as ss where pp.productid=ss.productid 
group by pp.ProductID,name
having SUM(UnitPrice)>2000000) 


--9. Write a Query to return all productid, name used in production.product which are also used in sales.salesOrderDetail.
SELECT *FROM  Production.Product 
SELECT *FROM Sales.SalesOrderHeader
SELECT *FROM Sales.SalesOrderDetail


SELECT pp.ProductID , name from Production.Product   AS pp
WHERE  pp.ProductID in (select ProductID from Sales.SalesOrderDetail)
--10. Write a Query to return productid, name that were ordered in July 2005. 
--Use Tables Production.product, Sales.SalesOrderDetail and Sales.SalesOrderHeader.
-- (Write using nested Sub-query and joins seperately).
select pp.ProductID,name from Production.Product as pp where pp.ProductID in
(select ss.productid from sales.SalesOrderDetail as ss where ss.SalesOrderID in
(select sh.salesOrderID from sales.SalesOrderHeader as sh where sh.OrderDate between '07-01-2005' and '07-30-2005')) 
--11. Write a Query that returns productid, name and their corresponding list price
-- for all products that have been sold 
--(Use Production.product and Sales.SalesOrderDetail and write a correlated query)

select productid,name,listprice from Production.Product as pp where pp.ProductID in
(select ss.productid from sales.salesorderdetail as ss where pp.ProductID=ss.ProductID) 

--12. Write a Query which returns productid, name where productsubcategoryid is 1 
--and productid is present in Production.Product and Sales.SalesOrderDetail.

select productid,name from Production.Product  where ProductSubcategoryID=1 and productid in
(select ss.productid from sales.SalesOrderDetail as ss)

