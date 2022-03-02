/* 1 */
SELECT 
    *
FROM
    employee;

/* 2 */
SELECT 
    first_name, age, salary
FROM
    employee;

/* 3 */
SELECT 
    first_name AS Name
FROM
    employee;

/* 4 */
SELECT 
    CONCAT(first_name, ' ', last_name) AS Name
FROM
    employee;

/* 5 */
SELECT 
    *
FROM
    employee
WHERE
    salary > 38000;

/* 6 */
SELECT 
    first_name, last_name
FROM
    employee
WHERE
    age < 24;

/* 7 */
SELECT 
    first_name, last_name, salary
FROM
    employee
WHERE
    title = 'Programmer';

/* 8 */
SELECT 
    *
FROM
    employee
WHERE
    last_name LIKE '%o%';

/* 9 */
SELECT 
    last_name
FROM
    employee
WHERE
    first_name = 'Kelly';

/* 10 */
SELECT 
    *
FROM
    employee
WHERE
    last_name LIKE '%Moore';

/* 11 */
SELECT 
    *
FROM
    employee
WHERE
    age >= 35;

/* 12 */
SELECT 
    first_name, last_name, age, salary
FROM
    employee
WHERE
    age > 24 AND age < 43;

/* 13 */
SELECT 
    first_name, title, last_name
FROM
    employee
WHERE
    age BETWEEN 28 AND 62 AND salary > 31250;

/* 14 */
SELECT 
    *
FROM
    employee
WHERE
    age <= 48 AND salary >= 21520;

/* 15 */
SELECT 
    first_name, age
FROM
    employee
WHERE
    first_name LIKE 'John%'
        AND salary BETWEEN 25000 AND 35000;

/* 16 */
SELECT 
    *
FROM
    employee
ORDER BY age DESC;

/* 17 */
SELECT 
    *
FROM
    employee
ORDER BY age ASC;

/* 18 */
SELECT 
    *
FROM
    employee
ORDER BY salary DESC;

/* 19 */
SELECT 
    *
FROM
    employee
ORDER BY salary ASC;

/* 20 */
SELECT 
    *
FROM
    employee
WHERE
    age >= 17
ORDER BY salary ASC;

/* 21 */
SELECT 
    *
FROM
    employee
WHERE
    age <= 34
ORDER BY salary DESC;

/* 22 */
SELECT 
    *
FROM
    employee
ORDER BY LENGTH(first_name) ASC;

/* 23 */
SELECT 
    COUNT(*)
FROM
    employee
WHERE
    age > 45;

/* 24 */
DELIMITER $$
create function add_five (num int)		/* Creating a function for adding five */
returns int
deterministic
begin
declare result int;
set result = num + 5;
return result;
end $$
DELIMITER ;

DELIMITER $$
create function subtract_250 (num int)		/* Creating a function for subtracting 250 */
returns int
deterministic
begin
declare result int;
set result = num + 5;
return result;
end $$
DELIMITER ;

SELECT 
    first_name,
    last_name,
    title,
    ADD_FIVE(age) AS age,
    SUBTRACT_250(salary) AS salary
FROM
    employee;

/* 25 */
SELECT 
    COUNT(*)
FROM
    employee
WHERE
    last_name LIKE '%re'
        OR last_name LIKE '%ri'
        OR last_name LIKE '%ks';

/* 26 */
SELECT 
    AVG(salary)
FROM
    employee;

/* 27 */
SELECT 
    AVG(salary)
FROM
    employee
WHERE
    title = 'Fresher';

/* 28 */
SELECT 
    AVG(salary)
FROM
    employee
WHERE
    title = 'Programmer';

/* 29 */
SELECT 
    AVG(salary)
FROM
    employee
WHERE
    age BETWEEN 35 AND 50;

/* 30 */
SELECT 
    COUNT(*)
FROM
    employee
WHERE
    title = 'Fresher';

/* 31 */
DELIMITER $$
create function percentage_of_employees(num_of_emp int)		/* Creating a function to find percentage of employees */
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

SELECT 
    PERCENTAGE_OF_EMPLOYEES(COUNT(*)) AS percentage_of_employees
FROM
    employee
WHERE
    title = 'Programmer';

/* 32 */
SELECT 
    SUM(salary)
FROM
    employee
WHERE
    age >= 40;

/* 33 */
SELECT 
    SUM(salary)
FROM
    employee
WHERE
    title = 'Fresher'
        OR title = 'Programmer';

/* 34 */
DELIMITER $$
create function mul_36(num int)		/* Function to multiply number by 36 (3 years) */
returns int
deterministic
begin
declare result int;
set result = num * 36;
return result;
end $$
DELIMITER ;

SELECT 
    MUL_36(SUM(salary))
FROM
    employee
WHERE
    age > 27 AND title = 'Fresher';

/* 35 */
SELECT 
    first_name, last_name, age
FROM
    employee
WHERE
    age = (SELECT 
            MAX(age)
        FROM
            employee
        WHERE
            salary < 35000);

/* 36 */
SELECT 
    CONCAT(first_name, ' ', last_name) AS name
FROM
    employee
WHERE
    age = (SELECT 
            MIN(age)
        FROM
            employee
        WHERE
            title = 'General Manager')
        AND title = 'General Manager';

/* 37 */
SELECT 
    CONCAT(first_name, ' ', last_name) AS name
FROM
    employee
WHERE
    age = (SELECT 
            MIN(age)
        FROM
            employee
        WHERE
            title = 'Fresher' AND salary < 35000)
        AND title = 'Fresher'
        AND salary < 35000;

/* 38 */
SELECT 
    first_name, age
FROM
    employee
WHERE
    first_name IN ('John' , 'Michael')
        AND salary BETWEEN 17000 AND 26000;

/* 39 */
with employee_title as (select title, count(title) as no_of_employees from employee group by title)
select * from employee_title order by no_of_employees asc;

/* 40 */
SELECT 
    title, AVG(salary) AS average_salary
FROM
    employee
GROUP BY title;

/* 41 */
SELECT 
    AVG(salary)
FROM
    employee
WHERE
    title != 'Fresher';

/* 42 */
SELECT 
    title, AVG(age) AS average_age
FROM
    employee
GROUP BY title;

/* 43 */
with emp_25_40 as (select * from employee where age between 25 and 40) 
select title, count(title) as no_of_employees from emp_25_40 group by title;

/* 44 */
SELECT 
    title, AVG(salary) AS average_salary
FROM
    employee
GROUP BY title
HAVING average_salary >= 25000;

/* 45 */
SELECT 
    title, SUM(age) AS sum_age
FROM
    employee
GROUP BY title
HAVING sum_age > 30;

/* 46 */
UPDATE employee 
SET 
    last_name = 'Moore'
WHERE
    first_name = 'Lisa'
        AND last_name = 'Moore';

/* 47 */
UPDATE employee 
SET 
    age = age + 1,
    salary = salary + 5000
WHERE
    first_name = 'Ginger'
        AND last_name = 'Finger';

/* 48 */
UPDATE employee 
SET 
    title = 'Engineer'
WHERE
    title = 'Programmer';

/* 49 */
UPDATE employee 
SET 
    salary = salary + 3500
WHERE
    salary < 30000;

/* 50 */
UPDATE employee 
SET 
    salary = salary - (salary * 0.15)
WHERE
    salary > 35500;
