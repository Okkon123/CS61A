.read data.sql


CREATE TABLE average_prices AS
  SELECT category AS category,AVG(MSRP) AS average_price FROM products GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT store AS store,item AS item,price AS price FROM inventory GROUP BY item HAVING min(price)=price;


CREATE TABLE shopping_list AS
  SELECT a.name AS name,b.store AS store FROM products AS a,lowest_prices AS b WHERE a.name=b.item 
  GROUP BY a.category HAVING min(a.MSRP/a.rating)=a.MSRP/a.rating;


CREATE TABLE total_bandwidth AS
  SELECT sum(a.Mbs) FROM stores AS a,shopping_list AS b WHERE a.store=b.store;

