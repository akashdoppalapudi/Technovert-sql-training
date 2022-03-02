-- 1
select 
    *
from
    employee;

-- 2
select 
    first_name, age, salary
from
    employee;

-- 3
select 
    first_name as Name
from
    employee;

-- 4
select 
    concat(first_name, ' ', last_name) as Name
from
    employee;

-- 5
select 
    *
from
    employee
where
    salary > 38000;

-- 6
select 
    first_name, last_name
from
    employee
where
    age < 24;

-- 7
select 
    first_name, last_name, salary
from
    employee
where
    title = 'Programmer';

-- 8
select 
    *
from
    employee
where
    last_name like '%o%';

-- 9
select 
    last_name
from
    employee
where
    first_name = 'Kelly';

-- 10
select 
    *
from
    employee
where
    last_name like '%Moore';

-- 11
select 
    *
from
    employee
where
    age >= 35;

-- 12
select 
    first_name, last_name, age, salary
from
    employee
where
    age > 24 and age < 43;

-- 13
select 
    first_name, title, last_name
from
    employee
where
    age between 28 and 62 and salary > 31250;

-- 14
select 
    *
from
    employee
where
    age <= 48 and salary >= 21520;

-- 15
select 
    first_name, age
from
    employee
where
    first_name like 'John%'
        and salary between 25000 and 35000;

-- 16
select 
    *
from
    employee
order by age desc;

-- 17
select 
    *
from
    employee
order by age asc;

-- 18
select 
    *
from
    employee
order by salary desc;

-- 19
select 
    *
from
    employee
order by salary asc;

-- 20
select 
    *
from
    employee
where
    age >= 17
order by salary asc;

-- 21
select 
    *
from
    employee
where
    age <= 34
order by salary desc;

-- 22
select 
    *
from
    employee
order by length(first_name) asc;

-- 23
select 
    count(*)
from
    employee
where
    age > 45;

-- 24
DELIMITER $$
create function add_five (num int)		-- Creating a function for adding five
returns int
deterministic
begin
declare result int;
set result = num + 5;
return result;
end $$
DELIMITER ;

DELIMITER $$
create function subtract_250 (num int)		-- Creating a function for subtracting 250
returns int
deterministic
begin
declare result int;
set result = num + 5;
return result;
end $$
DELIMITER ;

select 
    first_name,
    last_name,
    title,
    add_five(age) as age,
    subtract_250(salary) as salary
from
    employee;

-- 25
select 
    count(*)
from
    employee
where
    last_name like '%re'
        or last_name like '%ri'
        or last_name like '%ks';

-- 26
select 
    avg(salary)
from
    employee;

-- 27
select 
    avg(salary)
from
    employee
where
    title = 'Fresher';

-- 28
select 
    avg(salary)
from
    employee
where
    title = 'Programmer';

-- 29
select 
    avg(salary)
from
    employee
where
    age between 35 and 50;

-- 30
select 
    count(*)
from
    employee
where
    title = 'Fresher';

-- 31
DELIMITER $$
create function percentage_of_employees(num_of_emp int)		-- Creating a function to find percentage of employees
returns float
reads sql data
begin
declare percentage float;
declare total int;
select count(*) into total from employee;
set percentage = (num_of_emp / total) * 100;
return percentage;
end $$
DELIMITER ;

select 
    percentage_of_employees(count(*)) as percentage_of_employees
from
    employee
where
    title = 'Programmer';

-- 32
select 
    sum(salary)
from
    employee
where
    age >= 40;

-- 33
select 
    sum(salary)
from
    employee
where
    title = 'Fresher'
        or title = 'Programmer';

-- 34
DELIMITER $$
create function mul_36(num int)		-- Function to multiply number by 36 (3 years)
returns int
deterministic
begin
declare result int;
set result = num * 36;
return result;
end $$
DELIMITER ;

select 
    mul_36(sum(salary))
from
    employee
where
    age > 27 and title = 'Fresher';

-- 35
select 
    first_name, last_name, age
from
    employee
where
    age = (select 
            max(age)
        from
            employee
        where
            salary < 35000);

-- 36
select 
    concat(first_name, ' ', last_name) as name
from
    employee
where
    age = (select 
            min(age)
        from
            employee
        where
            title = 'General Manager')
        and title = 'General Manager';

-- 37
select 
    concat(first_name, ' ', last_name) as name
from
    employee
where
    age = (select 
            min(age)
        from
            employee
        where
            title = 'Fresher' and salary < 35000)
        and title = 'Fresher'
        and salary < 35000;

-- 38
select 
    first_name, age
from
    employee
where
    first_name in ('John' , 'Michael')
        and salary between 17000 and 26000;

-- 39
with employee_title as (select title, count(title) as no_of_employees from employee group by title)
select * from employee_title order by no_of_employees asc;

-- 40
select 
    title, avg(salary) as average_salary
from
    employee
group by title;

-- 41
select 
    avg(salary)
from
    employee
where
    title != 'Fresher';

-- 42
select 
    title, avg(age) as average_age
from
    employee
group by title;

-- 43
with emp_25_40 as (select * from employee where age between 25 and 40) 
select title, count(title) as no_of_employees from emp_25_40 group by title;

-- 44
select 
    title, avg(salary) as average_salary
from
    employee
group by title
having average_salary >= 25000;

-- 45
select 
    title, sum(age) as sum_age
from
    employee
group by title
having sum_age > 30;

-- 46
update employee 
set 
    last_name = 'Moore'
where
    first_name = 'Lisa'
        and last_name = 'Moore';

-- 47
update employee 
set 
    age = age + 1,
    salary = salary + 5000
where
    first_name = 'Ginger'
        and last_name = 'Finger';

-- 48
update employee 
set 
    title = 'Engineer'
where
    title = 'Programmer';

-- 49
update employee 
set 
    salary = salary + 3500
where
    salary < 30000;

-- 50
update employee 
set 
    salary = salary - (salary * 0.15)
where
    salary > 35500;
