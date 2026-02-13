--  Q 1 What is the average number of orders per customer? Are there high-value repeat customers?
SELECT 
    COUNT(o.OrderID) / COUNT(DISTINCT o.CustomerID) AS Avg_Orders_Per_Customer
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID;
    
    
-- Are there high-value repeat customers?
select count(*) from (
   select o.CustomerID,
    count( od.OrderID) AS Total_Orders,
    sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Total_Spend
from order_details od
join orders o
    on od.OrderID = o.OrderID
group by  o.CustomerID
having  COUNT( od.OrderID) > 10 and  Total_Spend > 5000
order by  Total_Spend desc) t;



-- Q 2 How do customer order patterns vary by city or country? 
 
 WITH cte AS 
  (SELECT CustomerID,COUNT(DISTINCT OrderID) AS orders_placed
    FROM orders
    GROUP BY CustomerID)
SELECT Country, City,
    AVG(orders_placed) as Avg_order_placed
FROM cte ct
JOIN customers c
    ON ct.CustomerID = c.CustomerID
GROUP BY Country, City;


-- Q3 Can we cluster customers based on total spend, order count, and preferred categories?

With preferred_category as (
select *,row_number() over ( partition by CustomerID order by total_orders desc ) rn 
from (
select o.CustomerID,cg.CategoryName, count(o.OrderID)  total_orders
from orders o 
join order_details od 
on o.OrderID = od.OrderID 
join products p 
on od.ProductID = p.ProductID 
join categories cg 
on p.CategoryID = cg.CategoryID 
group by o.CustomerID,cg.CategoryName 
order by o.CustomerID 
) s  
),
cte2 as 
(select o.CustomerID,Count(distinct o.OrderID) total_orders,sum(od.UnitPrice*od.Quantity*(1-od.Discount)) total_spend
from orders o 
join order_details od 
on o.OrderID = od.OrderID 
group by o.CustomerID )
select cte2.CustomerID, CategoryName, cte2.total_orders,cte2.total_spend
from  preferred_category pc
Join cte2  
on cte2.CustomerID = pc.CustomerID 
where rn =1 
order by cte2.total_orders desc;

-- Q5 Are there any correlations between orders and customer location or product category?

SELECT
    shipcountry,
    categoryname,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT o.OrderID) AS total_orders
FROM orders o
JOIN order_details od
    ON o.OrderID = od.OrderID
JOIN products p
    ON p.ProductID = od.ProductID
JOIN categories ct
    ON ct.CategoryID = p.CategoryID
GROUP BY shipcountry, categoryname;


-- Q6 How frequently do different customer segments place orders?
 
 select	 CustomerID, orderdate,
 lead(orderdate) over( partition by CustomerID order by orderdate) as Diff_order_date,
 datediff(lead(orderdate) over( partition by CustomerID),orderdate)
 from orders;

-- Q7 What is the geographic and title-wise distribution of employees?

select title , city , count(employeeid) 
from employees
group by title , city;


-- Q8 What trends can we observe in hire dates across employee titles?

SELECT 
    Title,
    YEAR(HireDate) AS hire_year,
    COUNT(*) AS employees_hired
FROM employees
GROUP BY Title, YEAR(HireDate)
ORDER BY Title, hire_year;




-- Q9 What patterns exist in employee title and courtesy title distributions?

select employeeid , title , TitleOfCourtesy, count(*) from employees 
group by 1,2,3;



-- Q10 Are there correlations between product pricing, stock levels, and sales performance?


select p.ProductID, p.ProductName,p.unitprice,p.UnitsInStock,
sum(od.Quantity) As Total_QTY ,
sum(od.salesprice) as Total_Revenue 
from order_details as od join products as p 
on od.ProductID=p.ProductID
group by  p.ProductID, p.ProductName,p.unitprice,p.UnitsInStock;


-- stock levels, and sales performance?  
-- 1 Low  2 Meduim 3 High

SELECT  
    CASE 
        WHEN od.UnitPrice < 20 THEN 'Low Price'
        WHEN od.UnitPrice BETWEEN 20 AND 100 THEN 'Medium Price'
        ELSE 'High Price'
    END AS price_category,
    
    round(SUM(od.Quantity),2) AS total_qty,
    round(SUM(od.UnitPrice * od.Quantity),2) AS total_revenue

FROM order_details od
GROUP BY 
    CASE 
        WHEN od.UnitPrice < 20 THEN 'Low Price'
        WHEN od.UnitPrice BETWEEN 20 AND 100 THEN 'Medium Price'
        ELSE 'High Price'
    END;



-- Q11 How does product demand change over months or seasons?

-- 1   Year Wise Product Demand 

select Year(o.OrderDate) as Years ,
month(o.orderdate) as Months,
round(sum(od.salesprice),2) as Total_Revenue
from orders as o join order_details as od 
on o.orderid=od.orderid
group by years , months;


--  Session  and product Wise Analysis
select p.productname,case 
		when month(o.OrderDate) in (12,1,2) then 'Winters'
        when month(o.OrderDate) in (3,4,5) then 'Summer'
        when month(o.OrderDate) in (6,7,8) then 'Monsoon'
        else 'Autumn' End As Seasion,
round(sum(od.Quantity),2) As Total_QTY,
round(sum(od.salesprice),2) as Total_revenue
from orders as o join order_details as od 
on o.OrderID=od.OrderID
join products as p 
on od.ProductID=p.ProductID
group by p.productname, case 
		when month(o.OrderDate) in (12,1,2) then 'Winters'
        when month(o.OrderDate) in (3,4,5) then 'Summer'
        when month(o.OrderDate) in (6,7,8) then 'Monsoon'
        else 'Autumn' End;
        
-- Q12  Can we identify anomalies in product sales or revenue performance?


SELECT 
    MONTH(o.OrderDate) AS month_no,
    MONTHNAME(o.OrderDate) AS month_name,
    YEAR(o.OrderDate) AS year,

    ROUND(AVG(od.SalesPrice), 2) AS avg_month_revenue,
    ROUND(AVG(od.Quantity), 2)   AS avg_month_sold_qty

FROM orders o
JOIN order_details od
    ON o.OrderID = od.OrderID

GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate),
    MONTHNAME(o.OrderDate)

HAVING 
    AVG(od.SalesPrice) >
    (SELECT AVG(SalesPrice) FROM order_details)

ORDER BY
    year asc , month_no asc;
    
    
    
--  Q13 Can we identify anomalies in product sales or revenue performance?
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Total_Revenue
FROM order_details od
JOIN products p 
    ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY Total_Revenue DESC;



-- Q14  How are suppliers distributed across different product categories?


select sup.SupplierID,sup.CompanyName,c.CategoryName
from suppliers as sup join products as p 
on sup.SupplierID=p.SupplierID
join categories as c 
on p.CategoryID=c.CategoryID;



-- Q15 How do supplier pricing and categories relate across different regions?

select s.SupplierID, s.CompanyName,cat.CategoryName,o.ShipRegion,avg(od.SalesPrice)
from suppliers as s join orders as o 
on s.SupplierID=o.ShipVia
join products as p 
on s.SupplierID=p.SupplierID
join categories as cat 
on cat.CategoryID=p.CategoryID
join order_details as od 
on o.OrderID=od.OrderID
group by s.SupplierID, s.CompanyName,cat.CategoryName,o.ShipRegion




