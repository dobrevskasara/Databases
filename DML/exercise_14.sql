--Релационата база е дефинирана преку следните релации:
--Korisnik(#k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email)
--Premium_korisnik(#k_ime*, datum, procent_popust)
--Profil(#k_ime*, #ime, datum)
--Video_zapis(#naslov, jazik, vremetraenje, datum_d, datum_p)
--Video_zapis_zanr(#naslov*, #zanr)
--Lista_zelbi(#naslov*, #k_ime*, #ime*)
--Preporaka(#ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)


--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него


--Да се напише DML израз со кој за секој профил ќе се врати името на профилот и просечната оцена на видео записите во 
--листата на желби асоцирана со тој профил. (Просечната оцена на секој видео запис се пресметува од сите оцени за тој видео запис).


with Video_zapis_grade as (
    select vz.naslov, avg(ocena) as po_profil
    from Video_zapis vz
    join Preporaka p on p.naslov = vz.naslov
    group by vz.naslov
)

select distinct pr.ime, avg(vzg.po_profil) as po_profil
from Profil pr
join Lista_zelbi lz on lz.k_ime = pr.k_ime and lz.ime = pr.ime
join Video_zapis_grade vzg on vzg.naslov = lz.naslov
group by pr.ime
order by pr.ime