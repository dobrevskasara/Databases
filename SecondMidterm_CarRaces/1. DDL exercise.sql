Релационата база е дефинирана преку следните релации: 
Pateka(#ime, grad, drzava, dolzina, tip)
Trka(#ime, krugovi, pateka*)
Odrzana_trka(#ime*, #datum, vreme)
Vozac(#vozacki_broj, ime, prezime, nacionalnost, datum_r)
Tim(#ime, direktor)
Sponzori(#ime*, sponzor)
Vozi_za(#vozacki_broj*, #ime_tim*, #datum_pocetok, datum_kraj)
Ucestvuva(#ID, vozacki_broj*, ime_tim*, ime_trka*, datum_trka*, pocetna_p, krajna_p, poeni)

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


Да се напишат соодветните DDL изрази за ентитетните множества „TРКА“, „ОДРЖАНА_ТРКА“ и „УЧЕСТВУВА“, како и за 
евентуалните релации кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:
Сакаме да водиме евиденција за учествата на трки од возачи кои се избришани од системот, но не сакаме да водиме евиденција за 
учествата на трки од тимови кои се избришани од системот.
Само возачите кои ја завршиле трката на првите 10 позиции добиваат поени (останатите добиваат 0 поени). 
Трката не смее да има повеќе од 80 кругови.


Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип TEXT. За надворешните клучеви за кои не е наведено 
ограничување за референцијален интегритет се претпоставува каскадна промена/бришење. Конкретните вредности за датум дефинирајте ги 
како стринг во формат 'YYYY-MM-DD' (на пример "2024-02-08").



CREATE TABLE Trka(
    ime text, 
    krugovi int, 
    pateka text,
    primary key (ime),
    foreign key (pateka) references Pateka (ime) on update cascade on delete cascade,
    check (krugovi<= 80)
);

CREATE TABLE Odrzana_trka(
    ime text, 
    datum text, 
    vreme text, 
    primary key (ime, datum),
    foreign key (ime) references Trka (ime) on update cascade on delete cascade
);

CREATE TABLE Ucestvuva(
    ID text, 
    vozacki_broj text, 
    ime_tim text, 
    ime_trka text, 
    datum_trka text, 
    pocetna_p int, 
    krajna_p int, 
    poeni float,
    primary key (ID),
    foreign key (vozacki_broj) references Vozac(vozacki_broj) on update cascade on delete set null,
    foreign key (ime_tim) references Tim(ime) on update cascade on delete cascade,
    foreign key (ime_trka, datum_trka) references Odrzana_trka(ime, datum) on update cascade on delete cascade,
    --check (krajna_p <=10 or poeni=0.0)
     CHECK ((krajna_p <= 10 AND poeni != 0.0) OR (krajna_p > 10 AND poeni = 0.0))
);