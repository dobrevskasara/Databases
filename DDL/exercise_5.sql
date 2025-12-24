Релационата база е дефинирана преку следните релации:
Korisnik(#k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email)
Premium_korisnik(#k_ime*, datum, procent_popust)
Profil(#k_ime*, #ime, datum)
Video_zapis(#naslov, jazik, vremetraenje, datum_d, datum_p)
Video_zapis_zanr(#naslov*, #zanr)
Lista_zelbi(#naslov*, #k_ime*, #ime*)
Preporaka(#ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


Да се напишат соодветните DDL изрази за ентитетните множества „ВИДЕО ЗАПИС“ и „ПРЕПОРАКА“, како и за евентуалните релации кои 
произлегуваат од истите, доколку треба да бидат исполнети следните барања:
Сакаме да водиме евиденција за препорачаните видео записи од корисници кои се избришани од системот.
Корисникот не може себе да си препорача видео запис.
Датумот на препорака не може да биде во иднина (т.е. не смее да биде по тековниот датум).


Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип TEXT. За надворешните клучеви за кои не е наведено 
ограничување за референцијален интегритет се претпоставува каскадна промена/бришење. Конкретните вредности за датум дефинирајте ги 
како стринг (на пример "2022-01-17"). За пристап до тековниот датум може да користите CURRENT_DATE.



CREATE TABLE Video_zapis(
    naslov text, 
    jazik text, 
    vremetraenje text, 
    datum_d text, 
    datum_p text,
    primary key (naslov)
);

CREATE TABLE Video_zapis_zanr(
    naslov text, 
    zanr text,
    primary key (naslov, zanr),
    foreign key (naslov) references Video_zapis (naslov) on update cascade on delete cascade
);

CREATE TABLE Preporaka(
    ID text, 
    k_ime_od text, 
    k_ime_na text, 
    naslov text, 
    datum date, 
    komentar text, 
    ocena text, 
    primary key (ID),
    foreign key (k_ime_od) references Korisnik (k_ime) on update cascade on delete set null,
    foreign key (k_ime_na) references Korisnik (k_ime) on update cascade on delete cascade,
    foreign key (naslov) references Video_zapis (naslov) on update cascade on delete cascade,
    check (k_ime_od != k_ime_na),
    check (datum <= CURRENT_DATE)
   -- check (datum < '2025-12-20')
);
