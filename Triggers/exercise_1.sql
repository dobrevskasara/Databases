--Релационата база е дефинирана преку следните релации:
--Lice(#id, mbr, ime, prezime, data_r, vozrast, pol)
--Med_lice(#id*, staz)
--Test(#id*, #shifra, tip, datum, rezultat, laboratorija)
--Vakcina(#shifra, ime, proizvoditel)
--Vakcinacija(#id_lice*, #id_med_lice*, #shifra_vakcina*)
--Vakcinacija_datum(#id_lice*, #id_med_lice*, #shifra_vakcina*, #datum)

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


--Во табелата Lice е креиран изведен атрибут „celosno_imuniziran“ кој прима вредности 0 и 1 и кажува дали лицето е целосно имунизирано 
--(вакцинирано со барем две дози вакцина). Дополнително, пресметана е моменталната вредност на овој атрибут за секое лице.

--Да се напише/ат тригер/и за одржување на вредноста на атрибутот „celosno_imuniziran“ при додавање на записите од кои зависи неговата вредност.


create trigger trg_update_imunizacija
after insert on Vakcinacija
for each row
begin
    update Lice
    set celosno_imuniziran = (
        select case
            when count(*) > 2 then 1
            else 0
        end
        from Vakcinacija
        where id_lice = new.id_lice)
    where id_lice = new.id_lice;
end;

create trigger trg_update_datum
after insert on Vakcinacija_datum
for each row
begin
    update Lice
    set celosno_imuniziran = (
        select case
            when count (*) >= 2 then 1
            else 0
            end
        from Vakcinacija_datum
        where id_lice = new.id_lice)
    where id = new.id_lice;
end;