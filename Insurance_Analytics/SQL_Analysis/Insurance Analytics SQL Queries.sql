create database InsuranceAnalytics;
use InsuranceAnalytics;

create table Claims
(
	Claim_ID varchar(20) unique not null,
    Date_Of_Claim date,
    Claim_Amount int,
    Claim_Status varchar(10),
    Reason_For_Claim varchar(100),
    Settlement_Date date,
    Policy_ID varchar(20),
    Claim_Processing_Time int
    
);

select * from claims;

load data infile 'Claims_data.csv' into table claims
fields terminated by ','
ignore 1 lines;

select @@secure_file_priv;

update claims
set Settlement_Date=null 
where settlement_date='2000-01-01';

SET SQL_SAFE_UPDATES = 1;

update claims
set claim_processing_time=null 
where claim_processing_time=0;


create table Additional_Fields
(
	Agent_ID varchar(20) unique not null,
    Renewal_Status varchar(20),
    Policy_Discounts int,
    Risk_Score int,
    Policy_ID varchar(20),
    Risk_Band varchar(20)
    
);

load data infile 'Additional_Fields_data.csv' into table Additional_Fields
fields terminated by ','
ignore 1 lines;

select * from Additional_Fields;

create table Customer_Information
(
	Customer_ID varchar(20) unique not null,
    CUstomer_Name varchar(20),
    Gender varchar(10),
    Age int,
    Occupation varchar(100),
    Marital_Status varchar(20),
    Address varchar(100),
    Age_Group varchar(20),
    State varchar(50)
);

select * from customer_information;
load data infile 'Customer_Information_data.csv' into table Customer_Information
fields terminated by ','
ignore 1 lines;

alter table customer_information rename column `Marital Status` to Marital_status;
desc customer_information;



alter table customer_information rename column `Address (City, State, Zip Code)` to Address;
alter table customer_information rename column `Age Group` to Age_Group;

create table Region
(
	State varchar(50) unique not null,
    Region varchar(20)
   );
   
   load data infile 'Region_data.csv' into table Region
fields terminated by ','
ignore 1 lines;

select * from region;

create table Payment_History
(
	Payment_ID varchar(20) unique not null,
    Date_Of_Payment date,
    Amount_Paid int,
    Payment_Mode varchar(20),
    Payment_Status varchar(20),
    Policy_ID varchar(20),
    Amounnt_Paid_Successfully decimal(10,2)
    
);

select * from Payment_History;

load data infile 'Payment_History_data.csv' into table Payment_History
fields terminated by ','
ignore 1 lines;

create table Date
(
	Policy_Start_date date unique not null,
    Year int,
    Month_Name varchar(20),
    Month_Number int,
    Quater varchar(5),
    Weekday_Name varchar(10),
    Day_Type varchar(10)
    
);

load data infile 'date_data.csv' into table date
fields terminated by ','
ignore 1 lines;

select * from date;

create table Policy_Details
(
	Policy_ID varchar(20) unique not null,
    Policy_Type varchar(20),
    Coverage_amount int,
    Premium_Amount decimal(10,2), 
    Policy_Start_Date date,
    Policy_End_Date date,
    Payment_Frequency varchar(20),
    Status varchar(20),
    Customer_ID varchar(20),
    Policy_Duration_Days int,
    Policy_Duration_Years int,
    Premium_Paid int,
    Premium_Pending int,
    Payment_Status varchar (50),
    Policy_Duration_Initial decimal(10,2),
    Policy_Duration int,
    Total_Premium_Amount decimal(10,2),
    Total_Premium_Pending decimal(10,2),
    Policy_Payment_status varchar(50),
    Policy_Expiring_Current_Year varchar(20),
    Customer_Policy_Count int,
    Customer_Policy_Count_Type varchar(20)
    
);

load data infile 'Policy_Details_data.csv' into table Policy_Details
fields terminated by ','
ignore 1 lines;

select * from Policy_Details;

select * from Policy_Details where TOtal_Premium_Pending=12345;

update Policy_Details
set Total_Premium_pending=null 
where Total_Premium_pending=12345;

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

update Policy_Details
set Policy_Payment_Status=null 
where Policy_Payment_Status="No Data Found";



use insuranceanalytics;

select * from Policy_Details;
desc Policy_Details;

#Policy Dashboard
#KPI 1: Total Policy Count
select count(Policy_Id) as Total_Policies 
from Policy_Details;


#KPI 2: Total Premium Amount
select concat(round((sum(Premium_Amount)/1000000),2)," M") as Total_Premium_Amount
from Policy_Details;


#KPI 3: Total Active Policy Count
select count(Policy_ID) as Active_Policies
from Policy_Details
where status="Active";


#KPI 4: Renewed Policy Count
select 
	(sum(case
		when renewal_status="renewed"
        then 1
        else 0
	end)) as Renewed_Policies
from additional_fields;


#KPI 5: Renewed Policy percentage
select 
	concat(round((sum(case
		when renewal_status="renewed"
        then 1
        else 0
	end) / count(distinct policy_id))*100,2)," %") as Renewed_Policies
from additional_fields;


#KPI 6: Policy Expiring in this year
select count(Policy_ID) as Policies_Expiring_This_Year
from Policy_Details
where Policy_Expiring_current_year="Expiring";


#KPI 8: min, max, Average discount on policy
select min(Policy_Discounts) as Minimum_discount,max(Policy_Discounts) as Maximum_discount, avg(Policy_Discounts) as Average_discount
from additional_fields;



# Customer Dashboard
#KPI 1: Total Customer Count
select count(distinct customer_id) as Total_Customers
from Policy_Details;


#KPI 2: Customer Count with active policies
select count(distinct customer_id) as Customers_With_Active_policies
from Policy_Details
where status="Active";


#KPI 3: Customer Count with multiple polices
select count( distinct Customer_ID) as Customers_With_Multiple_Policies
from Policy_Details
where Customer_Policy_count>1;


#KPI 4: Customer Percentage with multiple polices
SELECT 
    (SUM(CASE WHEN policy_count > 1 THEN 1 ELSE 0 END) / COUNT(customer_id)) * 100 AS percentage_multiple_policies
FROM (
    SELECT customer_id, COUNT(policy_id) AS policy_count
    FROM Policy_Details
    GROUP BY customer_id
) AS policy_counts;


#KPI 5: Customer average tenure
select concat(round(avg(year_diff),2)," Years") average_customer_tenure 
from
(select customer_id,min(Policy_Start_Date),TIMESTAMPDIFF(YEAR,min(Policy_Start_Date), now()) AS year_diff
from policy_details
group by customer_id
order by customer_Id asc) cat;



# Claims Dashboard
#KPI 1: Total Claim count
select count(distinct claim_id) as Total_Claim_count 
from claims;


#KPI 2: Total Claim amount
select concat(round(sum(claim_amount)/1000000,2)," M") as Total_Claim_Amount
from claims;


#KPI 3: Approved Claim amount
select concat(round(sum(claim_amount)/1000000,2)," M") as Approved_Claim_Amount
from claims
where Claim_Status="Approved";


#KPI 4: Approved Claim amount percentage
SELECT 
    (SUM(CASE 
			WHEN Claim_Status = 'approved' 
            THEN 1 
            ELSE 0 
		 END) / COUNT(claim_id)) * 100 AS approval_rate
FROM claims;


#KPI 5: Average Claim amount
select round(avg(claim_amount),2) as Average_Claim_Amount
from claims;


#KPI 6: Average Claim proceesint time
select concat(round(avg(claim_processing_time),2)," Days") as Average_Claim_Processing_time
from claims;


#Tabular Outputs
#Policy Dashboard
#Graph 1: Policy _type vs Policy Count
select policy_type, count( distinct Policy_id) as count
from policy_details
group by Policy_type;


#Graph 2: Payment status vs Policy Count
select payment_status, count( distinct Policy_id) as count
from policy_details
where payment_status is not null
group by Payment_status;


#Graph 3: Policy _type vs coverage Count
select Policy_type,concat(round((sum(coverage_amount)/1000000),2)," M") as Coverage_amount
from Policy_Details
group by policy_type;


#Graph 4: Policy _type vs Premium amount
select Policy_type,concat(round((sum(premium_amount)/1000000),2)," M") as premium_amount
from Policy_Details
group by policy_type;


#Graph 5: Policy _type vs average policy duration
select Policy_type,concat(round(avg(policy_duration_years),2)," YEars") as average_policy_Duration
from Policy_Details
group by policy_type;


#Graph 6: Policy _type vs paymetn frequenct and amount
select Policy_type, payment_frequency, sum(coverage_amount),sum(Premium_Amount)
from policy_details
group by Policy_type,payment_frequency
order by Policy_type;


#Graph 7: Policy _type vs Policy status
select Policy_type, status, count(Policy_ID)
from policy_details
group by Policy_type,status
order by Policy_type;


#Graph 8: Policy _count vs risk band
select risk_band,count( distinct policy_id) as Poilcy_count
from additional_fields
group by risk_band; 


create view Policy_additioanl_fields as
select pd.Policy_ID, pd.Policy_type,af.Policy_Discounts,af.risk_band
from policy_details pd
join additional_fields af on pd.Policy_ID=af.Policy_ID;

select * from policy_additioanl_fields;

#Graph 9: Policy _type vs risk band
select Policy_Type,Risk_Band, count(Policy_ID) as Policy_Count
from policy_additioanl_fields
group by policy_type,Risk_Band
order by Policy_type,
			CASE 
            WHEN Risk_Band = "Low" THEN 1
            WHEN Risk_Band = "Medium" THEN 2
            ELSE 3
         END;


#Graph 10: Policy _type vs avg discount
select Policy_Type,avg(policy_discounts)
from policy_additioanl_fields
group by policy_type
order by Policy_type;


#Graph 11: Policy expiring/not expiring
select Policy_Expiring_current_Year,count(distinct policy_id) as Policy_Count
from Policy_details
group by Policy_Expiring_current_Year;


#Graph 12: Year vs Policy Count
select d.Year,count(pd.policy_id)
from Policy_details pd
join date d on pd.Policy_start_date= d.Policy_start_date
group by Year
order by Year;


#Graph 13: Year vs premium amount
select d.Year,sum(pd.premium_amount)
from Policy_details pd
join date d on pd.Policy_start_date= d.Policy_start_date
group by Year
order by Year;


#Graph 14: Month vs Premium amount
select d.Month_name,sum(pd.premium_amount)
from Policy_details pd
join date d on pd.Policy_start_date= d.Policy_start_date
group by Month_Number,Month_Name
order by Month_Number;


#Graph 15: Quarter vs premium amount
select d.Quater,sum(pd.premium_amount)
from Policy_details pd
join date d on pd.Policy_start_date= d.Policy_start_date
group by Quater
order by quater;



#Customer Dashboard
create view policy_customer_additional_fields as
select pd.Policy_id, pd.policy_type,pd.coverage_amount,pd.premium_amount,pd.customer_id,pd.policy_duration_Years,pd.Payment_status,
		pd.Customer_policy_count_type,ci.gender,ci.age_group,ci.Marital_status,ci.occupation,af.risk_band
from policy_Details pd
join customer_information ci on pd.customer_id=ci.Customer_id
join additional_fields af on pd.policy_id=af.Policy_ID;

select * from policy_customer_additional_fields;

#Graph 1: Gender vs Customer count,Policy Count,premium amount, average policy duration
select gender,count( distinct customer_id), count(policy_id),sum(premium_amount), avg(policy_duration_years)
from policy_customer_additional_fields
group by gender;


#Graph 2: Age group vs Customer count,Policy Count,premium amount, average policy duration
select age_group,count( distinct customer_id), count(policy_id),sum(premium_amount), avg(policy_duration_years)
from policy_customer_additional_fields
group by age_group;


#Graph 3: MArital Status vs Customer count,Policy Count,premium amount, average policy duration
select Marital_status,count( distinct customer_id),count(policy_id),sum(premium_amount), avg(policy_duration_years)
from policy_customer_additional_fields
group by marital_status;


#Graph 4: Occupation vs Customer count,Policy Count,premium amount, average policy duration
select occupation,count( distinct customer_id) as customer_count, count(policy_id),sum(premium_amount), avg(policy_duration_years)
from policy_customer_additional_fields
group by occupation
order by count(policy_id) desc
limit 10;


#Graph 5: Risk band vs Customer count
select risk_band,count( distinct customer_id)
from policy_customer_additional_fields
group by risk_band;


#Graph 6: Gender vs Policy  type Count
select gender, policy_type,count(policy_id)
from policy_customer_additional_fields
group by gender, policy_type
order by gender;


#Graph 7: AGe group vs Policy  type Count
select age_group, policy_type,count(policy_id)
from policy_customer_additional_fields
group by age_group, policy_type
order by age_group;


#Claims Dashboard
#Graph 1: claim_status vs claim Count
select claim_status,count(policy_id)
from claims
group by claim_status;


#Graph 2: claim_status vs claim amount
select claim_status,concat(round(sum(claim_amount)/1000000,2)," M") as claim_amount
from claims
group by claim_status;


create view claims_policy_additonal_fields as
select pd.policy_id,pd.policy_type,c.claim_id,c.claim_amount,c.claim_status,c.claim_processing_time,af.risk_band
from policy_details pd
join claims c on pd.Policy_ID=c.Policy_ID
join additional_fields af on pd.Policy_ID=af.policy_id;

select * from claims_policy_additonal_fields;

#Graph 3: Policy type vs approvedclaim Count
select policy_type,concat(round(sum(claim_amount)/1000000,2)," M") as approved_claim_amount
from claims_policy_additonal_fields
where claim_Status="Approved"
group by policy_type;


#Graph 4: risk band vs claim amount
select risk_band,concat(round(sum(claim_amount)/1000000,2)," M") as claim_amount
from claims_policy_additonal_fields
group by risk_band;


#Graph 5: policy type vs average claim time
select policy_type,concat(round(avg(claim_processing_time),2)," days") as average_claim_time
from claims_policy_additonal_fields
group by policy_type;
