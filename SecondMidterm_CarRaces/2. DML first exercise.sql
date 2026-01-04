Релационата база е дефинирана преку следните релации: 
Pateka(#ime, grad, drzava, dolzina, tip)
Trka(#ime, krugovi, pateka*)
Odrzana_trka(#ime*, #datum, vreme)
Vozac(#vozacki_broj, ime, prezime, nacionalnost, datum_r)
Tim(#ime, direktor)
Sponzori(#ime*, sponzor)
Vozi_za(#vozacki_broj*, #ime_tim*, #datum_pocetok, datum_kraj)
Ucestvuva(#ID, vozacki_broj*, ime_tim*, ime_trka*, datum_trka*, pocetna_p, krajna_p, poeni)

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)



Да се напише DML израз со кој ќе се вратат информациите за возачите кои во 2023 година освоиле (еден или повеќе) 
поени на одржани трки со помалку од 70 кругови подредени според датумот на раѓање по опаѓачки редослед.
 

select distinct v.vozacki_broj, v.ime, v.prezime, v.nacionalnost, v.datum_r
from Vozac v
join Ucestvuva u on u.vozacki_broj = v.vozacki_broj
join Trka t on t.ime = u.ime_trka
where datum_trka like '2023%' and krugovi<70 and poeni>0
order by datum_r desc