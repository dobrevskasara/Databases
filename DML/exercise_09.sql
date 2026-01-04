--Релационата база е дефинирана преку следните релации: 
--Korisnik(#kor_ime, ime, prezime, pol, data_rag, data_reg)
--Korisnik_email(#kor_ime*, #email)
--Mesto(#id, ime)
--Poseta(#kor_ime*, #id_mesto*, #datum)
--Grad(#id_mesto*, drzava)
--Objekt(#id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*)
--Sosedi(#grad1*, #grad2*, rastojanie)


--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него


--Да се напише DML израз со кој ќе се врати името на градот во кој се наоѓа објектот што бил посетен најголем број пати.


select m.ime
from Mesto m
join Grad g on g.id_mesto = m.id
join Objekt o on o.id_grad = g.id_mesto
join Poseta p on p.id_mesto = o.id_mesto
group by m.ime, m.id
having count(*) = (
    select max (num) from (
        select COUNT(*) as num 
        from Poseta p2
        join Objekt o2 on o2.id_mesto = p2.id_mesto
        group by o2.id_grad
    )
)