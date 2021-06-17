/*
Volumewartungstask

100MB Vergrößerung = 200MB

Lokale Sicherheitsrichtlinie

----------------------------------
xxxxxxxxxxxxxxxxxxxxxxxlkjlfjdslk
----------------------------------


--Einem guten Admin rel egal.. ;-)

Weil DB (so gut wie) nie vergrößern


Verzeichnisse der DB:

Verz für Log und Daten.. weil ds Schreiben soll das Lesen nicht hinder und vice versa
Trenne Daten von Log physikalisch  pro DB 



TEMPDB
#tab ##tab
Zeilenversionierung
IX Wartung
Auslagerungen


Eig Datenträger ... evtl pro Daten und Logfile

Soviele Datendateien wie Kerne

T1117  alle DAteien werden immer gleich große

T1118  Uniform Extents - Vermeiden von Öatches (int Sperren weil Single Thread auf Seiten/Blöcke)

Nie manuell eine Datei vergrößern
---------------------

MAXDOP 8

Anzahl der Kerne, die pro Abfrage max. zur Verfügung stehen
MAX ist 8


Arbeitsspeicher (Datenpuffer: Datenseiten und Plancache)
MIN:  wird erst umegsetzt wenn erreicht wurde. Wie könnte man den Min Wert rausfinden: Taskmanager Max Arbeitssatz
MAX:  Das OS braucht: 2 bis 4 GB wird sofort umgesetzt






*/