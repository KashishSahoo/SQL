select c.category_id as CATEGORYID ,c.category_name as CATEGORYNAME
from channels_category as c
where c.categoryname like 'M%';

select x.* from td as x
inner join sd as y
on x.train_from=y.station_id or x.train_to=y.station_id
where y.station_name like '% %';