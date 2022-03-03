-- JOINS
-- 1
select 
    employee.FirstName, employee.LastName
from
    employee
        join
    orders on employee.EmployeeID = orders.EmployeeID
where
    OrderDate between '1996-08-15' and '1997-08-15'
group by orders.EmployeeID;

-- 2
select distinct
    (employee.EmployeeID)
from
    employee
        join
    orders on employee.EmployeeID = orders.EmployeeID
where
    orders.OrderDate < '1996-08-16';
    
-- 3
select 
    count(*)
from
    orders
where
    OrderDate between '1997-01-13' and '1997-04-16';

-- 4
select 
    count(*)
from
    orders
        left join
    employee on employee.EmployeeID = orders.EmployeeID
where
    OrderDate between '1997-01-13' and '1997-04-16'
        and employee.FirstName = 'Anne'
        and employee.LastName = 'Dodsworth';
                
-- 5
select 
    count(*)
from
    orders
        left join
    employee on employee.EmployeeID = orders.EmployeeID
where
    employee.FirstName = 'Robert'
        and employee.LastName = 'King';
        
-- 6
select 
    count(*)
from
    orders
        left join
    employee on employee.EmployeeID = orders.EmployeeID
where
    employee.FirstName = 'Robert'
        and employee.LastName = 'King'
        and orders.OrderDate between '1996-08-15' and '1997-08-15';
        
-- 7
select 
    distinct(employee.EmployeeID),
    concat(employee.FirstName,
            ' ',
            employee.LastName) as EmployeeFullName,
    employee.HomePhone
from
    orders
        left join
    employee on employee.EmployeeID = orders.EmployeeID
where
    orders.OrderDate between '1997-01-13' and '1997-04-16';
    
-- 8
with product_orders as (
select 
    orderdetails.ProductID, products.ProductName, count(orderdetails.ProductID) as number_of_orders
from
    orderdetails
        left join
    products on orderdetails.ProductID = products.ProductID group by orderdetails.ProductID) 
select * from product_orders 
where number_of_orders=(select max(number_of_orders) from product_orders);

-- 9
select 
    orderdetails.ProductID,
    products.ProductName,
    count(orderdetails.ProductID) as number_of_orders
from
    orderdetails
        left join
    products on orderdetails.ProductID = products.ProductID
group by orderdetails.ProductID
order by number_of_orders
limit 5;

-- 10
DELIMITER $$
create function total_price(quantity int, unit_price decimal)		-- Function to find total price for all products
returns decimal
deterministic
begin
declare total_price decimal;
set total_price = quantity * unit_price;
return total_price;
end $$
DELIMITER ;

select 
    sum(total_price(orderdetails.Quantity, orderdetails.UnitPrice)) as total_price
from
    orderdetails
        join
    orders on orders.OrderID = orderdetails.OrderID
where
    orders.EmployeeID = (select 
            EmployeeID
        from
            employee
        where
            FirstName = 'Laura'
                and LastName = 'Callahan')
	and orders.OrderDate="1997-01-13";
    
-- 11
select 
    count(distinct orders.EmployeeID) as number_of_employees
from
    orders
        left join
    orderdetails on orderdetails.OrderID = orders.OrderID
        inner join
    products on products.ProductID = orderdetails.ProductID
where
    products.ProductName in ('Gorgonzola Telino' , 'Gnocchi di nonna Alice',
        'Raclette Courdavault',
        'Camembert Pierrot')
        and orders.OrderDate between '1997-01-01' and '1997-01-31';
        
-- 12
select distinct
    concat(employee.FirstName,
            ' ',
            employee.LastName) as employee_name
from
    orders
        join
    employee on orders.EmployeeID = employee.EmployeeID
        join
    orderdetails on orderdetails.OrderID = orders.OrderID
where
    orderdetails.ProductID = (select 
            ProductID
        from
            products
        where
            ProductName = 'Tofu')
        and orders.OrderDate between '1997-01-13' and '1997-01-30';
            
-- 13
select distinct
    (employee.EmployeeID),
    concat(employee.FirstName,
            ' ',
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
    employee on employee.EmployeeID = orders.EmployeeID
where
    month(orders.OrderDate) = 08;
    
-- 14
select 
    shippers.CompanyName,
    count(shippers.ShipperID) as number_of_orders
from
    orders
        join
    shippers on shippers.ShipperID = orders.ShipperID
group by shippers.ShipperID;

-- 15
select 
    shippers.CompanyName,
    sum(orderdetails.Quantity) as number_of_products
from
    orders
        join
    shippers on orders.ShipperID = shippers.ShipperID
        join
    orderdetails on orderdetails.OrderID = orders.OrderID
group by shippers.ShipperID;

-- 16
select 
    shippers.ShipperID,
    count(shippers.ShipperID) as number_of_orders
from
    orders
        join
    shippers on shippers.ShipperID = orders.ShipperID
group by shippers.ShipperID
order by number_of_orders desc
limit 1;

-- 17
select 
    shippers.ShipperID,
    shippers.CompanyName,
    count(shippers.ShipperID) as number_of_orders
from
    orders
        join
    shippers on shippers.ShipperID = orders.ShipperID
    where orders.OrderDate between "1996-08-10" and "1998-09-20"
group by shippers.ShipperID 
order by number_of_orders desc limit 1;

-- 18
select 
    EmployeeID,
    concat(FirstName, ' ', LastName) as employee_name
from
    employee
where
    EmployeeID not in (select 
            EmployeeID
        from
            orders
        where
            OrderDate = '1997-04-04');

-- 19
select 
    sum(orderdetails.Quantity) as number_of_products
from
    orders join orderdetails on orders.OrderID=orderdetails.OrderID
where
    orders.EmployeeID = (select 
            EmployeeID
        from
            employee
        where
            FirstName = 'Steven'
                and LastName = 'Buchanan');
                
-- 20
select 
    count(*) as number_of_orders
from
    orders
        join
    employee on employee.EmployeeID = orders.EmployeeID
        join
    shippers on shippers.ShipperID = orders.ShipperID
where
    employee.FirstName = 'Michael'
        and employee.LastName = 'Suyama'
        and shippers.CompanyName = 'Federal Shipping';
        
-- 21
select 
    count(distinct OrderID) as number_of_orders
from
    orderdetails
        join
    products on orderdetails.ProductID = products.ProductID
        join
    suppliers on suppliers.SupplierID = products.SupplierID
where
    (suppliers.Country = 'UK'
        or suppliers.Country = 'Germany');
        
-- 22
select 
    sum(total_price(orderdetails.Quantity,
            orderdetails.UnitPrice)) as total_amount
from
    orderdetails
        join
    products on orderdetails.ProductID = products.ProductID
        join
    orders on orders.OrderID = orderdetails.OrderID
where
    products.SupplierID = (select 
            SupplierID
        from
            suppliers
        where
            CompanyName = 'Exotic Liquids')
        and orders.OrderDate between '1997-01-01' and '1997-01-31';
        
-- 23
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
    orders.OrderDate between '1997-01-01' and '1997-01-31'
    and products.SupplierID=(select SupplierID from suppliers where CompanyName="Tokyo Traders"));
    
-- 24
select 
    concat(FirstName, ' ', LastName) as EmployeeName
from
    employee
where
    EmployeeID not in (select distinct
            EmployeeID
        from
            orders
                join
            orderdetails on orders.OrderID = orderdetails.OrderID
                join
            products on products.ProductID = orderdetails.ProductID
        where
            month(orders.OrderDate) = 05
                and products.SupplierID = (select 
                    SupplierID
                from
                    suppliers
                where
                    CompanyName = 'Ma Maison'));
                    
-- 25
select 
    shippers.ShipperID,
    shippers.CompanyName,
    count(orders.ShipperID) as number_of_orders
from
    orders
        join
    shippers on shippers.ShipperID = orders.ShipperID
where
    orders.OrderDate between '1997-09-01' and '1997-10-31'
group by shippers.ShipperID
order by number_of_orders asc
limit 1;

-- 26
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
            orderdetails on orders.OrderID = orderdetails.OrderID
                join
            products on products.ProductID = orderdetails.ProductID
        where
            orders.OrderDate between '1997-08-01' and '1997-08-31');
            
-- 27

-- 28
select 
    shippers.CompanyName,
    count(orders.ShipperID) as number_of_orders
from
    orders
        join
    shippers on orders.ShipperID = shippers.ShipperID
where
    (orders.OrderDate between '1996-04-01' and '1996-04-30')
        or (orders.OrderDate between '1996-05-01' and '1996-05-31')
        or (orders.OrderDate between '1996-06-01' and '1996-06-30')
        or (orders.OrderDate between '1997-04-01' and '1997-04-30')
        or (orders.OrderDate between '1997-05-01' and '1997-05-31')
        or (orders.OrderDate between '1997-06-01' and '1997-06-30')
group by shippers.ShipperID
order by number_of_orders desc
limit 1;

-- 29
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
select 
    avg(timestampdiff(day,
        OrderDate,
        ShippedDate)) as avg_days_to_delever
from
    orders;
    
-- 31
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
with order_products as (
select
	orders.OrderID,
    concat(employee.FirstName, " ", employee.LastName) as EmployeeName,
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
with order_products as (
select
	orders.OrderID,
    concat(employee.FirstName, " ", employee.LastName) as EmployeeName,
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
    orders.OrderDate between '1997-10-8' and '1997-10-14')
select 1 as id, ProductID, ProductName, UnitPrice from product_prices where UnitPrice=(select min(UnitPrice) from product_prices)
union
select 2 as id, ProductID, ProductName, UnitPrice from product_prices where UnitPrice=(select max(UnitPrice) from product_prices);

-- CASE
-- 1
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