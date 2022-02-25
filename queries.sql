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