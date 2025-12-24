Релационата база е дефинирана преку следните релации: 
Muzicar(#id, ime, prezime, datum_ragjanje)
Muzicar_instrument(#id_muzicar*, #instrument)
Bend(#id, ime, godina_osnovanje)
Bend_zanr(#id_bend*, #zanr)
Nastan(#id, cena, kapacitet)
Koncert(#id*, datum, vreme)
Festival(#id*, ime)
Festival_odrzuvanje(#id*, #datum_od, datum_do)
Muzicar_bend(#id_muzicar*, #id_bend*, datum_napustanje)
Festival_bend(#id_festival*, #datum_od*, #id_bend*)
Koncert_muzicar_bend(#id_koncert*, #id_muzicar*, #id_bend*)

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)

Да се напишат соодветните DDL изрази за ентитетните множества „БЕНД“ и „ФЕСТИВАЛ_БЕНД“, како и за евентуалните релации 
кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:
Бендот со шифра (id или id_bend) 5 не може да настапува на фестивалот со шифра (id_festival) 2.
Сакаме да водиме евиденција за настапите на фестивали за бендови што се бришат од системот.
Се чуваат податоци само за бендови кои се основани во 1970 или подоцна.

Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип TEXT. За надворешните клучеви за кои не е наведено 
ограничување за референцијален интегритет се претпоставува каскадна промена/бришење. Конкретните вредности за датум 
дефинирајте ги како стринг (на пример "2022-06-14").



CREATE TABLE Bend(
    id text, 
    ime text, 
    godina_osnovanje text,
    primary key (id),
    check (godina_osnovanje >= 1970)
);

CREATE TABLE Bend_zanr(
    id_bend text, 
    zanr text,
    primary key (id_bend, zanr),
    foreign key (id_bend) references Bend (id) on update cascade on delete cascade
);

CREATE TABLE Festival_bend(
    id_festival text, 
    datum_od date, 
    id_bend text,
    primary key (id_festival, datum_od, id_bend),
    foreign key (id_festival, datum_od) references Festival_odrzuvanje(id, datum_od) on update cascade on delete cascade,
    foreign key (id_bend) references Bend (id) on update cascade on delete set default,
    check (id_bend != 5 or id_festival != 2)
);