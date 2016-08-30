--Lenny Castaneda
--August 29, 2016

--Write a query to return all category names with their descriptions from the Categories table.
select all [CategoryName], [Description] 
from [dbo].[Categories]

--Write a query to return the contact name, customer id, company name and city name of all Customers in London
select [ContactName], [CustomerID],[CompanyName], [City]
from [dbo].[Customers]
where [City] IN ('London')

--Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
select [Fax] 
from  [dbo].[Suppliers]
where [Fax] IS NOT NULL AND [ContactTitle] IN ('Marketing Manager', 'Sales Representative')

--Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units.
select [CustomerID]
from [dbo].[Orders]
where [RequiredDate] BETWEEN '1997-01-01' and '1997-12-31' AND [Freight] < 100

--Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.
select [CompanyName], [ContactName]
from [dbo].[Customers]
where [Country] IN ('Mexico', 'Sweden', 'Germany')

--Write a query to return a count of the number of discontinued products in the Products table.
select COUNT([Discontinued])
from [dbo].[Products]

--Write a query to return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
select [CategoryName], [Description] 
from [dbo].[Categories]
where [CategoryName] LIKE 'Co%' OR [Description] LIKE 'Co%'

--Write a query to return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
select [CompanyName],[City],[Country],[PostalCode]
from [dbo].[Suppliers]
where [Address] LIKE '%rue%'
order by [CompanyName]

--Write a query to return the product id and the quantity ordered for each product labelled as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.
select [ProductID],[Quantity] 
from [dbo].[Order Details]
order by [Quantity] desc

--Write a query to return the company name, address, city, postal code and country of all customers with orders that shipped using Speedy Express, along with the date that the order was made.
select [CompanyName],[Address],[City],[PostalCode],[Country],[OrderDate]
from [dbo].[Customers], [dbo].[Orders]
where Orders.ShipVia = 1 


--Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.
select [CompanyName], [ContactName], [ContactTitle], [Region]
from [dbo].[Suppliers]


--Write a query to return all product names from the Products table that are condiments.
select [ProductName]
from [dbo].[Products]
where [CategoryID] = 2


--Write a query to return a list of customer names who have no orders in the Orders table.
select [ContactName]
from [dbo].[Customers]
where Customers.CustomerID NOT IN(select Orders.CustomerID from Orders)

-- use this query to double check if the customer ID is in fact not in the Orders table.
select [CustomerID]
from [dbo].[Orders]
order by [CustomerID]

--Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.
insert  into [dbo].[Shippers] (CompanyName) values ('Amazon') 


--Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
update [dbo].[Shippers] 
set [CompanyName] = 'Amazon Prime Shipping'
where CompanyName = ('Amazon')		-- Where columns are for expressions, true/false, etc.


--Write a query to return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
SELECT Shippers.CompanyName, format(round(sum(Orders.Freight),0),'C') AS FreightTotals FROM Orders
LEFT JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName;


--Write a query to return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. 
--The combined format should be 'LastName, FirstName'.
select [LastName] + ', ' + [FirstName] as 'DisplayName'
from [dbo].[Employees]


--Write a query to add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
--- MUST RUN ONE AT A TIME
insert into Customers ([CustomerID],[CompanyName],[ContactName]) values ('LNYCA', 'Lenny Company', 'Lenny Castaneda')

--- MUST RUN ALL THREE AT A TIME
SET IDENTITY_INSERT Orders ON
insert into [dbo].[Orders] ([OrderID],[CustomerID]) values (11078,'LNYCA')
SET IDENTITY_INSERT Orders OFF 

--- MUST RUN ONE AT A TIME
insert into [dbo].[Order Details] ([OrderID],ProductID,[UnitPrice],[Quantity],[Discount] ) values (11078,6,25,1,0)


--Write a query to remove yourself and your order from the database.

--MUST RUN EACH PAIR OF DELETE AND WHERE STATEMENTS ONE AT A TIME!!!!!!!
delete [dbo].[Order Details] 
where [Order Details].OrderID = 11078

--MUST RUN EACH PAIR OF DELETE AND WHERE STATEMENTS ONE AT A TIME!!!!!!!
delete [dbo].[Orders]
where Orders.OrderID = 11078

--MUST RUN EACH PAIR OF DELETE AND WHERE STATEMENTS ONE AT A TIME!!!!!!!
delete [dbo].[Customers]
where Customers.CustomerID = 'LNYCA'


--Write a query to return a list of products from the Products table along with the total units in stock for each product. 
--Include only products with TotalUnits greater than 100.
select [ProductName],[UnitsInStock]
from [dbo].[Products]
where [UnitsInStock] > 100
