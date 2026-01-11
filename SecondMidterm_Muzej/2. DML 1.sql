--Релационата база е дефинирана преку следните релации: 
--Muzej(#shifra, ime_muzej, opis, grad, tip, rabotno_vreme)
--Izlozba(#ime_i, opis, sprat, prostorija, datum_od, datum_do, shifra_muzej*)
--Izlozba_TD(#ime_i*) 
--Izlozba_TD_ime(#ime_i*, #ime_td)
--Izlozba_UD(#ime_i*)
--Umetnicko_delo(#shifra, ime, godina, umetnik)
--Izlozeni(#shifra_d*, #ime_i*, datum_pocetok, datum_kraj)

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


--Да се напише DML израз со кој ќе се вратат имињата на уметничките дела заедно со нивните креатори (уметници) 
--кои биле изложени на барем една изложба во целото времетраење на истата подредени според името на уметничкото дело. \

select ud.ime, ud.umetnik
from Umetnicko_delo ud
join Izlozeni i on i.shifra_d = ud.shifra
join Izlozba iz on iz.ime_i = i.ime_i
where datum_pocetok = datum_od and datum_kraj = datum_do
order by 1