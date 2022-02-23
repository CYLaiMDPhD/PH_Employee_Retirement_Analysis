# Pewlett-Hackard_Analysis

*Note: This repository was generated to fulfill assignments (Module 7 Exercises and Challenge) for the UC Berkeley Data Analytics and Visualization Bootcamp.
The analysis, content, and format of this report were based on the grading rubric.*

*Module exercises as demonstrated by queries schema.sql, Retirement_Query.sql, and Join_Tailored_Queries.sql include:*
- *Set up and use of a local PostgreSQL database*
- *Understanding and creating ERDs*
- *Importing and exporting tables in PostgreSQL*
- *Basic queries with and without conditions*
- *Use of basic functions such as joins, groupby, order, count*


*The report below is based on analyses from Employee_Database_Challenge.sql and output tables retirement_titles.csv, unique_titles.csv, retiring_titles.csv, mentorship_eligibility.csv. Code for additional visualizations (not required by the grading rubric) are in Pewlett_Hackard_Analysis_Graphs.ipynb.*

## Overview
This report summarizes key information about employees who are eligible for retirement at a fictional company called Pewlett-Hackard and provides analyses and insights for Pewlett-Hackard executives preparing for an anticipated wave of retirements.

**Data Source:**
- Multiple csv files containing employee and department information were provide as part of course materials.


### Background and Purpose
We recently helped our client, Pewlett-Hackard, transition their employee files from excel sheets to a PostgreSQL database. Using the database, we performed several queries to help executives analyze how upcoming retirements would impact the company as a whole and individual departments. Of special concern is the loss of institutional knowledge due to retirement of managers and senior employees. Our client has expressed a need also identify qualified employees for a mentorship training program. This report presents results of queries for employees retiring by title and departments. 


---
## Results
**Major Results**
- The employees database lists 90,398 employees born between 1952 and 1955 (potentially eligible for retirement)
	- Of these, 72,458 are still working at the company and thus eligible for retirement
- The vast majority (> 70%) of retiring staff are either senior engineers or senior staff
- Only 2 managers are eligible for retirement
- 1549 current employees have been identified as preliminary mentees for the mentorship program


### Employees Eligible for Retirement
The employee database currently lists 300,024 employees, 240,124 of whom are presently still working at the company. Our original query for employees born between 1952 and 1955 from the employees database returned 90,398 employees (unique_titles.csv). When filtered for current employees (using the employees table joined with the dept_emp table), the number of employees eligible for retirement is 72,458 employees (current_unique_titles.csv).

Table 1 below lists a breakdown of retirement eligible employees by their most recent titles from our initial query based only on employee birthdays. Table 2 below (generated by counting titles from current_unique_titles.csv) displays a corrected list of only current employees. 

**Table 1: Initial Query of Employees Database for Retirement Eligible Employees**

![retiring_titles.png](/Images/retiring_titles.png)



**Table 2: Corrected Query Showing Current Employees Eligible for Retirment by Job Title**

![current_retiring_titles.png](/Images/current_retiring_titles.png)



Based on table 2, we see that a vast majority of potential retirees will be leaving senior roles (either senior engineer or senior staff). Only 2 managers will be eligible to retire. Figure 1 below shows the percentage of employee titles eligible for retirement.

**Figure 1: Current Employees Eligible for Retirement by Title**
![current_retire_pie.png](/Images/current_retire_pie.png)



### Plan for Employee Mentorship Program
The current basic plan for Pewlett-Hackard's mentorship program involves pairing retiring employees with mentees in the same department. Retirees will be kept on as working half-time while mentoring. A preliminary list of 1,549 potential mentees for this program was identified from the employees database. Current employees born in 1965 were chosen as they would not retire for another 10 years and should be at least mid-level in experience (mentorship_eligibility.csv). 


---
## Summary and Discussion
Nearly one third of Pewlett-Hackard's current 240,124 employees are approaching retirement age (born between 1952 and 1955).  This obviously presents a significant challenge to the company if all eligible employees opt to retire on schedule. Not only will positions need to be filled, skilled institutional knowledge may be lost as managers and senior employees depart. 

All deparmentments are affected similarly across the board and will lose approximately 30% of their staff (Table 3).
**Table 3: Retiring Employees by Deparment**

![Percent_Retire.png](/Images/Percent_Retire.png)

*Table 3 above was created by querying for all current employees (dept_emp joined with departments, filtered for current employees) and querying for current retiring employees (dept_emp joined with employees and departments, filtered for current employment and employees born from 1952-1955) separately. The output tables were then imported into pandas for analysis (see Pewlett-Hackard_Analysis_Graps.ipynb).*


The work for a total of 72,458 positions will need to be replaced and/or passed on to new trainees through the mentorship program. Over two thirds of these positions are either senior engineers or senior staff (see Figure 1 above). We have identified a preliminary list of 1,549 candidate mentees based solely on age (current employees born in 1965). 

Figure 2 below breaks down the preliminary mentees list by job title. The approximate distribution of job titles corresponds well with the distribution of job titles for retiring employees in figure 1 above. However, note that no candidates for mentorship are in management positions.

**Figure 2: Preliminary Mentees by Title**
![mentees_titles_pie.png](/Images/mentees_titles_pie.png)

More crucially, this preliminary list of 1,549 mentees is far less than the number of employees retiring (72,458). This list will need to be expanded by other criteria and potentially include new hires in order to adequately fill upcoming vacant positions. We recommend that each department evaluate titles of retirement eligible employees within their departments and tailor their selection criteria to match the numbers retiring. New managers may be selected from department specific criteria from their current senior staff. To help with this task, tables 4 and 5 below show retiring employees by title and department and the equivalent table for the current mentees list respectively.

**Table 4: Retiring Employees by Job Title and Department**

![current_unique_titles_bydept.png](/Images/current_unique_titles_bydept.png)



**Table 5: Preliminary Mentees by Job Title and Department**

![mentees_titles_dept.png](/Images/mentees_titles_dept.png)

Considering these two tables, all departments will need to expand their mentee selection criteria. The research and customer service departments will need to ensure transfer of knowledge from their assistant engineers, for which there are no current mentee candidates.
