/* 1 */
select clients.name
from orders
  inner join clients on clients.id=orders.client_id
where orders.order_date >= date_sub(curdate(), interval 7 day); # last 7 days

/* 2 */
select clients.name
from orders
  inner join clients on clients.id=orders.client_id
where ; 

/* 3 */
select clients.name
from orders
  inner join clients on clients.id=orders.client_id
where ;

/* 4 */
select clients.name
from orders
  inner join clients on clients.id=orders.client_id
where ;

/* 5 */
select clients.name
from orders
  inner join merchendaise on merchendaise.id=orders.item_id
  inner join clients on clients.id=orders.client_id
where status <> 'complete';
