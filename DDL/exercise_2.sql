Релационата база е дефинирана преку следните релации:
Lice(#id, mbr, ime, prezime, data_r, vozrast, pol)
Med_lice(#id*, staz)
Test(#id*, #shifra, tip, datum, rezultat, laboratorija)
Vakcina(#shifra, ime, proizvoditel)
Vakcinacija(#id_lice*, #id_med_lice*, #shifra_vakcina*)
Vakcinacija_datum(#id_lice*, #id_med_lice*, #shifra_vakcina*, #datum)

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


Да се напишат соодветните DDL изрази за ентитетните множества „ВАКЦИНАЦИЈА“ и „ТЕСТ“, како и за евентуалните релации кои произлегуваат од 
истите, доколку треба да бидат исполнети следните барања:
Mедицинските лица не може себеси да си даваат вакцина.
Лабораторијата „lab-abc“ прави само „seroloshki“ тестови.
Не сакаме да водиме информации за тестовите на лицата кои се избришани од базата на податоци.


Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип INT. За надворешните клучеви за кои не е 
наведено ограничување за референцијален интегритет се претпоставува каскадна промена, додека при бришење информациите треба да останат 
зачувани во базата на податоци. Конкретните вредности за датум дефинирајте ги како стринг (на пример "2021-08-25").



CREATE TABLE Vakcinacija(
    id_lice int, 
    id_med_lice int, 
    shifra_vakcina int,
    primary key (id_lice, id_med_lice, shifra_vakcina),
    foreign key (id_lice) references Lice (id) on update cascade on delete SET DEFAULT, 
    foreign key (id_med_lice) references Med_lice (id) on update cascade on delete SET DEFAULT,
    foreign key (shifra_vakcina) references Vakcina (shifra) on update cascade on delete SET DEFAULT,
    check (id_lice != id_med_lice)
);

CREATE TABLE Vakcinacija_Datum(
    id_lice int, 
    id_med_lice int, 
    shifra_vakcina int, 
    datum date,
    primary key (id_lice, id_med_lice, shifra_vakcina, datum),
    foreign key (id_lice, id_med_lice, shifra_vakcina) references Vakcinacija (id_lice, id_med_lice, shifra_vakcina) 
    on update cascade on delete set null
    --foreign key (id_lice) references Lice (id) on update cascade on delete set null, 
    --foreign key (id_med_lice) references Med_lice (id) on update cascade on delete set null,
    --foreign key (shifra_vakcina) references Vakcina (shifra) on update cascade on delete set null
);


CREATE TABLE Test(
    id int, 
    shifra int, 
    tip text, 
    datum date, 
    rezultat text, 
    laboratorija text,
    primary key (id, shifra),
    foreign key (id) references Lice (id) on update cascade on delete cascade,
    check (laboratorija != 'lab-abc' or tip = 'seroloshki')
);