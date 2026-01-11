--Релационата база е дефинирана преку следните релации:
--Lice(#id, mbr, ime, prezime, data_r, vozrast, pol)
--Med_lice(#id*, staz)
--Test(#id*, #shifra, tip, datum, rezultat, laboratorija)
--Vakcina(#shifra, ime, proizvoditel)
--Vakcinacija(#id_lice*, #id_med_lice*, #shifra_vakcina*)
--Vakcinacija_datum(#id_lice*, #id_med_lice*, #shifra_vakcina*, #datum)

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


--За секое лице дополнително се чува изведен атрибут „vakcinalen_status“ кој го покажува моменталниот статус за вакцините на даденото лице. 
--Атрибутот vakcinalen_status може да ги прима следните вредности: 'nema vakcina', 'primena prva doza', 'primeni dve dozi'. 
--На почеток сите лица имаат vakcinalen_status='nema vakcina'. Статусот на дадено лице станува 'primena prva doza' кога лицето ќе прими прва доза од некоја вакцина. 
--Статусот на дадено лице станува 'primeni dve dozi' кога лицето ќе ја прими втората доза од вакцината.

--Да се напише/ат тригер/и за одржување на вредноста на атрибутот „vakcinalen_status“ при додавање на нови записи од кои зависи неговата вредност.


create trigger trg_update_status
after insert on Vakcinacija
for each row
begin
    update Lice
    set vakcinalen_status = (
        select case 
            when count(*) = 0 then 'nema vakcina'
            when count(*) = 1 then 'primena prva doza'
            when count (*) = 2 then 'primeni dve dozi'
        end
        from Vakcinacija
        where id_lice = new.id_lice
    )
    where id = new.id_lice;
end;

create trigger trg_update_status_datum
after insert on Vakcinacija_datum
for each row
begin
    update Lice
    set vakcinalen_status = (
        select case 
            when count(*) = 0 then 'nema vakcina'
            when count(*) = 1 then 'primena prva doza'
            when count (*) = 2 then 'primeni dve dozi'
        end
        from Vakcinacija_datum
        where id_lice = new.id_lice
    )
    where id = new.id_lice;
end;