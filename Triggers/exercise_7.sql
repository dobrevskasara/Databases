--Релационата база е дефинирана преку следните релации:
--Korisnik(#k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email)
--Premium_korisnik(#k_ime*, datum, procent_popust)
--Profil(#k_ime*, ime, datum)
--Video_zapis(#naslov, jazik, vremetraenje, datum_d, datum_p)
--Video_zapis_zanr(#naslov*, #zanr)
--Lista_zelbi(#ID, naslov*, k_ime*, ime*)
--Preporaka(#ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)


--За секој видео запис се чува изведен атрибут „prosechna_ocena“ кој ја означува просечната оцена добиена од препораки. 
--Дополнително, пресметана е моменталната вредност на овој атрибут за секој видео запис.

--Да се напише/ат соодветниот/те тригер/и за одржување на конзистентноста на атрибутот „prosechna_ocena“ при додавање на записите од кои зависи неговата вредност.

create trigger trg_insert_prosechna_ocena
after insert on Preporaka
for each row
begin
    update Video_zapis
    set prosechna_ocena =(
        select avg(ocena) from Preporaka
        where naslov = new.naslov
    )
    where naslov = new.naslov;
end;