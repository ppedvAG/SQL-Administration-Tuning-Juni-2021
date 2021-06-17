/*

Partitionierung

identisch
TAB A  10000
TAB B  100000

Abfrage: select ... 10 Zeilen
Welche von denen wird schneller antworten? 2Sek...A

Salamitaktik
Tab Umsatztabelle seit 2000

Variante 1 : part Sicht
*/
--statt einer sehr großen tabelle Umsatz viele kleine..
--in der Praxis auch mal pro Monat zu finden
create table u2021(id int identity, jahr int, spx int)
create table u2020(id int identity, jahr int, spx int)
create table u2019(id int identity, jahr int, spx int)



--wo ist meine Umsatz tabelle?
select * from umsatz

create view Umsatz
as
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019

--bisher kein Effekt ausser Aufwand
select * from umsatz
select * from umsatz where jahr = 2020

ALTER TABLE dbo.u2021 ADD CONSTRAINT
	CK_u2021 CHECK (jahr=2021)

--Einschränkungen können Perf verbessern
--Nachteil: Aufwendig, kein Identity (falls I U D), PK (ID und Jahr)

---es gibt was besseres:

--Partitionierung
--Seit SQL 2016 SP1 auch in Std bzw Express


--Dateigruppe:

create table t25 (id int) on HOT




Tabellen gezielt auf andere HDDs legen können..



create partition function fzahl(int)
as
RANGE LEFT FOR VALUES (100,200)
----------100]--------------------200]----------------
-- 1            2                      3 

select $partition.fzahl(117) ---2


Part F()

---------------------100-----------------200-------------5000-------------
   --   1					2					3					4


--DGruppen: bis100, bis200, bis5000, rest

create partition scheme schZahl
as
Partition fzahl to (bis100,bis200,rest)
------                 1     2      3


create table ptab(id int identity, nummer int, spx char(4100)) ON schZahl(nummer)

set statistics io, time off

declare @i as int = 0

while @i<20000
	begin
		insert into ptab values(@i,'XY')
		set @i=@i+1
	end

set statistics io, time on

select * from ptab where nummer = 117

--Indizes: SEEK herauspicken   SCAN von A bis Z

--HEAP ist der Sauhaufen an Daten.. in dem Fall 1 HEAP von 3 herauspicken


--Manipulieren... Idee neue Grenze 5000
select * from ptab where nummer = 1170

--Tabelle, pF(), pSch
--Schema-->pF()---> !!!nix


--neue Dgruppe angeben
alter partition scheme schZahl next used bis5000

select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
from ptab
group by   $partition.fzahl(nummer)

select * from ptab


alter partition function fzahl() split range(5000)-- Daten werden verschoben

select * from ptab where nummer = 13000 --Table Scan Heap mit 15000

select * from ptab where id = 13000 --kompletter Table SCan 20000


------100--------------200-----------------------5000--------
--  1            2                    3                    4


--Grenze entfernen:
-----------100!-----------------200----------------5000--------------------

--Tabelle, F(), Schema
--nur F() nix  Schema, nie Tabelle
alter partition function fzahl() merge  range(100)

select * from ptab where nummer = 117

--Welche Dgruppe wird jetzt eigtl verwendet

CREATE PARTITION FUNCTION [fzahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO

CREATE PARTITION SCHEME [schZahl] AS PARTITION [fzahl] TO
	([bis200], [bis5000], [rest])
GO


select * from ptab where id = 15900
select * from ptab where nummer= 15900

--Archivieren
--TSQL Verschieben von DS.. es gibt kein Befehl
--Archivtabelle muss exakt gleich aussehen
create table archiv(id int not null, nummer int, spx char(4100))on bis200

alter table ptab switch partition 1 to archiv

select * from archiv --DS sind vorhanden
select * from ptab --DS sind weg


--100MB/sek --- P1 1000MB--> Archivierung
--Dauer: ca 0 sek
--es werden keine DAten verschoben , sondern part in Tabelle umbenannt














--Jahresweise
create partition function fzahl(date)
as
RANGE LEFT FOR VALUES ('31.12.2020 23:59:59.999','')

--AbisM    NbisS   TbisZ
create partition function fzahl(date)
as
RANGE LEFT FOR VALUES ('N','T')

---MMa Mai

--Sinn? 15000 HDDS
create partition scheme schZahl
as
Partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])


--Partitionierung ist kombinierbar mit
--Kmpression
--Locks
--Indizes

























