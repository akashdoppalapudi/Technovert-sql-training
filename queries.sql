/* 1 */
select * from employee;

/* 2 */
select first_name, age, salary from employee;

/* 3 */
select first_name as Name from employee;

/* 4 */
select concat(first_name, " ", last_name) as Name from employee;

/* 5 */
select * from employee where salary>38000;

/* 6 */
select first_name, last_name from employee where age<24;

/* 7 */
select first_name, last_name, salary from employee where title="Programmer";

/* 8 */
select * from employee where last_name like "%o%";

/* 9 */
select last_name from employee where first_name="Kelly";

/* 10 */
select * from employee where last_name like "%Moore";

/* 11 */
select * from employee where age>=35;

/* 12 */
select first_name, last_name, age, salary from employee
where age>24 and age<43;

/* 13 */
select first_name, title, last_name from employee
where age between 28 and 62 and salary>31250;

/* 14 */
select * from employee
where age<=48 and salary>=21520;

/* 15 */
select first_name, age from employee
where first_name like "John%" and salary between 25000 and 35000;

/* 16 */
select * from employee order by age desc;

/* 17 */
select * from employee order by age asc;

/* 18 */
select * from employee order by salary desc;

/* 19 */
select * from employee order by salary asc;

/* 20 */
select * from employee where age>=17 order by salary asc;

/* 21 */
select * from employee where age<=34 order by salary desc;

/* 22 */
select * from employee order by length(first_name) asc;

/* 23 */
select count(*) from employee where age>45;

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

select first_name, last_name, title, add_five(age) as age, subtract_250(salary) as salary
from employee;

/* 25 */
select count(*) from employee where last_name like "%re" or last_name like "%ri" or last_name like "%ks";

/* 26 */
select avg(salary) from employee;

/* 27 */
select avg(salary) from employee where title="Fresher";

/* 28 */
select avg(salary) from employee where title="Programmer";

/* 29 */
select avg(salary) from employee where age between 35 and 50;

/* 30 */
select count(*) from employee where title="Fresher";