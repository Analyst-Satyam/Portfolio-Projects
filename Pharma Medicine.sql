select * 
from medicine_details;

alter table medicine_details
change column `Medicine Name` Medicine_Name varchar(300);


alter table medicine_details
change column Composition Composition varchar(500);

alter table medicine_details
change column `Image URL` Image_URL varchar(500);

alter table medicine_details
change column Manufacturer Manufacturer varchar(300);




-- Level-1 :- Exploration — understand the data

select * 
from medicine_details
limit 10;


select distinct Manufacturer  
from medicine_details;

select count(distinct Manufacturer) as Total_Manufacturure
from medicine_details;



select `Medicine Name`, Composition, Manufacturer
from medicine_details
where Manufacturer = 'Pfizer Ltd'
order by `Medicine Name`;




select Medicine_Name, Manufacturer, `Excellent Review %`
from medicine_details
where `Excellent Review %` > 80
order by `Excellent Review %` desc;




select Manufacturer, count(distinct Medicine_Name) as medicine_count
from medicine_details
group by Manufacturer
order by medicine_count desc
limit 10 ;




-- Level-2 :- Data Cleaning — fix the problems


select *
from medicine_details
where Manufacturer is Null
or Manufacturer = '';






alter table medicine_details
drop column Image_URL;

select *
from medicine_details;




select Medicine_Name, Manufacturer, Uses
from medicine_details
where Uses is null
or Uses = '';






select *
from medicine_details;

select *
from medicine_details
where (`Excellent Review %`+`Average Review %`+`Poor Review %`) != 100 ;

select Medicine_Name, `Excellent Review %` , `Average Review %`, `Poor Review %`,
(`Excellent Review %`+`Average Review %`+`Poor Review %`) as Total_Review
from medicine_details;

select count(*) as Problamatic_Report
from medicine_details
where (`Excellent Review %`+`Average Review %`+`Poor Review %`) != 100;



 

select Medicine_Name, count(*) as Repeated_Med 
from medicine_details
group by Medicine_Name
having count(*) > 1
order by Repeated_Med desc;



select *
from medicine_details
where Medicine_Name = 'Lulifin Cream';





select Manufacturer, trim(Manufacturer)
from medicine_details
where Manufacturer != trim(Manufacturer);



select * 
from medicine_details;

select Medicine_Name, trim(Medicine_Name) 
from medicine_details;

update medicine_details
set Medicine_Name = trim(Medicine_Name);

select Composition, trim(Composition)
from medicine_details;

update medicine_details
set Composition = trim(Composition);

select Uses, trim(Uses)
from medicine_details;

update medicine_details
set Uses = trim(Uses);

select Side_effects, trim(Side_effects)
from medicine_details;

update medicine_details
set Side_effects = trim(Side_effects);

select Manufacturer, trim(Manufacturer)
from medicine_details;

update medicine_details
set Manufacturer = trim(Manufacturer);





-- Level-3 :— Business Analysis Assignments


select *
from medicine_details;

select Composition, count(*) as Med_use
from medicine_details
group by Composition
having count(*) > 1
order by Med_use desc
limit 10 ;





select Manufacturer, avg(`Excellent Review %`) as Avg_Excellent_Review,
		count(*) as Medicine_Count
from medicine_details
group by Manufacturer
having count(*) >= 20
order by Avg_Excellent_Review desc;




select Medicine_Name, Manufacturer, `Excellent Review %`, `Poor Review %`
from medicine_details
where `Poor Review %` > `Excellent Review %`;




select Manufacturer, Medicine_Name, Composition, `Excellent Review %`
from medicine_details
where Manufacturer = 'Torrent Pharmaceuticals Ltd' 
and `Excellent Review %` < 50 ;




select Manufacturer, avg(`Poor Review %`) as Avg_Poor_Review , count(*) as Med_Count
from medicine_details
group by Manufacturer
having count(*) >= 10
order by Avg_Poor_Review desc ;




select Medicine_Name, Manufacturer, Uses
from medicine_details
where Uses like '%cancer%'
;

select count(*) as Medicine_Related_to_Cancer
from medicine_details
where Uses like '%cancer%'
;









-- Level-4 :— Advanced SQL (CTEs and Window Functions)


select Manufacturer, count(*) as Med_Count
from medicine_details
group by Manufacturer 
order by Med_Count desc
limit 3 ;


with Top_3_Manufacturer as
(
	select Manufacturer, count(*) as Med_Count
	from medicine_details
	group by Manufacturer 
	order by Med_Count desc
	limit 3
)
select m.Medicine_Name, t.Manufacturer 
from  medicine_details m
join Top_3_Manufacturer t
	on t.Manufacturer = m.Manufacturer 
order by t.Med_Count desc, m.Medicine_Name
;





select Manufacturer, Medicine_Name,  `Excellent Review %`,
	rank() over (partition by Manufacturer 
				order by `Excellent Review %` desc) as Review_Rank
from medicine_details
where Manufacturer = 'Torrent Pharmaceuticals Ltd';




select Manufacturer, Medicine_Name, `Excellent Review %`,
		row_number() OVER (partition by Manufacturer order by `Excellent Review %` desc)
from medicine_details;


with Best_Medicine as
(
select Manufacturer, Medicine_Name, `Excellent Review %`,
		row_number() OVER (partition by Manufacturer order by `Excellent Review %` desc) as Rating
from medicine_details
)
select *
from Best_Medicine
where Rating = 1;





with Average_Review as
(
select Manufacturer, avg(`Excellent Review %`) as avg_review
from medicine_details
group by Manufacturer
),
Overall_Avg as
(
select avg(`Excellent Review %`) as overall_avg
from medicine_details
)
select a.Manufacturer, a.avg_review
from Average_Review a, Overall_Avg o
where o.overall_Avg < a.avg_review
order by a.avg_review desc;






SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       RANK() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) AS review_rank
FROM medicine_details
WHERE Manufacturer = 'Torrent Pharmaceuticals Ltd';


SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       percent_rank() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) AS review_percent_rank
FROM medicine_details
WHERE Manufacturer = 'Torrent Pharmaceuticals Ltd';


SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       ROUND(percent_rank() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) * 100, 2) AS pct_lower_than_self
FROM medicine_details
WHERE Manufacturer = 'Torrent Pharmaceuticals Ltd';


SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       ROUND(percent_rank() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) * 100, 2) AS pct_lower_than_self
FROM medicine_details
;






