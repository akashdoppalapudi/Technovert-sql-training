# SQL Task

This task gives an sql table with some data in it and we have to write queries based on questions asked.

## Data

**MySQL is used to write queries**

Data and schema is given in `employee_db.sql`

The database can be created by running below command

```PowerShell
mysql -u root -p "name of the database" < "path to the schema sql"
```

## Queries

### Basic 'Select' exercises

1. Select firstname, lastname, title, age, salary for everyone in your employee table.
2. Select firstname, age and salary for everyone in your employee table.
3. Selct firstname and display as 'Name' for everyone in your employee table
4. Select firstname and lastname as 'Name' for everyone. Use " " (space) to separate firstname and last.

### Using 'where' clause

5. Select all columns for everyone with a salary over 38000.
6. Select first and last names for everyone that's under 24 years old.
7. Select first name, last name, and salary for anyone with "Programmer" in their title.
8. Select all columns for everyone whose last name contains "O".
9. Select the lastname for everyone whose first name equals "Kelly".
10. Select all columns for everyone whose last name ends in "Moore".
11. Select all columns for everyone who are 35 and above.

### Using multiple 'where' clauses

12. Select firstname ,lastname,age and salary of everyone whose age is above 24 and below 43.
13. Select firstname, title and lastname whose age is in the range 28 and 62 and salary greater than 31250
14. Select all columns for everyone whose age is not more than 48 and salary not less than 21520
15. Select firstname and age of everyone whose firstname starts with "John" and salary in the range 25000 and 35000

### Using 'Order By' clause

16. Select all columns for everyone by their ages in descending order.
17. Select all columns for everyone by their ages in ascending order.
18. Select all columns for everyone by their salaries in descending order.
19. Select all columns for everyone by their salaries in ascending order.
20. Select all columns for everyone by their salaries in ascending order whose age not less than 17.
21. Select all columns for everyone by their salaries in descending order whose age not more than 34.

### Miscellaneous( count, sum(), max(), min())

22. Select all columns for everyone by their length of firstname in ascending order.
23. Select the number of employees whose age is above 45
24. Show the results by adding 5 to ages and removing 250 from salaries of all employees
25. Select the number of employees whose lastname ends with "re" or "ri" or "ks"
26. Select the average salary of all your employees
27. Select the average salary of Freshers
28. Select the average age of Programmers
29. Select the average salary of employees whose age is not less than 35 and not more than 50
30. Select the number of Freshers
31. What percentage of programmers constitute your employees
32. What is the combined salary that you need to pay to the employees whose age is not less than 40
33. What is the combined salary that you need to pay to all the Freshers and Programmers for 1 month
34. What is the combined salary that you need to pay to all the Freshers whose age is greater than 27 for 3years

### Using Sub-Queries ( and usage of 'in' and 'between')

35. Select the eldest employee's firstname, lastname and age whose salary is less than 35000
36. Who is the youngest General Manager
37. Select the eldest fresher whose salary is less than 35000
38. Select firstname and age of everyone whose firstname starts with "John" or "Michael" and salary in the range 17000 and 26000

### Using 'Group By' and 'Having' clause

39. How many employees are having each unique title. Select the title and display the number of employees present in ascending order
40. What is the average salary of each unique title of the employees. Select the title and display the average salary of employees in each
41. What is the average salary of employees excluding Freshers
42. What is the average age of employees of each unique title.
43. In the age range of 25 to 40 get the number of employees under each unique title.
44. Show the average salary of each unique title of employees only if the average salary is not less than 25000
45. Show the sum of ages of each unique title of employee only if the sum of age is greater than 30

### Basic Data Modification Using 'Update'

46. Lisa Ray just got married to Michael Moore. She has requested that her last name be updated to Moore.
47. Ginger Finger's birthday is today, add 1 to his age and a bonus of 5000
48. All 'Programmer's are now called "Engineer"s. Update all titles accordingly.
49. Everyone whose making under 30000 are to receive a 3500 bonus.
50. Everyone whose making over 35500 are to be deducted 15% of their salaries
