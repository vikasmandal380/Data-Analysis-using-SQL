SELECT cuisine from restaurants group by cuisine;
SELECT restaurant_name, cuisine from restaurants;
select restaurant_id,item_name from food_items where food_type = 'non-vegetarian';
select order_date,
case 
when dayofmonth(order_date)=2 then "monday"
else "september"
end as dom
from orders
group by dayofmonth(order_date);
select sum(final_price) as total_price,count(order_id) as order_count,
case
when dayofweek(order_date)=1 then "weekend"
when dayofweek(order_date)=7 then "weekend"
else "weekday"
end as WDay
from orders
group by WDay;