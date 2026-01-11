--Релационата база е дефинирана преку следните релации: 
--Muzej(#shifra, ime_muzej, opis, grad, tip, rabotno_vreme)
--Izlozba(#ime_i, opis, sprat, prostorija, datum_od, datum_do, shifra_muzej*)
--Izlozba_TD(#ime_i*) 
--Izlozba_TD_ime(#ime_i*, #ime_td)
--Izlozba_UD(#ime_i*)
--Umetnicko_delo(#shifra, ime, godina, umetnik)
--Izlozeni(#shifra_d*, #ime_i*, datum_pocetok, datum_kraj)

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


--Да се напише DML израз со кој ќе се врати името на музејот кој имал најмногу изложени различни уметнички дела во 2023 година 
--(уметничките дела кај кои почетниот датум на изложување на некоја изложба на уметнички дела е во 2023 година). 

with numMuzejMax as (
    select m.shifra, count(distinct iz.shifra_d) as temp
    from Muzej m
    join Izlozba i on i.shifra_muzej = m.shifra
    join Izlozeni iz on iz.ime_i = i.ime_i
    join Umetnicko_delo ud on ud.shifra = iz.shifra_d
    where datum_pocetok like '2023%'
),

maximum as (
    select max(temp) as maxMuz
    from numMuzejMax
)


select ime_muzej
from numMuzejMax nmm
join maximum mx on nmm.temp = mx.maxMuz
join Muzej m on nmm.shifra = m.shifra