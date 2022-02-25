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
where first_name like "John%" and salary>=25000 and salary<=35000;