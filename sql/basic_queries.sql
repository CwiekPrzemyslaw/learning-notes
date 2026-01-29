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

select Sales.Customers.CustomerName as 'Name of customer', count(Sales.Orders.OrderID)
from Sales.Customers LEFT join sales.Orders on Sales.Customers.CustomerID = sales.Orders.CustomerID
GROUP BY Sales.Customers.CustomerName
order by count(Sales.Orders.OrderID) DESC, Sales.Customers.CustomerName

-- Task 8. Retrieve the total order value for each order.

select OrderID, sum(Quantity*UnitPrice) as TotalUnitValue
from Sales.OrderLines
GROUP BY OrderID

-- Task 9. Retrieve the total order value for each order,
-- including the order date.

select OL.OrderID, O.OrderDate, sum(Quantity*UnitPrice) as TotalUnitValue
from Sales.OrderLines OL join Sales.Orders O on OL.OrderID = O.OrderID
GROUP BY OL.OrderID, O.OrderDate

-- Task 10. Retrieve the average order value per year.

SELECT Oyear, AVG(TotalUnitValue)
from (select YEAR(O.OrderDate) as Oyear, o.OrderID, sum(Quantity*UnitPrice) as TotalUnitValue 
from Sales.Orders O join Sales.OrderLines OL on O.OrderID = OL.OrderID
GROUP BY o.OrderID, YEAR(O.OrderDate)) t
GROUP BY Oyear
ORDER BY Oyear

-- Task 11. Retrieve the top 5 customers by total order value.

select top 5 TotalOrderValue, NameC
from (select C.CustomerName as NameC, sum(Quantity*UnitPrice) as TotalOrderValue
from sales.OrderLines OL JOIN sales.Orders O on OL.OrderID = O.OrderID join Sales.Customers C on O.CustomerID = C.CustomerID
GROUP BY C.CustomerName) t
ORDER BY TotalOrderValue DESC