# Desafio-SQL-DIO

Elabore perguntas e utilize nos script SQL:
- Select Statement
- Where Statement
- Order by
- Junções de tabelas

** Perguntas **:

1. Quantos CPFs temos cadastrados?
- select count(*) from peoplecompany group by idident;

2. Quais as formas de pagamentos chegaram ser utilizadas e também as ordene?
- select distinct(payment) from orders order by payment;

3. Que clientes compraram que produtos e a quantidade?
- select concat(c.Fname,' ',c.Mname,' ',c.Lname) Complete_name, pro.pname as equipment, p.poQuantity as quantidad
from clients c inner join orders o on
c.idClient = o.idOrder inner join productorder p on 
o.idOrder = p.idPOorder inner join product pro on p.idPOorder = pro.idProduct;
