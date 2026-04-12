select *
from `d-dimer_synthetic(csv) - copy` AS d_dimer_syn
limit 10
;

/* Objectives:
1. Find lab influx overview: (i) Total lab test, (ii) test over time, (iii) highest amount of lab test
2. Obsererve Patients demographics: (i) gender distribution, (ii) age ditribution, (iii) count of patients by gender in each age group
3. Clinical Observation: (i) min/max/mean(average) d-dimer result, (ii) number of patient with >0.5 mg/L and <0.5 mg/L respectively
4. Additional clinical observation: Due to age adjusted cut-off effective sysytem of testing d-dimer. Observing aged 20-50 years old, and >50 years old
-- (4. maybe can be done using Excel) --
5. Result text observation: observe text result associated with PE or DVT
*/

-- 1. Find lab influx overview: (i) Total lab test, (ii) test over time, (iii) highest amount of lab test

-- total lab samples --
select count(Lab_number) as patient_count
from `d-dimer_synthetic(csv) - copy`
;
	
-- test over time (daily)-- 
select str_to_date(`Date of specimen`, '%d/%m/%Y') as daily_count,
COUNT(Lab_number) as patient_num
from `d-dimer_synthetic(csv) - copy`
group by daily_count
order by daily_count asc #change order by patient_num asc/desc, if you want to observe the number of patients influx each day
; 

-- highest amount of lab test in 2024 --
select `Date of specimen` as date_num,
count(lab_number) as patient_num
from `d-dimer_synthetic(csv) - copy`
where date (str_to_date(`Date of specimen`, '%d/%m/%Y')) = 2024
group by date_num
order by patient_num desc
;

-- 2. Obsererve Patients demographics: (i) gender distribution, (ii) age ditribution, (iii) count of patients by gender in each age group --

-- gender distribution --
select gender,
count(*) as gender_count
from `d-dimer_synthetic(csv) - copy`
group by gender
;

-- age distribution --
select age,
	count(*) as age_distribution
    from `d-dimer_synthetic(csv) - copy`
    group by age
    order by age desc
; -- min = 9 years old; max= 97 years old --

select avg(age) as ave_age
    from `d-dimer_synthetic(csv) - copy`
   ; -- average age = 51.6822 -- 
   
   
SELECT age_group,
	count(*)
	FROM
    (
        select	age
			,CASE
				WHEN Age between 0 and 10 then '0-10'
                WHEN Age between 11 and 20 then '11-20'
                WHEN Age between 21 and 10 then '21-30'
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
    ORDER BY age_group ASC
    ;
    
    -- 3. Clinical Observation: (i) min/max/mean(average) d-dimer result, (ii) number of patient with >0.5 mg/L and <0.5 mg/L respectively--
    -- this query allows to find the patients with highest/lowest d-dimer and their age--
    select name,
    age,
    (Numeric_result) as Ddimer
    from `d-dimer_synthetic(csv) - copy`
    order by Ddimer desc; # highest D-dimer 'Sarah Dunne' = 1.35 at 97 years old
    