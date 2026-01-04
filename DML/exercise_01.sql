--Релационата база е дефинирана преку следните релации:
--Lice(#id, mbr, ime, prezime, data_r, vozrast, pol)
--Med_lice(#id*, staz)
--Test(#id*, #shifra, tip, datum, rezultat, laboratorija)
--Vakcina(#shifra, ime, proizvoditel)
--Vakcinacija(#id_lice*, #id_med_lice*, #shifra_vakcina*)
--Vakcinacija_datum(#id_lice*, #id_med_lice*, #shifra_vakcina*, #datum)

--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него

--Да се напише DML израз со кој ќе се вратат матичните броеви на лицата (сортирани во растечки редослед) кои биле позитивни и потоа примиле барем една доза вакцина.


select distinct l.id
from Lice l
join Test t on l.id = t.id
join Vakcinacija_datum vd on l.id = vd.id_lice
where rezultat = 'pozitiven' and t.datum < vd.datum
order by 1