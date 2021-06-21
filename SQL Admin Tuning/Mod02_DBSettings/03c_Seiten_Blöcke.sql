


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
