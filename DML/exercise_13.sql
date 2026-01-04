--Релационата база е дефинирана преку следните релации: 
--Muzicar(#id, ime, prezime, datum_ragjanje)
--Muzicar_instrument(#id_muzicar*, #instrument)
--Bend(#id, ime, godina_osnovanje)
--Bend_zanr(#id_bend*, #zanr)
--Nastan(#id, cena, kapacitet)
--Koncert(#id*, datum, vreme)
--Festival(#id*, ime)
--Festival_odrzuvanje(#id*, #datum_od, datum_do)
--Muzicar_bend(#id_muzicar*, #id_bend*, datum_napustanje)
--Festival_bend(#id_festival*, #datum_od*, #id_bend*)
--Koncert_muzicar_bend(#id_koncert*, #id_muzicar*, #id_bend*)


--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него


--Да се напише DML израз со кој за секој фестивал ќе се врати името, цената на билетите, капацитетот на посетители, 
--бројот на одржувања и вкупниот број на различни бендови кои настапиле. 

with Festival_tabela as(
    select fo.id as id, 
    count (distinct fo.datum_od) as broj_odrzuvanja, 
    count(distinct fb.id_bend) as broj_bendovi
    from Festival_odrzuvanje fo
    join Festival_bend fb on fo.id = fb.id_festival 
    and fo.datum_od = fb.datum_od
    group by fo.id
)

select f.ime, n.cena, n.kapacitet, ft.broj_odrzuvanja, ft.broj_bendovi
from Festival f
join Nastan n on n.id = f.id
join Festival_tabela ft on ft.id = f.id