--Релационата база е дефинирана преку следните релации: 
--Korisnik(#kor_ime, ime, prezime, pol, data_rag, data_reg)
--Korisnik_email(#kor_ime*, #email)
--Mesto(#id, ime)
--Poseta(#kor_ime*, #id_mesto*, #datum)
--Grad(#id_mesto*, drzava)
--Objekt(#id_mesto*, adresa, geo_shirina, geo_dolzina, id_grad*)
--Sosedi(#grad1*, #grad2*, rastojanie)


--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него

--Да се напише DML израз со кој ќе се вртат имињата на објектите кои се наоѓаат во градот што бил посетен најголем број пати. 
--За посети на градови се сметаат посетите на места што претставуваат градови. Во ова не се вклучени посетите на објекти во тие градови.


with numVisits as(
    select m.id
    from Mesto m
    join Grad g on g.id_mesto = m.id
    join Poseta p on p.id_mesto = g.id_mesto
    join Objekt o on o.id_grad = g.id_mesto
    group by m.id, g.id_mesto
    having count (*) = (
        select max (visits) from (
            select count (*) as visits 
            from Mesto m
            join Grad g on g.id_mesto = m.id
            join Poseta p on p.id_mesto = g.id_mesto
            join Objekt o on o.id_grad = g.id_mesto
            group by g.id_mesto
        )
    )
)

select distinct mesto.ime
from Objekt objekt
join Mesto mesto on mesto.id = objekt.id_mesto
join numVisits grad on objekt.id_grad = grad.id
order by mesto.id