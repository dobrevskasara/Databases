--Релационата база е дефинирана преку следните релации:
--Lice(#id, mbr, ime, prezime, data_r, vozrast, pol)
--Med_lice(#id*, staz)
--Test(#id*, shifra, tip, datum, rezultat, laboratorija)
--Vakcina(#shifra, ime, proizvoditel)
--Vakcinacija(#id_lice*, #id_med_lice*, #shifra_vakcina*)
--Vakcinacija_datum(#id_lice*, #id_med_lice*, #shifra_vakcina*, #datum)

--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него


--Да се напише DML израз со кој ќе се врати информација за тоа колкав процент од лицата кои имале 
--позитивен тест во август 2021 не биле целосно вакцинирани (вакцинирани со две дози вакцина).
--Забелешка: Форматот на датум е 'YYYY-MM-DD'.

with pozitivni as (
    select l.id
    from Lice l
    join Test t on l.id = t.id
    where rezultat = 'pozitiven' and datum like '2021-08%'
),
dozi as (
    select vd.id_lice, count(*) as broj_dozi
    from Vakcinacija_datum vd
    group by id_lice
)
select
    100.0 * count(*) / (select count(*) from pozitivni) as procent
from pozitivni p
left join dozi d on p.id = d.id_lice
where d.broj_dozi IS NULL or d.broj_dozi < 2;