

/* 5 */
select merchandise.id
from merchandise
  inner join orders on merchandise.id=orders.item_id
where status <> 'complete';
