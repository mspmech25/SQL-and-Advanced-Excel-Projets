create database harry_porter;
use harry_porter;
select w.id,p.age,w.power,w.coins_needed
from wands as w
inner join wands_property as p
on w.code=p.code
and p.is_evil =0
where (w.power,w.code,w.coins_needed) in (select power,code, min(coins_needed) from wands
group by power,code
)
order by w.power desc,p.age desc;