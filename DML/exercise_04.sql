--Релационата база е дефинирана преку следните релации: 
--Korisnik(#kor_ime, ime, prezime, pol, data_rag, data_reg)
--Korisnik_email(#kor_ime*, #email)
--Mesto(#id, ime)
--Poseta(#kor_ime*, #id_mesto*, #datum)
--Grad(#id_mesto*, drzava)
--Objekt(#id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*)
--Sosedi(#grad1*, #grad2*, rastojanie)

--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него

--Да се напише DML израз со кој ќе се вратат името и презимето на корисниците кои посетиле објекти кои се наоѓаат 
--во соседни градови чие растојание е помало од 300 km.


select distinct k.ime, k.prezime
from Korisnik k
join Poseta p1 on k.kor_ime = p1.kor_ime
join Poseta p2 on k.kor_ime = p2.kor_ime
join Objekt o1 on p1.id_mesto = o1.id_mesto
join Objekt o2 on p2.id_mesto = o2.id_mesto
join Sosedi s on ((s.grad1 = o1.id_grad AND s.grad2 = o2.id_grad) OR
    (s.grad1 = o2.id_grad AND s.grad2 = o1.id_grad))
where rastojanie < 300