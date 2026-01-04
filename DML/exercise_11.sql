--Релационата база е дефинирана преку следните релации:
--Korisnik(#k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email)
--Premium_korisnik(#k_ime*, datum, procent_popust)
--Profil(#k_ime*, #ime, datum)
--Video_zapis(#naslov, jazik, vremetraenje, datum_d, datum_p)
--Video_zapis_zanr(#naslov*, #zanr)
--Lista_zelbi(#naslov*, #k_ime*, #ime*)
--Preporaka(#ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него


--Да се напише DML израз со кој ќе се вратат корисничкото име и бројот на видео записи кои му биле 
--препорачани на корисникот кој дал најголем број на препораки.
--Напомена: при оценување на оваа задача нема да се признаваат решенија со користење на ORDER BY.


with Korisnik_prep as (
    select k_ime_od as k_ime 
    from Preporaka
    group by k_ime_od
    having count (*) = (
    select max(max_preporaki) from(
        select count (*) as max_preporaki 
        from Preporaka
        group by k_ime_od
        )
    )
)

select kp.k_ime, count(preporaka.naslov) as dobieni_preporaki
from Korisnik_prep kp
join Preporaka preporaka on preporaka.k_ime_na = kp.k_ime
group by preporaka.k_ime_na