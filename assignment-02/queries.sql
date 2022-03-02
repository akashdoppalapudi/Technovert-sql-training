/* JOINS */
/* 1 */
SELECT 
    employee.FirstName, employee.LastName
FROM
    employee
        JOIN
    orders ON employee.EmployeeID = orders.EmployeeID
WHERE
    OrderDate BETWEEN '1996-08-15' AND '1997-08-15'
GROUP BY orders.EmployeeID;

/* 2 */
SELECT DISTINCT
    (employee.EmployeeID)
FROM
    employee
        JOIN
    orders ON employee.EmployeeID = orders.EmployeeID
WHERE
    orders.OrderDate < '1996-08-16';
    
/* 3 */
SELECT 
    COUNT(*)
FROM
    orders
WHERE
    OrderDate BETWEEN '1997-01-13' AND '1997-04-16';

/* 4 */
SELECT 
    COUNT(*)
FROM
    orders
        LEFT JOIN
    employee ON employee.EmployeeID = orders.EmployeeID
WHERE
    OrderDate BETWEEN '1997-01-13' AND '1997-04-16'
        AND employee.FirstName = 'Anne'
        AND employee.LastName = 'Dodsworth';
                
/* 5 */
SELECT 
    COUNT(*)
FROM
    orders
        LEFT JOIN
    employee ON employee.EmployeeID = orders.EmployeeID
WHERE
    employee.FirstName = 'Robert'
        AND employee.LastName = 'King';
        
/* 6 */
SELECT 
    COUNT(*)
FROM
    orders
        LEFT JOIN
    employee ON employee.EmployeeID = orders.EmployeeID
WHERE
    employee.FirstName = 'Robert'
        AND employee.LastName = 'King'
        AND orders.OrderDate BETWEEN '1996-08-15' AND '1997-08-15';
        
/* 7 */
SELECT 
    distinct(employee.EmployeeID),
    CONCAT(employee.FirstName,
            ' ',
            employee.LastName) as EmployeeFullName,
    employee.HomePhone
FROM
    orders
        LEFT JOIN
    employee ON employee.EmployeeID = orders.EmployeeID
WHERE
    orders.OrderDate BETWEEN '1997-01-13' AND '1997-04-16';
    
/* 8 */
with product_orders as (
SELECT 
    orderdetails.ProductID, products.ProductName, COUNT(orderdetails.ProductID) as number_of_orders
FROM
    orderdetails
        LEFT JOIN
    products ON orderdetails.ProductID = products.ProductID group by orderdetails.ProductID) 
SELECT * FROM product_orders 
WHERE number_of_orders=(SELECT max(number_of_orders) FROM product_orders);

/* 9 */
SELECT 
    orderdetails.ProductID,
    products.ProductName,
    COUNT(orderdetails.ProductID) AS number_of_orders
FROM
    orderdetails
        LEFT JOIN
    products ON orderdetails.ProductID = products.ProductID
GROUP BY orderdetails.ProductID
ORDER BY number_of_orders
LIMIT 5;

/* 10 */
DELIMITER $$
create function total_price(quantity int, unit_price decimal)		/* Function to find total price for all products */
returns decimal
deterministic
begin
declare total_price decimal;
set total_price = quantity * unit_price;
return total_price;
end $$
DELIMITER ;

SELECT 
    sum(total_price(orderdetails.Quantity, orderdetails.UnitPrice)) as total_price
FROM
    orderdetails
        JOIN
    orders ON orders.OrderID = orderdetails.OrderID
WHERE
    orders.EmployeeID = (SELECT 
            EmployeeID
        FROM
            employee
        WHERE
            FirstName = 'Laura'
                AND LastName = 'Callahan')
	and orders.OrderDate="1997-01-13";
    
/* 11 */
SELECT 
    count(distinct orders.EmployeeID) as number_of_employees
FROM
    orders
        LEFT JOIN
    orderdetails ON orderdetails.OrderID = orders.OrderID
        INNER JOIN
    products ON products.ProductID = orderdetails.ProductID
WHERE
    products.ProductName IN ('Gorgonzola Telino' , 'Gnocchi di nonna Alice',
        'Raclette Courdavault',
        'Camembert Pierrot')
        AND orders.OrderDate BETWEEN '1997-01-01' AND '1997-01-31';
        
/* 12 */
SELECT DISTINCT
    CONCAT(employee.FirstName,
            ' ',
            employee.LastName) AS employee_name
FROM
    orders
        JOIN
    employee ON orders.EmployeeID = employee.EmployeeID
        JOIN
    orderdetails ON orderdetails.OrderID = orders.OrderID
WHERE
    orderdetails.ProductID = (SELECT 
            ProductID
        FROM
            products
        WHERE
            ProductName = 'Tofu')
        AND orders.OrderDate BETWEEN '1997-01-13' AND '1997-01-30';
            
/* 13 */
SELECT DISTINCT
    (employee.EmployeeID),
    CONCAT(employee.FirstName,
            ' ',
            employee.LastName) AS employee_full_name,
    TIMESTAMPDIFF(DAY,
        employee.BirthDate,
        CURRENT_DATE) AS age_in_days,
    TIMESTAMPDIFF(MONTH,
        employee.BirthDate,
        CURRENT_DATE) AS age_in_months,
    TIMESTAMPDIFF(YEAR,
        employee.BirthDate,
        CURRENT_DATE) AS age_in_years
FROM
    orders
        INNER JOIN
    employee ON employee.EmployeeID = orders.EmployeeID
WHERE
    MONTH(orders.OrderDate) = 08;
    
/* 14 */
SELECT 
    shippers.CompanyName,
    COUNT(shippers.ShipperID) AS number_of_orders
FROM
    orders
        JOIN
    shippers ON shippers.ShipperID = orders.ShipperID
GROUP BY shippers.ShipperID;

/* 15 */
SELECT 
    shippers.CompanyName,
    SUM(orderdetails.Quantity) AS number_of_products
FROM
    orders
        JOIN
    shippers ON orders.ShipperID = shippers.ShipperID
        JOIN
    orderdetails ON orderdetails.OrderID = orders.OrderID
GROUP BY shippers.ShipperID;

/* 16 */
SELECT 
    shippers.ShipperID,
    COUNT(shippers.ShipperID) AS number_of_orders
FROM
    orders
        JOIN
    shippers ON shippers.ShipperID = orders.ShipperID
GROUP BY shippers.ShipperID
ORDER BY number_of_orders DESC
LIMIT 1;

/* 17 */
SELECT 
    shippers.ShipperID,
    shippers.CompanyName,
    COUNT(shippers.ShipperID) AS number_of_orders
FROM
    orders
        JOIN
    shippers ON shippers.ShipperID = orders.ShipperID
    where orders.OrderDate between "1996-08-10" and "1998-09-20"
GROUP BY shippers.ShipperID 
ORDER BY number_of_orders DESC limit 1;

/* 18 */
SELECT 
    EmployeeID,
    CONCAT(FirstName, ' ', LastName) AS employee_name
FROM
    employee
WHERE
    EmployeeID NOT IN (SELECT 
            EmployeeID
        FROM
            orders
        WHERE
            OrderDate = '1997-04-04');

/* 19 */
SELECT 
    sum(orderdetails.Quantity) as number_of_products
FROM
    orders join orderdetails on orders.OrderID=orderdetails.OrderID
WHERE
    orders.EmployeeID = (SELECT 
            EmployeeID
        FROM
            employee
        WHERE
            FirstName = 'Steven'
                AND LastName = 'Buchanan');
                
/* 20 */
SELECT 
    COUNT(*) AS number_of_orders
FROM
    orders
        JOIN
    employee ON employee.EmployeeID = orders.EmployeeID
        JOIN
    shippers ON shippers.ShipperID = orders.ShipperID
WHERE
    employee.FirstName = 'Michael'
        AND employee.LastName = 'Suyama'
        AND shippers.CompanyName = 'Federal Shipping';
        
/* 21 */
SELECT 
    count(distinct OrderID) as number_of_orders
FROM
    orderdetails
        JOIN
    products ON orderdetails.ProductID = products.ProductID
        JOIN
    suppliers ON suppliers.SupplierID = products.SupplierID
WHERE
    (suppliers.Country = 'UK'
        OR suppliers.Country = 'Germany');
        
/* 22 */
SELECT 
    SUM(TOTAL_PRICE(orderdetails.Quantity,
            orderdetails.UnitPrice)) AS total_amount
FROM
    orderdetails
        JOIN
    products ON orderdetails.ProductID = products.ProductID
        JOIN
    orders ON orders.OrderID = orderdetails.OrderID
WHERE
    products.SupplierID = (SELECT 
            SupplierID
        FROM
            suppliers
        WHERE
            CompanyName = 'Exotic Liquids')
        AND orders.OrderDate BETWEEN '1997-01-01' AND '1997-01-31';
        
/* 23 */
with recursive cte (days) as (
select 1
union all
select days+1
from cte
where days<31
)
select days as days_without_orders from cte where days not in (SELECT 
    Day(orders.OrderDate)
FROM
    orders
        JOIN
    orderdetails ON orderdetails.OrderID = orders.OrderID
        JOIN
    products ON products.ProductID = orderdetails.ProductID
WHERE
    orders.OrderDate BETWEEN '1997-01-01' AND '1997-01-31'
    and products.SupplierID=(select SupplierID from suppliers where CompanyName="Tokyo Traders"));
    
/* 24 */
SELECT 
    CONCAT(FirstName, ' ', LastName) AS EmployeeName
FROM
    employee
WHERE
    EmployeeID NOT IN (SELECT DISTINCT
            EmployeeID
        FROM
            orders
                JOIN
            orderdetails ON orders.OrderID = orderdetails.OrderID
                JOIN
            products ON products.ProductID = orderdetails.ProductID
        WHERE
            MONTH(orders.OrderDate) = 05
                AND products.SupplierID = (SELECT 
                    SupplierID
                FROM
                    suppliers
                WHERE
                    CompanyName = 'Ma Maison'));
                    
/* 25 */
SELECT 
    shippers.ShipperID,
    shippers.CompanyName,
    COUNT(orders.ShipperID) AS number_of_orders
FROM
    orders
        JOIN
    shippers ON shippers.ShipperID = orders.ShipperID
WHERE
    orders.OrderDate BETWEEN '1997-09-01' AND '1997-10-31'
GROUP BY shippers.ShipperID
ORDER BY number_of_orders ASC
LIMIT 1;

/* 26 */
SELECT 
    ProductID, ProductName
FROM
    products
WHERE
    ProductID NOT IN (SELECT DISTINCT
            orderdetails.ProductID
        FROM
            orders
                JOIN
            orderdetails ON orders.OrderID = orderdetails.OrderID
                JOIN
            products ON products.ProductID = orderdetails.ProductID
        WHERE
            orders.OrderDate BETWEEN '1997-08-01' AND '1997-08-31');
            
/* 27 */

/* 28 */
SELECT 
    shippers.CompanyName,
    COUNT(orders.ShipperID) AS number_of_orders
FROM
    orders
        JOIN
    shippers ON orders.ShipperID = shippers.ShipperID
WHERE
    (orders.OrderDate BETWEEN '1996-04-01' AND '1996-04-30')
        OR (orders.OrderDate BETWEEN '1996-05-01' AND '1996-05-31')
        OR (orders.OrderDate BETWEEN '1996-06-01' AND '1996-06-30')
        OR (orders.OrderDate BETWEEN '1997-04-01' AND '1997-04-30')
        OR (orders.OrderDate BETWEEN '1997-05-01' AND '1997-05-31')
        OR (orders.OrderDate BETWEEN '1997-06-01' AND '1997-06-30')
GROUP BY shippers.ShipperID
ORDER BY number_of_orders DESC
LIMIT 1;

/* 29 */
with country_products as (
SELECT 
    suppliers.Country, count(suppliers.Country) as number_of_products
FROM
    orders
        JOIN
    orderdetails ON orders.OrderID = orderdetails.OrderID
        JOIN
    products ON products.ProductID = orderdetails.ProductID
        JOIN
    suppliers ON suppliers.SupplierID = products.SupplierID
    where year(OrderDate)=1997 group by suppliers.Country)
    select Country from country_products where number_of_products=(select max(number_of_products) from country_products);
    
/* 30 */
SELECT 
    AVG(TIMESTAMPDIFF(DAY,
        OrderDate,
        ShippedDate)) AS avg_days_to_delever
FROM
    orders;
    
/* 31 */
with shipper_time as (
SELECT 
	shippers.CompanyName,
    TIMESTAMPDIFF(DAY,
        OrderDate,
        ShippedDate) as days_to_deliver
FROM
    orders join shippers on orders.ShipperID=shippers.ShipperID)
select CompanyName as number_of_least_time 
from shipper_time where days_to_deliver=(
select min(days_to_deliver) from shipper_time) 
group by CompanyName order by Count(companyName) 
desc 
limit 1;

/* 32 */
with order_products as (
SELECT
	orders.OrderID,
    concat(employee.FirstName, " ", employee.LastName) as EmployeeName,
    count(orderdetails.OrderID) as number_of_products,
    TIMESTAMPDIFF(DAY,
        OrderDate,
        ShippedDate) as days_to_deliver,
	shippers.CompanyName
FROM
    orders
        JOIN
    employee ON orders.EmployeeID = employee.EmployeeID
        JOIN
    orderdetails ON orderdetails.OrderID = orders.OrderID
        JOIN
    shippers ON shippers.ShipperID = orders.ShipperID
    group by orders.OrderID)
select * from order_products where days_to_deliver=(select min(days_to_deliver) from order_products);

/* UNIONS */
/* 1 */
with order_products as (
SELECT
	orders.OrderID,
    concat(employee.FirstName, " ", employee.LastName) as EmployeeName,
    count(orderdetails.OrderID) as number_of_products,
    TIMESTAMPDIFF(DAY,
        OrderDate,
        ShippedDate) as days_to_deliver,
	shippers.CompanyName
FROM
    orders
        JOIN
    employee ON orders.EmployeeID = employee.EmployeeID
        JOIN
    orderdetails ON orderdetails.OrderID = orders.OrderID
        JOIN
    shippers ON shippers.ShipperID = orders.ShipperID
    group by orders.OrderID)
select * from order_products where days_to_deliver=(select min(days_to_deliver) from order_products)
UNION
select * from order_products where days_to_deliver=(select max(days_to_deliver) from order_products);

/* 2 */
with product_prices as (
SELECT DISTINCT
    orderdetails.ProductID,
    products.ProductName,
    products.UnitPrice
FROM
    orders
        JOIN
    orderdetails ON orders.OrderID = orderdetails.OrderID
        JOIN
    products ON orderdetails.ProductID = products.ProductID
WHERE
    orders.OrderDate BETWEEN '1997-10-8' AND '1997-10-14')
select 1 as id, ProductID, ProductName, UnitPrice from product_prices where UnitPrice=(select min(UnitPrice) from product_prices)
UNION
select 2 as id, ProductID, ProductName, UnitPrice from product_prices where UnitPrice=(select max(UnitPrice) from product_prices);

/* CASE */
/* 1 */
SELECT DISTINCT
    ShipperID,
    CASE
        WHEN ShipperID = 1 THEN 'Shipping Federal'
        WHEN ShipperID = 2 THEN 'Express Speedy'
        ELSE 'United Package'
    END AS shipper_name
FROM
    orders
WHERE
    EmployeeID IN (1 , 3, 5, 7);