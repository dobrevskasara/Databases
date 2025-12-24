Релационата база е дефинирана преку следните релации:
Korisnik(#k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email)
Premium_korisnik(#k_ime*, datum, procent_popust)
Profil(#k_ime*, #ime, datum)
Video_zapis(#naslov, jazik, vremetraenje, datum_d, datum_p)
Video_zapis_zanr(#naslov*, #zanr)
Lista_zelbi(#naslov*, #k_ime*, #ime*)
Preporaka(#ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


Да се напишат соодветните DDL изрази за ентитетните множества „ЛИСТА_ЖЕЛБИ“, „КОРИСНИК“ и „ПРЕМИУМ_КОРИСНИК“, како и за 
евентуалните релации кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:
Доколку не се внесе процентот на попуст за премиум корисник, тогаш сакаме да се додели предодредена вредност 10.
Сакаме да водиме евиденција во листите на желби за видео записите кои се избришани од системот.
Корисниците регистрирани пред 01.01.2015 не може да бидат претплатени на „pretplata 3“.


Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип TEXT. За надворешните клучеви за кои не е наведено 
ограничување за референцијален интегритет се претпоставува каскадна промена/бришење. Конкретните вредности за датум дефинирајте ги 
како стринг (на пример "2022-01-17"). За пристап до тековниот датум може да користите CURRENT_DATE.



CREATE TABLE Lista_zelbi(
    ID text primary key, 
    naslov text, 
    k_ime text, 
    ime,
    foreign key (naslov) references Video_zapis(naslov) on update cascade on delete set null,
    foreign key (k_ime, ime) references Profil (k_ime, ime) on update cascade on delete cascade
);

CREATE TABLE Korisnik(
    k_ime text, 
    ime text, 
    prezime text, 
    tip text, 
    pretplata text, 
    datum_reg text, 
    tel_broj text, 
    email text,
    primary key (k_ime),
    check (datum_reg >= '2015-01-01' or pretplata !='pretplata 3')
);

CREATE TABLE Premium_korisnik(
    k_ime text primary key, 
    datum text, 
    procent_popust int DEFAULT 10,
    foreign key (k_ime) references Korisnik (k_ime) on update cascade on delete cascade
);
