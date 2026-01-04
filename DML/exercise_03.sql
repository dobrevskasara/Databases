--Релационата база е дефинирана преку следните релации: 
--Korisnik(#kor_ime, ime, prezime, pol, data_rag, data_reg)
--Korisnik_email(#kor_ime*, #email)
--Mesto(#id, ime)
--Poseta(#kor_ime*, #id_mesto*, #datum)
--Grad(#id_mesto*, drzava)
--Objekt(#id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*)
--Sosedi(#grad1*, #grad2*, rastojanie)

--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него


--Да се напише DML израз со кој ќе се вратат името и презимето на корисниците кои во ист ден посетиле објекти кои се наоѓаат во соседни градови. 


select distinct k.ime, k.prezime
from Korisnik k 
join Poseta p1 on k.kor_ime = p1.kor_ime
join Poseta p2 on k.kor_ime = p2.kor_ime
    and p1.datum = p2.datum
    and p1.id_mesto != p2.id_mesto
join Objekt o1 on o1.id_mesto = p1.id_mesto
join Objekt o2 on o2.id_mesto = p2.id_mesto
join Sosedi s on (
    (s.grad1 = o1.id_grad and s.grad2 = o2.id_grad) or
    (s.grad1 = o2.id_grad and s.grad2 = o1.id_grad)
);