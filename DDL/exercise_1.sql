Релационата база е дефинирана преку следните релации:
Vraboten(#ID, ime, prezime, datum_r, datum_v, obrazovanie, plata)
Shalterski_rabotnik(#ID*)
Klient(#MBR_k, ime, prezime, adresa, datum)
Smetka(#MBR_k_s*, #broj, valuta, saldo)
Transakcija_shalter(#ID, ID_v*, MBR_k*, MBR_k_s*, broj*, datum, suma, tip)
Bankomat(#ID, lokacija, datum_p, zaliha)
Transakcija_bankomat(#ID, MBR_k_s*, broj*, ID_b*, datum, suma).

(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


Да се напишат соодветните DDL изрази за ентитетните множества „ТРАНСАКЦИЈА_ШАЛТЕР“, „ВРАБОТЕН“ 
и „ШАЛТЕРСКИ_РАБОТНИК“, како и за евентуалните релации кои произлегуваат од истите, доколку треба да бидат исполнети следните барања:
Доколку се избрише одреден вработен, информациите за извршените трансакции треба да останат зачувани во базата на податоци.
Датумот на извршување на трансакција не смее да биде во периодот од 30.12.2020 до 14.01.2021.
Типот на трансакцијата може да има една од двете вредности "uplata" или "isplata"
Датумот на раѓање на вработениот мора да биде пред неговиот датум на вработување


Забелешка: Табелите и атрибутите потребно е да ги креирате со ИСТИТЕ ИМИЊА и ИСТИОТ РЕДОСЛЕД како што е дадено во релациониот модел. 
За табелите кои веќе се креирани претпоставете дека примарните клучеви се од тип TEXT. За надворешните клучеви за кои не е наведено 
ограничување за референцијален интегритет се претпоставува каскадно бришење/промена. Конкретните вредности за датум 
дефинирајте ги како стринг (на пример "2021-01-20").


CREATE TABLE Transakcija_shalter (
    ID TEXT PRIMARY KEY,
    ID_v TEXT NULL,
    MBR_k TEXT,
    MBR_k_s TEXT,
    broj TEXT,
    datum TEXT,
    suma INT,
    tip TEXT,

    CHECK (tip IN ('uplata', 'isplata')),
    CHECK (datum < '2020-12-30' OR datum > '2021-01-14'),

    FOREIGN KEY (ID_v)
        REFERENCES Shalterski_rabotnik(ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    FOREIGN KEY (MBR_k)
        REFERENCES Klient(MBR_k)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
        
    FOREIGN KEY (MBR_k_s, broj) 
        REFERENCES Smetka(MBR_k_s, broj) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE

  --FOREIGN KEY (MBR_k_s) 
    --REFERENCES Smetka(MBR_k_s) 
    --ON UPDATE CASCADE 
    --ON DELETE CASCADE

   --FOREIGN KEY (broj) 
   --REFERENCES Smetka(broj) 
   --ON UPDATE CASCADE 
    --ON DELETE CASCADE
);


CREATE TABLE Vraboten (
    ID TEXT PRIMARY KEY,
    ime TEXT,
    prezime TEXT,
    datum_r TEXT,
    datum_v TEXT,
    obrazovanie TEXT,
    plata INT,
    CHECK (datum_r < datum_v)
);


CREATE TABLE Shalterski_rabotnik (
    ID TEXT PRIMARY KEY,
    FOREIGN KEY (ID)
        REFERENCES Vraboten(ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);