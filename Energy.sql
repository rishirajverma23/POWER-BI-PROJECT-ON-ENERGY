create database energy;
use energy;
show tables;
select * from industry1;
################################################################################################
create view industry as
select FACILITY_ID, FACILITY_NAME, FUEL_TYPE, UNIT_NAME, UNIT_TYPE, LATITUDE, LONGITUDE, STATE, 
PRIMARY_NAICS_TITLE, COGENERATION_UNIT_EMISS_IND, MECS_Region, MMBtu_TOTAL, GWht_TOTAL, `GROUPING` from industry1;
################################################################################################
#  Q1
create view EE as select FUEL_TYPE,round(sum(MMBtu_TOTAL),2) as Total_MMBtu from industry where 
FUEL_TYPE in( "ethane","Ethanol (100%)") group by FUEL_TYPE;

# Q2
create view 3M as select FACILITY_NAME, round(avg(GWht_TOTAL),2) as Avg_of_GWht_Total from industry where 
FACILITY_NAME = "3M COMPANY";

# Q3 
select unit_name from industry where unit_name between (1950 and 2023) and unit_name like "__-___" 
or unit_name like "___-__" ;


# Q4
create or replace view region as select MECS_Region, concat(round((sum(MMBtu_TOTAL) / (select sum(MMBtu_TOTAL) 
from industry)*100),2),"%") as MMBtu_percentage,
concat(round((sum(GWht_TOTAL) / (select sum(GWht_TOTAL) from industry)*100),2),"%") as GWht_percentage 
from industry
group by MECS_Region limit 4;



# Q.5
create or replace view naics as select distinct PRIMARY_NAICS_TITLE, 
count(distinct facility_name) as "Total Facility", count(distinct FUEL_TYPE) as "Total Fuel" from industry 
group by PRIMARY_NAICS_TITLE;

################################################################################################

Use energy;
Select * from Industry;
Select * from EE;
Select * from 3M;
# Select * from UN;
Select * from Region;
call region("west");
Select * from NAICS;

################################################################################################

select * from region;
