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


Да се напише DML израз со кој за секоја трка ќе се врати возачот кој има најмногу победи на таа трка.


select u.ime_trka as race, u.vozacki_broj as driver
from Odrzana_trka ot
join Ucestvuva u on u.ime_trka = ot.ime and u.datum_trka = ot.datum
where u.krajna_p = 1
group by ot.ime, u.vozacki_broj 
having count (*) = (
    select max(winners) from (
        select count (*) as winners 
        from Ucestvuva u2
        where u2.krajna_p = 1 and u2.ime_trka = u.ime_trka
        group by u2.vozacki_broj
    )
)