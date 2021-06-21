
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




















