select * from bank_loan_data


--Total Loan Appllications

select count(id) as Total_Loan_Applications from bank_loan_data

select count(id) as MTD_Total_Loan_Applications from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select count(id) as PMTD_Total_Loan_Applications from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021


--Total Funded Amount

select sum(loan_amount) as Total_Funded_Amount from bank_loan_data

select sum(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select sum(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021


--Total Amount Recieved

select sum(total_payment) as Total_Amount_Recieved from bank_loan_data

select sum(total_payment) as MTD_Total_Amount_Recieved from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select sum(total_payment) as PMTD_Total_Amount_Recieved from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021


--Average Interest Rate

select round(avg(int_rate), 4) * 100 as Avg_Interest_Rate from bank_loan_data

select round(avg(int_rate), 4) * 100 as MTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select round(avg(int_rate), 4) * 100 as PMTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021


--Average DTI

select round(avg(dti), 4) * 100 as Avg_DTI from bank_loan_data

select round(avg(dti), 4) * 100 as MTD_Avg_DTI from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select round(avg(dti), 4) * 100 as PMDT_Avg_DTI from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021


--Good Loan Amount

select 
	(count(case when loan_status in ('Fully Paid', 'Current') then id end) * 100)
	/
	count(id) as Good_loan_percentage
from bank_loan_data

select count(id) as Good_Loan_Applications from bank_loan_data 
where loan_status in ('Fully Paid', 'Current')

select sum(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data 
where loan_status in ('Fully Paid', 'Current')

select sum(total_payment) as Good_Loan_Recieved_Amount from bank_loan_data 
where loan_status in ('Fully Paid', 'Current')


--Bad Loan Amount

SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) 
	/ 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off'


--Loan Status

SELECT
    loan_status,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM
    bank_loan_data
GROUP BY
    loan_status


SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


--Bank Loan Report

--Month
SELECT 
	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--State
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

--Term
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

--Employee Length
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--Purpose
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

--Home Ownership
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership
