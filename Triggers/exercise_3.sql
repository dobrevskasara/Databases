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

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


--За секој музичар се чува изведен атрибут „br_bendovi“ кој го означува бројот на бендови во кои свири тој музичар.

--Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутот „br_bendovi“ при зачленување во бенд.


create trigger trg_num_bends
after insert on Muzicar_bend
for each row
begin
    update Muzicar
    set br_bendovi = (
        select count(*)
        from Muzicar_bend
        where id_muzicar = new.id_muzicar)
    where id = new.id_muzicar;
end;