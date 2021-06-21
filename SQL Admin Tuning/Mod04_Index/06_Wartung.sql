/*

Was ist zu tun.. Indizes beeiflussen SQL Server in 
IO, LOCKS, RAM, CPU ..positiv wie negativ

Optimierung durch :

fehlende Indizes auffinden

abdeckende Indizes (ideale Indizes) finden.. ohne Lookup nur Seek

überflüssige  Indizes entfernen

fragmentierte Indizes defrgamentieren

Statistiken müssen stimmen.. aktuelleste Stat
autom. Update: nach 20% Änderungen+500+Abfrage auf Spalte

täglich.. !!!
--rechnet mit sehr großem Aufwand Aufwand


Wartung der Indizes mit großem aufwand verbunden
200MB Heap + 1GR IX + 2 NG IX-- 363MB

Rebuild offline online mit temdb ohne tempdb

Online mit : 1100MB
Offline ohne: 860MB

https://docs.microsoft.com/de-de/sql/relational-databases/indexes/index-disk-space-example?view=sql-server-ver15


Wartungplan: Defragementieren und Stat aktualisieren...
		ab SQL 2016 

ab 10% Reorg..nur Blattebene nicht der Baum
ab 30% Rebuild Blatteben und Baum
sonst: nix

use master

--Scripte für schelchte Indizes
--Brent Ozar   sp_blitzIndex

--Script für Wartung
--Ola Hallengren (für SQL 2014 und früher oder SQL Express)



--fehlende Index
*/
select * from sys.dm_db_index_usage_stats where database_id= DB_ID()

select * from sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('ku2'),NULL,NULL, 'detailed')



*/

select * into ku4 from ku2

select * from ku4 where id= 100

select * from ku4 where city = 'Berlin'