--Релационата база е дефинирана преку следните релации: 
--Muzej(#shifra, ime_muzej, opis, grad, tip, rabotno_vreme)
--Izlozba(#ime_i, opis, sprat, prostorija, datum_od, datum_do, shifra_muzej*)
--Izlozba_TD(#ime_i*) 
--Izlozba_TD_ime(#ime_i*, #ime_td)
--Izlozba_UD(#ime_i*)
--Umetnicko_delo(#shifra, ime, godina, umetnik)
--Izlozeni(#shifra_d*, #ime_i*, datum_pocetok, datum_kraj)

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


--Да се напишат соодветните DDL изрази за ентитетните множества „МУЗЕЈ“, „УМЕТНИЧКО_ДЕЛО“ и „ИЗЛОЖЕНИ“, како и за евентуалните релации 
--кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:
--Не сакаме да водиме информации за делата кои биле изложени на изложби кои се избришани од системот.
--Типот на музејот може да има една од двете вредности, „otvoreno“ или „zatvoreno“.
--Шифрата на музеите на отворено секогаш почнува со „о“.

--Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
--За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип TEXT. За надворешните клучеви за кои не е наведено 
--ограничување за референцијален интегритет се претпоставува каскадна промена/бришење. Конкретните вредности за датум дефинирајте ги како стринг (на пример "2022-06-14").

create table Muzej(
    shifra text, 
    ime_muzej text, 
    opis text, 
    grad text, 
    tip text, 
    rabotno_vreme text,
    primary key (shifra),
    check (tip in ('zatvoreno', 'otvoreno')),
   -- check (shifra like 'o%' or tip='zatvoreno')
   check (tip='zatvoreno' or (tip='otvoreno' and shifra like 'o%'))
);

create table Umetnicko_delo(
    shifra text primary key, 
    ime text, 
    godina text, 
    umetnik text
);

create table Izlozeni(
    shifra_d text, 
    ime_i text, 
    datum_pocetok text, 
    datum_kraj text,
    primary key (shifra_d, ime_i),
    foreign key (shifra_d) references Umetnicko_delo (shifra) on update cascade on delete cascade,
    foreign key (ime_i) references Izlozba_UD (ime_i) on update cascade on delete cascade
);