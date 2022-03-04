-- JOINS
-- 1
-- Get the firstname and lastname of the employees who placed orders between 15th August,1996 and 15th August,1997
select distinct
    employee.FirstName, employee.LastName
from
    employee
        join
    orders ON employee.EmployeeID = orders.EmployeeID
where
    OrderDate between date('1996-08-15') and date('1997-08-15');

-- 2
-- Get the distinct EmployeeIDs who placed orders before 16th October,1996
select distinct
    employee.EmployeeID
from
    employee
        join
    orders ON employee.EmployeeID = orders.EmployeeID
where
    orders.OrderDate < date('1996-08-16');
    
-- 3
-- How many products were ordered in total by all employees between 13th of January,1997 and 16th of April,1997.
select 
    sum(orderdetails.Quantity) as number_of_products
from
    orders
        join
    orderdetails ON orders.OrderID = orderdetails.OrderID
where
    orders.OrderDate between date('1997-01-13') and date('1997-04-16');

-- 4
/* What is the total quantity of products for which Anne Dodsworth placed orders between 13th of
January,1997 and 16th of April,1997 */
select 
    sum(orderdetails.Quantity)
from
    orders
        inner join
    employee ON employee.EmployeeID = orders.EmployeeID
        join
    orderdetails ON orders.OrderID = orderdetails.OrderID
where
    OrderDate between date('1997-01-13') and date('1997-04-16')
        and employee.FirstName = 'Anne'
        and employee.LastName = 'Dodsworth';
                
-- 5
-- How many orders have been placed in total by Robert King
select 
    count(*)
from
    orders
        inner join
    employee ON employee.EmployeeID = orders.EmployeeID
where
    employee.FirstName = 'Robert'
        and employee.LastName = 'King';
        
-- 6
-- How many products have been ordered by Robert King between 15th August,1996 and 15th August,1997
select 
    sum(orderdetails.Quantity)
from
    orders
        inner join
    employee ON employee.EmployeeID = orders.EmployeeID
        join
    orderdetails ON orders.OrderID = orderdetails.OrderID
where
    employee.FirstName = 'Robert'
        and employee.LastName = 'King'
        and orders.OrderDate between date('1996-08-15') and date('1997-08-15');
        
-- 7
/* I want to make a phone call to the employees to wish them on the occasion of Christmas who placed
orders between 13th of January,1997 and 16th of April,1997. I want the EmployeeID, Employee Full Name,
HomePhone Number. */
select distinct
    employee.EmployeeID,
    concat_ws(' ',
            employee.FirstName,
            employee.LastName) as EmployeeFullName,
    employee.HomePhone
from
    orders
        inner join
    employee ON employee.EmployeeID = orders.EmployeeID
where
    orders.OrderDate between date('1997-01-13') and date('1997-04-16');
    
-- 8
-- Which product received the most orders. Get the product's ID and Name and number of orders it received.
select 
    orderdetails.ProductID,
    products.ProductName,
    count(orderdetails.ProductID) as number_of_orders
from
    orderdetails
        inner join
    products ON orderdetails.ProductID = products.ProductID
group by orderdetails.ProductID
order by number_of_orders desc
limit 0 , 1;

-- 9
-- Which are the least shipped products. List only the top 5 from your list.
select 
    orderdetails.ProductID,
    products.ProductName,
    count(orderdetails.ProductID) as number_of_orders
from
    orderdetails
        inner join
    products ON orderdetails.ProductID = products.ProductID
group by orderdetails.ProductID
order by number_of_orders
limit 0,5;

-- 10
-- What is the total price that is to be paid by Laura Callahan for the order placed on 13th of January,1997
select 
    sum((orderdetails.Quantity * orderdetails.UnitPrice)) as total_price
from
    orderdetails
        join
    orders ON orders.OrderID = orderdetails.OrderID
        join
    employee ON orders.EmployeeID = employee.EmployeeID
where
    employee.FirstName = 'Laura'
        and employee.LastName = 'Callahan'
        and orders.OrderDate = date('1997-01-13');
    
-- 11
/* How many number of unique employees placed orders for Gorgonzola Telino or Gnocchi di nonna Alice or
Raclette Courdavault or Camembert Pierrot in the month January,1997 */
select 
    count(distinct orders.EmployeeID) as number_of_employees
from
    orders
        inner join
    orderdetails ON orderdetails.OrderID = orders.OrderID
        inner join
    products ON products.ProductID = orderdetails.ProductID
where
    products.ProductName in ('Gorgonzola Telino' , 'Gnocchi di nonna Alice',
        'Raclette Courdavault',
        'Camembert Pierrot')
        and year(orders.OrderDate) = 1997
        and month(orders.OrderDate) = 01;
        
-- 12
-- What is the full name of the employees who ordered Tofu between 13th of January,1997 and 30th of January,1997
select distinct
    concat_ws(' ',
            employee.FirstName,
            employee.LastName) as employee_name
from
    orderdetails
        join
    orders ON orderdetails.OrderID = orders.OrderID
        join
    products ON orderdetails.ProductID = products.ProductID
        join
    employee ON orders.EmployeeID = employee.EmployeeID
where
    products.ProductName = 'Tofu'
        and orders.OrderDate between date('1997-01-13') and date('1997-01-30');
            
-- 13
/* What is the age of the employees in days, months and years who placed orders during the month of
August. Get employeeID and full name as well */
select distinct
    (employee.EmployeeID),
    concat_ws(' ',
            employee.FirstName,
            employee.LastName) as employee_full_name,
    timestampdiff(day,
        employee.BirthDate,
        current_date) as age_in_days,
    timestampdiff(month,
        employee.BirthDate,
        current_date) as age_in_months,
    timestampdiff(year,
        employee.BirthDate,
        current_date) as age_in_years
from
    orders
        inner join
    employee ON employee.EmployeeID = orders.EmployeeID
where
    month(orders.OrderDate) = 08;
    
-- 14
-- Get all the shipper's name and the number of orders they shipped
select 
    shippers.CompanyName,
    count(shippers.ShipperID) as number_of_orders
from
    shippers
        join
    orders ON shippers.ShipperID = orders.ShipperID
group by shippers.ShipperID;

-- 15
-- Get the all shipper's name and the number of products they shipped.
select 
    shippers.CompanyName,
    sum(orderdetails.Quantity) as number_of_products
from
    shippers
        join
    orders ON orders.ShipperID = shippers.ShipperID
        join
    orderdetails ON orderdetails.OrderID = orders.OrderID
group by shippers.ShipperID;

-- 16
-- Which shipper has bagged most orders. Get the shipper's id, name and the number of orders
select 
    shippers.ShipperID,
    count(shippers.ShipperID) as number_of_orders
from
    orders
        join
    shippers ON shippers.ShipperID = orders.ShipperID
group by shippers.ShipperID
order by number_of_orders desc
limit 1;

-- 17
/* Which shipper supplied the most number of products between 10th August,1996 and 20th
September,1998. Get the shipper's name and the number of products. */
select 
    shippers.ShipperID,
    shippers.CompanyName,
    count(shippers.ShipperID) as number_of_orders
from
    orders
        join
    shippers ON shippers.ShipperID = orders.ShipperID
where
    orders.OrderDate between date('1996-08-10') and date('1998-09-20')
group by shippers.ShipperID
order by number_of_orders desc
limit 1;

-- 18
-- Which employee didn't order any product 4th of April 1997
select 
    EmployeeID,
    concat_ws(' ', FirstName, LastName) as employee_name
from
    employee
where
    EmployeeID not in (select 
            EmployeeID
        from
            orders
        where
            OrderDate = date('1997-04-04'));

-- 19
--  How many products where shipped to Steven Buchanan
select 
    sum(orderdetails.Quantity) as number_of_products
from
    orders
        join
    orderdetails ON orders.OrderID = orderdetails.OrderID
where
    orders.EmployeeID = (select 
            EmployeeID
        from
            employee
        where
            FirstName = 'Steven'
                and LastName = 'Buchanan');
                
-- 20
--  How many orders where shipped to Michael Suyama by Federal Shipping
select 
    count(*) as number_of_orders
from
    orders
        join
    employee ON employee.EmployeeID = orders.EmployeeID
        join
    shippers ON shippers.ShipperID = orders.ShipperID
where
    employee.FirstName = 'Michael'
        and employee.LastName = 'Suyama'
        and shippers.CompanyName = 'Federal Shipping';
        
-- 21
-- How many orders are placed for the products supplied from UK and Germany
select 
    count(distinct OrderID) as number_of_orders
from
    orderdetails
        join
    products ON orderdetails.ProductID = products.ProductID
        join
    suppliers ON suppliers.SupplierID = products.SupplierID
where
    (suppliers.Country = 'UK'
        or suppliers.Country = 'Germany');
        
-- 22
-- How much amount Exotic Liquids received due to the order placed for its products in the month of January,1997
select 
    sum(total_price(orderdetails.Quantity,
            orderdetails.UnitPrice)) as total_amount
from
    orderdetails
        join
    products ON orderdetails.ProductID = products.ProductID
        join
    orders ON orders.OrderID = orderdetails.OrderID
where
    products.SupplierID = (select 
            SupplierID
        from
            suppliers
        where
            CompanyName = 'Exotic Liquids')
        and orders.OrderDate between date('1997-01-01') and date('1997-01-31');
        
-- 23
-- In which days of January, 1997, the supplier Tokyo Traders haven't received any orders
with recursive cte (days) as (
select 1
union all
select days+1
from cte
where days<31
)
select days as days_without_orders from cte where days not in (select 
    day(orders.OrderDate)
from
    orders
        join
    orderdetails on orderdetails.OrderID = orders.OrderID
        join
    products on products.ProductID = orderdetails.ProductID
where
    orders.OrderDate between date('1997-01-01') and date('1997-01-31')
    and products.SupplierID=(select SupplierID from suppliers where CompanyName="Tokyo Traders"));
    
-- 24
-- Which of the employees did not place any order for the products supplied by Ma Maison in the month of May
select 
    concat_ws(' ', FirstName, LastName) as EmployeeName
from
    employee
where
    EmployeeID not in (select distinct
            EmployeeID
        from
            orders
                join
            orderdetails ON orders.OrderID = orderdetails.OrderID
                join
            products ON products.ProductID = orderdetails.ProductID
        where
            month(orders.OrderDate) = 05
                and products.SupplierID = (select 
                    SupplierID
                from
                    suppliers
                where
                    CompanyName = 'Ma Maison'));
                    
-- 25
-- Which shipper shipped the least number of products for the month of September and October,1997 combined
select 
    shippers.ShipperID,
    shippers.CompanyName,
    count(orders.ShipperID) as number_of_orders
from
    orders
        join
    shippers ON shippers.ShipperID = orders.ShipperID
where
    orders.OrderDate between date('1997-09-01') and date('1997-10-31')
group by shippers.ShipperID
order by number_of_orders asc
limit 1;

-- 26
-- What are the products that weren't shipped at all in the month of August, 1997
select 
    ProductID, ProductName
from
    products
where
    ProductID not in (select distinct
            orderdetails.ProductID
        from
            orders
                join
            orderdetails ON orders.OrderID = orderdetails.OrderID
                join
            products ON products.ProductID = orderdetails.ProductID
        where
            orders.OrderDate between date('1997-08-01') and date('1997-08-31'));
            
-- 27
-- What are the products that weren't ordered by each of the employees. List each employee and the products that he didn't order.

select 
    shippers.CompanyName,
    count(orders.ShipperID) as number_of_orders
from
    orders
        join
    shippers ON orders.ShipperID = shippers.ShipperID
where
    (orders.OrderDate between date('1996-04-01') and date('1996-04-30'))
        or (orders.OrderDate between date('1996-05-01') and date('1996-05-31'))
        or (orders.OrderDate between date('1996-06-01') and date('1996-06-30'))
        or (orders.OrderDate between date('1997-04-01') and date('1997-04-30'))
        or (orders.OrderDate between date('1997-05-01') and date('1997-05-31'))
        or (orders.OrderDate between date('1997-06-01') and date('1997-06-30'))
group by shippers.ShipperID
order by number_of_orders desc
limit 1;

-- 29
-- Which country supplied the maximum products for all the employees in the year 1997
with country_products as (
select 
    suppliers.Country, count(suppliers.Country) as number_of_products
from
    orders
        join
    orderdetails on orders.OrderID = orderdetails.OrderID
        join
    products on products.ProductID = orderdetails.ProductID
        join
    suppliers on suppliers.SupplierID = products.SupplierID
    where year(OrderDate)=1997 group by suppliers.Country)
    select Country from country_products where number_of_products=(select max(number_of_products) from country_products);
    
-- 30
-- What is the average number of days taken by all shippers to ship the product after the order has been placed by the employees
select 
    avg(timestampdiff(day,
        OrderDate,
        ShippedDate)) as avg_days_to_delever
from
    orders;
    
-- 31
-- Who is the quickest shipper of all.
with shipper_time as (
select 
	shippers.CompanyName,
    timestampdiff(day,
        OrderDate,
        ShippedDate) as days_to_deliver
from
    orders join shippers on orders.ShipperID=shippers.ShipperID)
select CompanyName as number_of_least_time 
from shipper_time where days_to_deliver=(
select min(days_to_deliver) from shipper_time) 
group by CompanyName order by Count(companyName) 
desc 
limit 1;

-- 32
/* Which order took the least number of shipping days. Get the orderid, employees full name, number of
products, number of days took to ship and shipper company name. */
with order_products as (
select
	orders.OrderID,
    concat_ws(' ',employee.FirstName, employee.LastName) as EmployeeName,
    count(orderdetails.OrderID) as number_of_products,
    timestampdiff(day,
        OrderDate,
        ShippedDate) as days_to_deliver,
	shippers.CompanyName
from
    orders
        join
    employee on orders.EmployeeID = employee.EmployeeID
        join
    orderdetails on orderdetails.OrderID = orders.OrderID
        join
    shippers on shippers.ShipperID = orders.ShipperID
    group by orders.OrderID)
select * from order_products where days_to_deliver=(select min(days_to_deliver) from order_products);

-- UNIONS
-- 1
/*  Which orders took the least number and maximum number of shipping days? Get the orderid, employees
full name, number of products, number of days taken to ship the product and shipper company name. Use
1 and 2 in the final result set to distinguish the 2 orders. */
with order_products as (
select
	orders.OrderID,
    concat_ws(' ',employee.FirstName, employee.LastName) as EmployeeName,
    count(orderdetails.OrderID) as number_of_products,
    timestampdiff(day,
        OrderDate,
        ShippedDate) as days_to_deliver,
	shippers.CompanyName
from
    orders
        join
    employee on orders.EmployeeID = employee.EmployeeID
        join
    orderdetails on orderdetails.OrderID = orders.OrderID
        join
    shippers on shippers.ShipperID = orders.ShipperID
    group by orders.OrderID)
select * from order_products where days_to_deliver=(select min(days_to_deliver) from order_products)
union
select * from order_products where days_to_deliver=(select max(days_to_deliver) from order_products);

-- 2
/* Which is cheapest and the costliest of products purchased in the second week of October, 1997. Get the
product ID, product Name and unit price. Use 1 and 2 in the final result set to distinguish the 2 products. */
with product_prices as (
select distinct
    orderdetails.ProductID,
    products.ProductName,
    products.UnitPrice
from
    orders
        join
    orderdetails on orders.OrderID = orderdetails.OrderID
        join
    products on orderdetails.ProductID = products.ProductID
where
    orders.OrderDate between date('1997-10-8') and date('1997-10-14'))
select 1 as id, ProductID, ProductName, UnitPrice from product_prices where UnitPrice=(select min(UnitPrice) from product_prices)
union
select 2 as id, ProductID, ProductName, UnitPrice from product_prices where UnitPrice=(select max(UnitPrice) from product_prices);

-- CASE
-- 1
/* Find the distinct shippers who are to ship the orders placed by employees with IDs 1, 3, 5, 7
Show the shipper's name as "Express Speedy" if the shipper's ID is 2 and "United Package" if the shipper's
ID is 3 and "Shipping Federal" if the shipper's ID is 1. */
select distinct
    ShipperID,
    case
        when ShipperID = 1 then 'Shipping Federal'
        when ShipperID = 2 then 'Express Speedy'
        else 'United Package'
    end as shipper_name
from
    orders
where
    EmployeeID in (1 , 3, 5, 7);