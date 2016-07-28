/* 1 */
select clients.name
from orders
  inner join clients on clients.id = orders.client_id
where orders.order_date >= date_sub(curdate(), interval 7 day); # last 7 days

/* 2 */
select clients.name
from orders
  inner join clients on clients.id=orders.client_id
order by orders.id
limit 5;

/* 3 */
select clients.name
from orders
  inner join clients on clients.id = orders.client_id
  inner join merchandise on merchandise.id = orders.item_id
group by merchandise.cost
order by count(merchandise.cost)
limit 10;

/* 4 */
select clients.name
from orders
  inner join merchandise on merchandise.id = orders.item_id
  inner join clients on clients.id = orders.client_id
where status <> 'complete';
