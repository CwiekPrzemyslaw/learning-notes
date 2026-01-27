-- Task 1. Show top 10 newest orders.
select top 10 * from Sales.Orders
ORDER BY OrderDate DESC;

-- Task 2. 20 orders that have already been shipped, focusing on the most recent shipments.
select PickingCompletedWhen from Sales.Orders

select TOP 20 OrderID, PickingCompletedWhen from Sales.Orders
Where PickingCompletedWhen is not NULL
ORDER BY PickingCompletedWhen DESC

-- Task 3. Retrieve all orders placed in 2014.
select OrderID from Sales.Orders
Where YEAR(OrderDate) = 2014;

SELECT OrderID
FROM Sales.Orders
WHERE OrderDate >= '2014-01-01'
  AND OrderDate <  '2015-01-01';

-- Filter on the column, not on a function applied to the column.
-- Task 4. Retrieve the number of orders placed in each year.

select YEAR(OrderDate) as 'Year', COUNT(OrderID) as 'Nr. of orders' from Sales.orders
GROUP BY YEAR(OrderDate)
order by YEAR(OrderDate); -- or just YEAR

-- Task 5. Retrieve all years in which more than 20000 orders were placed.
select YEAR(OrderDate) as 'Year with more then 20000 orders' from Sales.Orders
GROUP by YEAR(OrderDate)
HAVING COUNT(OrderID) > 20000;

-- Task 6. Retrieve the number of orders placed by each customer,
-- showing only customers who placed at least one order.
-- Results should be sorted from the highest to the lowest number of orders.

select Sales.Customers.CustomerName as 'Name of customer', count(Sales.Orders.OrderID) as 'Nr. of orders'
from Sales.Orders join Sales.Customers on sales.Orders.CustomerID = Sales.Customers.CustomerID
GROUP BY Sales.Customers.CustomerName
having count(sales.Orders.OrderID) > 0 -- not needed becouse join arledy filtered clients with order, it would matter with left join
ORDER by count(sales.Orders.OrderID) DESC

-- Task 7. Retrieve a list of all customers together with the number of orders they placed.
-- Include customers who placed zero orders.
-- Sort by the number of orders (descending), then by customer name (ascending).

