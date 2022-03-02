-- 1
-- Select firstname, lastname, title, age, salary for everyone in your employee table.
select 
    first_name, last_name, title, age, salary
from
    employee;

-- 2
-- Select firstname, age and salary for everyone in your employee table.
select 
    first_name, age, salary
from
    employee;

-- 3
-- Selct firstname and display as 'Name' for everyone in your employee table
select 
    first_name as Name
from
    employee;

-- 4
-- Select firstname and lastname as 'Name' for everyone. Use " " (space) to separate firstname and last.
select 
    concat_ws(' ', first_name, last_name) as Name
from
    employee;

-- 5
-- Select all columns for everyone with a salary over 38000.
select 
    *
from
    employee
where
    salary > 38000;

-- 6
-- Select first and last names for everyone that's under 24 years old.
select 
    first_name, last_name
from
    employee
where
    age < 24;

-- 7
-- Select first name, last name, and salary for anyone with "Programmer" in their title.
select 
    first_name, last_name, salary
from
    employee
where
    title = 'Programmer';

-- 8
-- Select all columns for everyone whose last name contains "O".
select 
    *
from
    employee
where
    last_name like '%o%';

-- 9
-- Select the lastname for everyone whose first name equals "Kelly".
select 
    last_name
from
    employee
where
    first_name = 'Kelly';

-- 10
--  Select all columns for everyone whose last name ends in "Moore".
select 
    *
from
    employee
where
    last_name like '%Moore';

-- 11
-- Select all columns for everyone who are 35 and above.
select 
    *
from
    employee
where
    age >= 35;

-- 12
-- Select firstname ,lastname,age and salary of everyone whose age is above 24 and below 43.
select 
    first_name, last_name, age, salary
from
    employee
where
    age > 24 and age < 43;

-- 13
-- Select firstname, title and lastname whose age is in the range 28 and 62 and salary greater than 31250
select 
    first_name, title, last_name
from
    employee
where
    age between 28 and 62 and salary > 31250;

-- 14
-- Select all columns for everyone whose age is not more than 48 and salary not less than 21520
select 
    *
from
    employee
where
    age <= 48 and salary >= 21520;

-- 15
-- Select firstname and age of everyone whose firstname starts with "John" and salary in the range 25000 and 35000
select 
    first_name, age
from
    employee
where
    first_name like 'John%'
        and salary between 25000 and 35000;

-- 16
-- Select all columns for everyone by their ages in descending order
select 
    *
from
    employee
order by age desc;

-- 17
-- Select all columns for everyone by their ages in ascending order
select 
    *
from
    employee
order by age asc;

-- 18
-- Select all columns for everyone by their salaries in descending order
select 
    *
from
    employee
order by salary desc;

-- 19
--  Select all columns for everyone by their salaries in ascending order.
select 
    *
from
    employee
order by salary asc;

-- 20
-- Select all columns for everyone by their salaries in ascending order whose age not less than 17
select 
    *
from
    employee
where
    age >= 17
order by salary asc;

-- 21
-- Select all columns for everyone by their salaries in descending order whose age not more than 34.
select 
    *
from
    employee
where
    age <= 34
order by salary desc;

-- 22
-- Select all columns for everyone by their length of firstname in ascending order.
select 
    *
from
    employee
order by length(first_name) asc;

-- 23
-- Select the number of employees whose age is above 45
select 
    count(*)
from
    employee
where
    age > 45;

-- 24
-- Show the results by adding 5 to ages and removing 250 from salaries of all employees
select 
    first_name,
    last_name,
    title,
    age + 5 as age,
    salary - 250 as salary
from
    employee;

-- 25
-- Select the number of employees whose lastname ends with "re" or "ri" or "ks"
select 
    count(*)
from
    employee
where
    last_name like '%re'
        or last_name like '%ri'
        or last_name like '%ks';

-- 26
-- Select the average salary of all your employees
select 
    avg(salary)
from
    employee;

-- 27
-- Select the average salary of Freshers
select 
    avg(salary)
from
    employee
where
    title = 'Fresher';

-- 28
-- Select the average age of Programmers
select 
    avg(age)
from
    employee
where
    title = 'Programmer';

-- 29
-- Select the average salary of employees whose age is not less than 35 and not more than 50
select 
    avg(salary)
from
    employee
where
    age between 35 and 50;

-- 30
-- Select the number of Freshers
select 
    count(*)
from
    employee
where
    title = 'Fresher';

-- 31
-- What percentage of programmers constitute your employees
select 
    count(*) * 100 / (select count(*) from employee) as percentage_of_programmers
from
    employee
where
    title = 'Engineer';

-- 32
-- What is the combined salary that you need to pay to the employees whose age is not less than 40
select 
    sum(salary)
from
    employee
where
    age >= 40;

-- 33
-- What is the combined salary that you need to pay to all the Freshers and Programmers for 1 month
select 
    sum(salary)
from
    employee
where
    title = 'Fresher'
        or title = 'Programmer';

-- 34
-- What is the combined salary that you need to pay to all the Freshers whose age is greater than 27 for 3years
select 
    sum(salary) * 36 as total_salary_3years
from
    employee
where
    age > 27 and title = 'Fresher';

-- 35
-- Select the eldest employee's firstname, lastname and age whose salary is less than 35000
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
-- Who is the youngest General Manager
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
-- Select the eldest fresher whose salary is less than 35000
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
-- Select firstname and age of everyone whose firstname starts with "John" or "Michael" and salary in the range 17000 and 26000
select 
    first_name, age
from
    employee
where
    first_name in ('John' , 'Michael')
        and salary between 17000 and 26000;

-- 39
-- How many employees are having each unique title. Select the title and display the number of employees present in ascending order
with employee_title as (select title, count(title) as no_of_employees from employee group by title)
select * from employee_title order by no_of_employees asc;

-- 40
-- What is the average salary of each unique title of the employees. Select the title and display the average salary of employees in each
select 
    title, avg(salary) as average_salary
from
    employee
group by title;

-- 41
-- What is the average salary of employees excluding Freshers
select 
    avg(salary)
from
    employee
where
    title != 'Fresher';

-- 42
-- What is the average age of employees of each unique title.
select 
    title, avg(age) as average_age
from
    employee
group by title;

-- 43
-- In the age range of 25 to 40 get the number of employees under each unique title.
with emp_25_40 as (select * from employee where age between 25 and 40) 
select title, count(title) as no_of_employees from emp_25_40 group by title;

-- 44
-- Show the average salary of each unique title of employees only if the average salary is not less than 25000
select 
    title, avg(salary) as average_salary
from
    employee
group by title
having average_salary >= 25000;

-- 45
-- Show the sum of ages of each unique title of employee only if the sum of age is greater than 30
select 
    title, sum(age) as sum_age
from
    employee
group by title
having sum_age > 30;

-- 46
-- Lisa Ray just got married to Michael Moore. She has requested that her last name be updated to Moore.
update employee 
set 
    last_name = 'Moore'
where
    first_name = 'Lisa'
        and last_name = 'Moore';

-- 47
-- Ginger Finger's birthday is today, add 1 to his age and a bonus of 5000
update employee 
set 
    age = age + 1,
    salary = salary + 5000
where
    first_name = 'Ginger'
        and last_name = 'Finger';

-- 48
-- All 'Programmer's are now called "Engineer"s. Update all titles accordingly
update employee 
set 
    title = 'Engineer'
where
    title = 'Programmer';

-- 49
-- Everyone whose making under 30000 are to receive a 3500 bonus.
update employee 
set 
    salary = salary + 3500
where
    salary < 30000;

-- 50
-- Everyone whose making over 35500 are to be deducted 15% of their salaries
update employee 
set 
    salary = salary - (salary * 0.15)
where
    salary > 35500;
