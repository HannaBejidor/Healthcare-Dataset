SELECT *
FROM `d-dimer_synthetic(csv) - copy` AS d_dimer_syn
LIMIT 10
;

/* Objectives:
1. Find lab influx overview: (i) Total lab test, (ii) test over time, (iii) lab test volume in each year
2. Obsererve Patients demographics: (i) gender distribution, (ii) descriptive analysis (age), (iii) age ditribution (age group)
3. Clinical Observation: (i) descriptive analysis (d-dimer), (ii) top 5 patients (with age) with highest d-didmer, (iii) AVG d-dimer at different age group
4. Additional clinical observation: Due to age adjusted cut-off effective sysytem of testing d-dimer. Observing aged >= 50 years old 

*/

-- 1. Find lab influx overview: (i) Total lab test, (ii) test over time, (iii) highest amount of lab test

-- total number of lab samples (2024-2025)  --
SELECT COUNT(Lab_number) AS patient_count
FROM `d-dimer_synthetic(csv) - copy`
; # n=12264

-- test over time (daily)-- 
select str_to_date(`Date of specimen`, '%d/%m/%Y') as daily_count,
COUNT(Lab_number) as patient_num
from `d-dimer_synthetic(csv) - copy`
group by daily_count
order by daily_count asc 
; #change order by patient_num asc/desc to observe the number of patients influx each day
 
-- total number of patients test sample in 2024 and 2025 respectively--
select count(Lab_number) as patient_num
from `d-dimer_synthetic(csv) - copy`
where year (str_to_date(`Date of specimen`, '%d/%m/%Y')) = 2024 #change year to find number of test in 2024 or 2025
; # Jan-Dec 2024 n=6032 / Jan-Dec 2025 n=6232


-- 2. Obsererve Patients demographics: (i) gender distribution, (ii) descriptive analysis (age), (iii) age ditribution (age group)--

-- number and percentage of patients based on gender --
SELECT gender,
COUNT(gender) AS gender_count,
ROUND(COUNT(gender) * 100.0 / (SELECT COUNT(gender) FROM `d-dimer_synthetic(csv) - copy`), 2) AS percentage
FROM `d-dimer_synthetic(csv) - copy`
GROUP BY gender;
 #Male (53%): Female (46%): Others (1%)


-- descriptive analysis of patients age--
SELECT 
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age,
    AVG(age) AS mean_age
FROM
    `d-dimer_synthetic(csv) - copy`
GROUP BY age;
   
-- age distribution in each age group --
SELECT age_group,
COUNT(age) AS count_patients
	FROM
    (
        select	age
			,CASE
				WHEN Age between 0 and 10 then '0-10'
                WHEN Age between 11 and 20 then '11-20'
                WHEN Age between 21 and 30 then '21-30'
                WHEN Age between 31 and 40 then '31-40'
                WHEN Age between 41 and 50 then '41-50'
                WHEN Age between 51 and 60 then '51-60'
                WHEN Age between 61 and 70 then '61-70'
                WHEN Age between 71 and 80 then '71-80'
			ELSE '80+'
            END AS age_group
		FROM `d-dimer_synthetic(csv) - copy`
             )  AS GROUPED 
	GROUP BY age_group
    ORDER BY age_group ASC #change ORDER BY count_patients and DESC to find the age group with most patients 
    ; # where age group 51-60 with most patient tested for d-dimer
    
-- 3. Clinical Observation: (i) descriptive analysis (d-dimer), (ii) top 5 patients (with age) with highest d-didmer, (iii) AVG d-dimer at different age group

-- MIN/MAX/MEAN of d-dimer test result --
SELECT MIN(Numeric_result) AS min_ddimer,
MAX(Numeric_result) AS max_ddimer,
ROUND(AVG(Numeric_result), 3) AS avg_ddimer
    from `d-dimer_synthetic(csv) - copy`;
    
-- Patients with highest/lowest d-dimer and their age--
   SELECT 
    name,
    age,
    (Numeric_result) AS Ddimer
FROM
    `d-dimer_synthetic(csv) - copy`
ORDER BY Ddimer DESC
LIMIT 5
    ; # highest D-dimer 'Sarah Dunne' = 1.35 at 97 years old
    
-- average d-dimer at different age group in descending order, based on d-dimer result--
SELECT age_group,
Round(Avg(Numeric_result), 3) as ddimer
	FROM
    (
        select	Age,
        Numeric_result
			,CASE
				WHEN Age between 0 and 10 then '0-10'
                WHEN Age between 11 and 20 then '11-20'
                WHEN Age between 21 and 30 then '21-30'
                WHEN Age between 31 and 40 then '31-40'
                WHEN Age between 41 and 50 then '41-50'
                WHEN Age between 51 and 60 then '51-60'
                WHEN Age between 61 and 70 then '61-70'
                WHEN Age between 71 and 80 then '71-80'
			ELSE '80+'
            END AS age_group
		FROM `d-dimer_synthetic(csv) - copy`
             )  AS GROUPED 
	GROUP BY age_group
    ORDER BY ddimer DESC
    ;

-- d-dimer >0.5 / <0.5 at different age group -- CTE may be used/Subqueries (REVISE)
select age,
Numeric_result
from `d-dimer_synthetic(csv) - copy` 
where Numeric_result > 0.5 AND age >= 50 ;
