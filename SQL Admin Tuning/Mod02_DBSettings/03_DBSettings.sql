/*
create database testdb

1. Größe der DB: 16MB (8MB +8MB)
					  5+2
2. Wachstumsraten: 64MB
					1MB Daten + 10%


==>


*/

create database testdby


use testdby

create table t1 (id int identity, spx char(4100))


set statistics io, time off


insert into t1
select 'XY'
GO 20000


--Wir wollen keine Vergrößerungen haben..
--Wert setzen auf: Wie groß wird die DB in ca 3 Jahren (Lebenszeit)


--Das Logfile hat VLFs... virtuelle Logfiles

----------------------------10MB
-- - - - - - - - - - - - - - - 
1MB VLF  10 VLFs

----------------------------100MB
- - - - - - - - - - - - -   10VLFs

--Das Logfile sollte nicht mehr als 1000/3000 VLFs 

------------------------100MB---------------------------200MB
 - - - - - - - - - - - - 10VLFs----------------------20VLFs

 64  1000

 --evtl bei sehr großen DBs mit großen LFiles .. Wachstum auf 1 GB






 --char fixe Länge
create table t1 (id int identity, spx char(4100))


set statistics io, time off


insert into t1
select 'XY'
GO 20000

select 20000*4--80MB.. hat aber 160MB
set statistics time, io on
select * from t1 where id =10

---SEITEN!!!!!!!!
/*
SQL hat Seiten: 8192bytes
Nutzlast von ca 8072bytes
1 DS muss i.d. r. in eine Seite passen und kann nicht mehr als 8060bytes haben

??? image, text, varchar(max), varbinary(max)... können max 2 GB Inhalt

*/

create table t2 (id int identity, sp1 char(4100), sp2 char(4100))-- geht nicht


/*

Tabelle mit 1 MIO DS
1 DS hat eine Länge von 4100bytes
-->Seiten: 1 MIO Seiten-----> 8 GB (HDD)---> 1:1 ---> RAM

--Suche Tabellen mit großem Verlust

*/
dbcc showcontig('t1')

--- Gescannte Seiten.............................: 20000
-- Mittlere Seitendichte (voll).....................: 50.79%

--Ziel: Seiten auslasten...aber wie?

--Datentyp ändern--> APP geht evtl nicht mehr
--Normalisierung...ebtg jeglicher Regel --> APP geht nicht 

---Fax1  Fax2 Fax3 Frau1 Frau2 Frau3 Frau4 Religion


1 MIO DS a 4000--> 2DS/Seite --> 4 GB
1 MIO DS a 100--> 80DS/Seite->12500Seiten--> ca 110MB ----> 4,1GB statt 8 GB


--Kompression
--Zeilenkompression und Seitenkompression
--Kompression wird auf ca 40-60% runterkommen


--SQL Neustart-- RAM : 654--60 ca gleich

set statistics io, time on
select * from testdby..t1  --(160)
--Seiten:32      CPU: 328      Dauer: 1708

--Nach Abfrage -- RAM : 657


--JETZT KOMPRESSION

--SQL Neustart-- RAM : merkbar messbar weniger,

set statistics io, time on
select * from testdby..t1  --(deutlich weniger) 300kb
--Seiten: 32     CPU: mehr oder weniger       Dauer: ca gleich

--Nach Abfrage -- RAM : weniger!

--beim Cllient müssen 160MB ankommen

--Warum nicht gleich jede tabelle komprimieren...? CPU würde auf 100 % hochschnellen
--




















