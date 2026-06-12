# ScienceQtech Employee Performance Mapping

## Overview

This project analyzes employee and project data for ScienceQtech, a startup specializing in Data Science solutions. Using SQL, various reports and insights were generated to support employee performance evaluation and project management.

## Database Tables

* **emp_record_table** – Stores employee information and performance ratings.
* **proj_table** – Stores project details.
* **data_science_team** – Contains employees belonging to the Data Science team.

## Entity Relationships

* **emp_record_table.PROJ_ID → proj_table.PROJECT_ID**

  * Many-to-One relationship
  * Multiple employees can be assigned to the same project.

* **emp_record_table.EMP_ID → data_science_team.EMP_ID**

  * One-to-One Identifying relationship
  * An employee may have zero or one corresponding record in the Data Science team table.

## SQL Concepts Implemented

* Joins
* Aggregate Functions
* GROUP BY and HAVING
* Subqueries
* Window Functions
* Views
* Stored Procedures
* User Defined Functions
* CASE Statements
* Indexing and Query Optimization using `EXPLAIN`

## Tools Used

* MySQL
* MySQL Workbench

## Outcome

This project demonstrates the use of SQL for database design, data analysis, and query optimization. It also provides practical experience with relationships, views, stored procedures, functions, and indexing techniques.
