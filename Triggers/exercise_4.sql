--Релационата база е дефинирана преку следните релации: 
--Korisnik(#kor_ime, ime, prezime, pol, data_rag, data_reg)
--Korisnik_email(#kor_ime*, #email)
--Mesto(#id, ime)
--Poseta(#id, kor_ime*, id_mesto*, datum)
--Grad(#id_mesto*, drzava)
--Objekt(#id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*)
--Sosedi(#grad1*, #grad2*, rastojanie)

--(Примарните клучеви (primary) се означени со # пред него, додека па надворешните (foreign клучевите) се означени со * по него)

--Да се напише/ат соодветниот/те тригер/и за одржување на референцијалниот интегритет на релациите „СОСЕДИ“ и „ПОСЕТА“ доколку треба да се исполнети следните барања:

--Сакаме да водиме евиденција за соседните градови на град кој е избришан од системот.
--Не сакаме да водиме евиденција за посетите на места на корисници кои се избришани од системот.


create trigger trg_delete_sosedi
after delete on Grad
for each row
begin
    update Sosedi
    set grad1 = null
    where grad1 = old.id_mesto;
    
    update Sosedi
    set grad2 = null
    where grad2 = old.id_mesto;
end;

create trigger trg_delete_korisnik
after delete on Korisnik
for each row
begin
    delete from Poseta
    where kor_ime = old.kor_ime;
end;