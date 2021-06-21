select * from sys.dm_os_wait_stats

--1070 Ressourcen

--Abfrage--> Queue --> Worker > Ressourcen? --> Ressource! --> CPU? -->CPU!


--0--------------50ms----70ms! Abfrage läuft

--wait_time: 70ms
--signal_time : Wartezeit auf CPU
--Warten auf Ressource: 70ms -signal-- Wartezeit auf Ressource
--Werte sind kummulierend seit Neustart
--für exakte Zeitangabe : regelm. os_wait_stats in Tabellen wegschreiben

--10:00 LCK_M_S 100
--10:10         110
--10:20         230
