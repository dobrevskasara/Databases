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


--Да се напише DML израз со кој ќе се вратат сите парови на бендови (пар од имињата на бендовите) кои се основани во иста година. 


select b1.ime as B1, b2.ime as B2
from Bend b1
join Bend b2 on b1.ime > b2.ime and b1.godina_osnovanje = b2.godina_osnovanje
where b1.godina_osnovanje = b2.godina_osnovanje
order by b1.id, b2.id

