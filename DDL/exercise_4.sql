Релационата база е дефинирана преку следните релации: 
Korisnik(#kor_ime, ime, prezime, pol, data_rag, data_reg)
Korisnik_email(#kor_ime*, #email)
Mesto(#id, ime)
Poseta(#id, kor_ime*, id_mesto*, datum)
Grad(#id_mesto*, drzava)
Objekt(#id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*)
Sosedi(#grad1*, #grad2*, rastojanie)

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


Да се напишат соодветните DDL изрази за ентитетните множества „КОРИСНИК“ и „ПОСЕТА“, како и за евентуалните релации 
кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:
Сакаме да водиме евиденција за посетите на местата од корисниците кои се избришани од системот.
Е-маил адресата завршува на „.com“ и истата треба да содржи најмалку 10 карактери.
Датумот на посета на место не смее да биде пo датумот на внесување на записот во базата.


Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип TEXT. За надворешните клучеви за кои не е наведено 
ограничување за референцијален интегритет се претпоставува каскадна промена/бришење. Конкретните вредности за датум дефинирајте 
ги како стринг (на пример „2023-02-09“). Тековниот датум може да го преземете со DATE().



CREATE TABLE Korisnik(
    kor_ime text,
    ime text, 
    prezime text, 
    pol text, 
    data_rag text, 
    data_reg text,
    primary key (kor_ime)
);


CREATE TABLE Korisnik_email(
    kor_ime text, 
    email text,
    primary key (kor_ime, email),
    foreign key (kor_ime) references Korisnik (kor_ime) on update cascade on delete cascade,
    check (email like '%.com' and length (email)>=10)
);

CREATE TABLE Poseta(
    id text, 
    kor_ime text, 
    id_mesto text, 
    datum text,
    primary key (id),
    foreign key (kor_ime) references Korisnik (kor_ime) on update cascade on delete set null,
    foreign key (id_mesto) references Mesto (id) on update cascade on delete cascade,
    check (datum <= DATE())
   -- CHECK (datum < '2023-02-09')
);

