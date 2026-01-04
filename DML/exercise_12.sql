--Релационата база е дефинирана преку следните релации:
--Korisnik(#k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email)
--Premium_korisnik(#k_ime*, datum, procent_popust)
--Profil(#k_ime*, #ime, datum)
--Video_zapis(#naslov, jazik, vremetraenje, datum_d, datum_p)
--Video_zapis_zanr(#naslov*, #zanr)
--Lista_zelbi(#naslov*, #k_ime*, #ime*)
--Preporaka(#ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него


--Да се напише DML израз со кој за секој корисник ќе се врати видео записот кој го препорачал најголем број пати.


select k.k_ime, p.naslov, count(p.naslov) as broj
from Korisnik k
join Preporaka p on  p.k_ime_od = k.k_ime
group by k.k_ime, p.naslov
having count (*) = (
    select max(numPreporaki) as brojPrep from(
        select count(*) as numPreporaki    
        from Preporaka p2 
        where p2.k_ime_od = k.k_ime
        group by p2.naslov
    )
)
order by k.k_ime