create database covid19_analysis;
use covid19_analysis;

create table patientage
(Sno int,
	AgeGroup varchar(200),	
    TotalCases varchar(200),
	Percentage varchar(200));
    desc patientage;

create table hospitalsbed
(Sr_no int,
State_UT	varchar(200),
NumPrimaryHealthCenters_HMIS	varchar(200),
NumCommunityHealthCenters_HMIS	varchar(200),
NumSubDistrictHospitals_HMIS varchar(200),
NumDistrictHospitals_HMIS	varchar(200),
TotalPublicHealthFacilities_HMIS	varchar(200),
NumPublicBeds_HMIS	varchar(200),
NumRuralHospitals_NHP18	varchar(200),
NumRuralBeds_NHP18	varchar(200),
NumUrbanHospitals_NHP18	varchar(200),
NumUrbanBeds_NHP18 varchar(200));

create table icmrtlabs
(lab varchar(200),	
address	varchar(200),
pincode varchar(200),
city varchar(200),
state varchar(200),
lab_type varchar(200));

create table testing_details
(Date	varchar(200),
State	varchar(200),
TotalSamples	varchar(200),
Negative	varchar(200),
Positive varchar(200));

create table individualpersons_data
(id	int,
government_id	varchar(200),
diagnosed_date	varchar(200),
age int,
gender	char(200),
detected_city varchar(200),	
detected_district varchar(200),	
detected_state varchar(200),
nationality	varchar(200),
current_status	varchar(200),
status_change_date	varchar(200),
notes char(200));

desc individualpersons_data;


select * from patientage;
select * from hospitalsbed; 


/* percentage of people according in category of the age of people*/

select agegroup,percentage
from patientage;

/* which category of age group have maximum covid19 cases */


 
 
 /*Analysis Statewise Testing Details*/
 select date,state, sum(totalsamples)
 over (partition by state,date) as totaltest from testing_details;	
 
 select state, max(totalsamples)
  from testing_details;
 group by state;
 
 /* analysis of testing labs in country  statewise*/
 select state,count(lab)as nooflabs  from icmrtlabs
 group by state
 order by nooflabs desc;
 
 
 /* Labs in government & private Category wise,collection site*/
 
 /*Government Category*/
 select state,lab_type,count(lab) as nooflabs 
 from icmrtlabs
where lab_type = "government laboratory" 
group by state
order by nooflabs desc;

/*Private Category*/
select state,lab_type,count(lab) as nooflabs 
 from icmrtlabs
where lab_type = "private laboratory" 
group by state
order by nooflabs desc;

/*collection site*/
select state,lab_type,count(lab) as nooflabs 
 from icmrtlabs
where lab_type = "collection site" 
group by state
order by nooflabs desc;

/*Analysis of number of public health facilities and number of beds[rural Area]*/
/*Health Facilities in Rural Area*/
select state_ut,NumRuralHospitals_NHP18,NumRuralBeds_NHP18
from hospitalsbed
group by state_ut;

/* Beds In Rural*/
select state_ut,NumRuralBeds_NHP18
from hospitalsbed
group by state_ut
order by state_ut desc;

/*Analysis of number of public health facilities and number of beds[urban Area]*/
/*Health Facilities in Urban Area*/
select state_ut,NumurbanHospitals_NHP18,NumurbanBeds_NHP18
from hospitalsbed
group by state_ut;

/* Beds In urban*/
select state_ut,NumurbanBeds_NHP18
from hospitalsbed
group by state_ut
order by state_ut desc;

/*Analysis of  based on Gender,States and number of Active cases*/
select gender,detected_state,count(detected_state) as totalactivecases
from individualpersons_data
group by detected_state;

/* No. of Females detected active cases*/
select Detected_state,count(detected_state) as nooffemales
from individualpersons_data
where gender="F"
group by detected_state;

/* No. of males detected active cases*/
select Detected_state,count(detected_state) as nooffemales
from individualpersons_data
where gender="M"
group by detected_state;

/*cases detected in district*/
select gender,detected_district,count(detected_district) as cases
from individualpersons_data
group by detected_district;


/* 
