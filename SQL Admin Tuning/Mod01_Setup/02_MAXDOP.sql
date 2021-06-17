/*
Abfragen können einen oder mehrere CPUs verwenden...

schulung\Administrator   ppedv2019!



*/

SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.ShipCountry, Orders.ShipCity, Orders.ShipName, Orders.Freight, 
                         Orders.OrderDate, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName, 
                         Employees.BirthDate
INTO KundeUmsatz
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


insert into KundeUmsatz
select * from kundeumsatz
go 9
--ca 551000 --10 Sekunden

select country, city, sum(unitprice*quantity) from kundeumsatz
where freight < 100
group by  country, city

--Im Plan: Doppelpfeile

set statistics io, time on -- IO Anzahl der Seiten, Dauer in ms , CPU in ms

--- CPU-Zeit = 814 ms, verstrichene Zeit = 188 ms.  Seiten 46302
--Paral.. weniger Zeit bei größerem Aufwand

--bei 4 CPUS statt 8
-- CPU-Zeit = 625 ms, verstrichene Zeit = 166 ms.  Seiten 46302

--sind je mehr CPUs besser 

--Default: MAXDOP 0 bis SQL 2014.. alle CPUs verwendet
--seit SQL 2018 : Anzahl der Kerne , aber max 8
--KOstenschwellwert: default bei 5 .. immer alle lt MAXDOP

--bei 1 CPU
--, CPU-Zeit = 360 ms, verstrichene Zeit = 355 ms.

--bei 6 CPUS
--, CPU-Zeit = 702 ms, verstrichene Zeit = 130 ms.


--Im Plan ein Gather oder/und Repartition Stream = guter Hinweis für zuviele CPUs

--Man kann den Kostenschwellwert höher stellen, so dass später paral. wird

--SCOPED DATABASE: Settings des Server auch DBs


--geht auch pro Abfrage
select country, city, sum(unitprice*quantity) from kundeumsatz
where freight < 100
group by  country, city  option (maxdop 2)





