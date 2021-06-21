
--Das Logfile hat VLFs... virtuelle Logfiles.. wir sollten nicht zuviele davon haben


Je nach Wachstumgrˆﬂe besitzen VLFs andere Grˆﬂen.

--pro Logilewachstum

--bis zu 64MB 4 
--64 bis 1000 8
--> 1000 16

50 MB + 50 MB Wachstum sind wieviele VLF bei typischen 10 MB Vergrˆﬂerungen?

dbcc loginfo --undokumentiert!--> keine 1000 VLFs

zu viele Fragemntierung.. langsam beim INsert
zu groﬂe =langsam ..


----------------------------10MB
-- - - - - - - - - - - - - - - 
1MB VLF  10 VLFs

----------------------------100MB
- - - - - - - - - - - - -   10VLFs

--Das Logfile sollte nicht mehr als 1000/3000 VLFs 

------------------------100MB---------------------------200MB
 - - - - - - - - - - - - 10VLFs----------------------20VLFs

 64  1000

 --evtl bei sehr groﬂen DBs mit groﬂen LFiles .. Wachstum auf 1 GB




*/
