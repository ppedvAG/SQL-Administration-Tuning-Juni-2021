/*
wichtig ist das WHERE!!!!

Clustered (gruppierter)
=Tabelle in sortierter Form
gibts nur 1x  pro Tabelle

where: between < > , aber auch = , like 
Tipp: lege zuerst immer den CL IX fest


Non Clustered (nicht gruppierter)
Kopie der Daten in IX Seiten, dann Baumstruktur mit Zeigern
theoretisch ca 1000 ngr IX pro Tabelle

where: gut bei = , PK.. bei rel geringer Ergebnismenge (1%, 60%)



----------------------------------
eindeutiger IX x
zusammengesetzter IX x
IX mit eingeschlossenen Spalten x
gefilterter IX x
part IX 
abdeckenden IX x  reinen SEEK
ind Sicht x
realer hypothetischer IX  --Tool  DTA
------------------------------------
Columnstore IX (Gr / nicht gr) x





*/


select * from Northwind..customers

select * into kunden from customers

--HEAP
insert into Kunden (CustomerID, CompanyName) values ('AAedv', 'BBbbedv ag')

select * from kunden



select * into ku2 from kundeumsatz

select top 3 * from ku2

alter table ku2 add id int identity

-----
set statistics io, time on
--GR IX auf Orderdate reserviert
select ID from ku2 where ID = 10 --Table Scan 59859 Seiten


--NIX_ID
select ID from ku2 where ID = 10 --IX SEEK ... 3 Seiten


select ID, freight from ku2 where ID = 10 --IX_SEEK mit Lookup

select ID, freight from ku2 where ID < 13000 --je mehr desto teurer , ab ca 1,x% Table SCAN

--Lookup muss weg..
--NIX_ID_FR --zusammengesetzter eindeutiger IX .. mehr Schlüsselspalten (im IX Baum)

select ID, freight from ku2 where ID = 10 -- auch bei kliner 130000 noch IX Seek

--wieder Lookup--> alle Spalten aus dem Select müssten im IX Sein
--ein zusammengesetzt IX kann nur 16 Spalten max od 900bytes haben
select id , freight, customerid from ku2 where id= 10


--besser: IX mit eingeschlossenen Spalten
--NIX_ID_i_FR_CID_    1000Spalten

select id , freight, customerid from ku2 where id= 10

--Faustregel:
--alle where Spalten müssen in die Schlüsselspalten rein
--alle Select Spalten als eingeschlossene Spalten


--TABLE SCAN

select country, productname, SUM(unitprice*quantity) from ku2
where UnitsinStock <2 or freight <2
group by country, productname


select * from sys.indexes










--Kopie der ku2
select * into ku3 from ku2

--Abfrage, mit where und Summe
select top 3 * from ku2


--Umsatz p  alle Best aus Germany...

select SUM(unitprice*quantity) from ku2 where country = 'germany' --884-- 50/60

--idealer Index


select SUM(unitprice*quantity) from ku3 where country = 'germany' or country = 'Italy'

select SUM(unitprice*quantity) from ku3 where country = 'germany' or country = 'Italy'--884-- 50/60


--Nach Columnstore 4 MB statt 366 MB und jede Abfrage schneller
--Kompression... 40 bis 60%

--Seiten (4,1MB) sind auch genauso im RAM

--Archivierungskompression  statt 4,1 bei 3,1 MB


--ind Sicht


select country, COUNT(*) from ku2 group by country


create view vdemo1 with schemabinding
as
select country, COUNT_BIG(*) as Anzahl from dbo.ku2 group by country


select * from vdemo1