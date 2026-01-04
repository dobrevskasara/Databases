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

--Да се напише DML израз со кој ќе се вратат имињата и презимињата на гитаристите (музичарите кои свират на инструментот гитара) кои 
--настапиле на концерт заедно со бенд откако го напуштиле. Датумот на настап на музичарот заедно со бендот е датумот на самиот концерт. 
--Резултатите треба да се подредени според името во растечки редослед. 


select m.ime, m.prezime
from Muzicar m
join Muzicar_instrument mi on m.id = mi.id_muzicar
join Koncert_muzicar_bend kmb on m.id = kmb.id_muzicar 
join Muzicar_bend mb on kmb.id_bend = mb.id_bend and kmb.id_muzicar = mb.id_muzicar
join Koncert k on kmb.id_koncert = k.id
where mi.instrument = 'gitara' 
    and mb.datum_napustanje IS NOT NULL
    and k.datum > mb.datum_napustanje
order by 1