--Релационата база е дефинирана преку следните релации:
--Korisnik(#k_ime, ime, prezime, tip, pretplata, datum_reg, tel_broj, email)
--Premium_korisnik(#k_ime*, datum, procent_popust)
--Profil(#k_ime*, #ime, datum)
--Video_zapis(#naslov, jazik, vremetraenje, datum_d, datum_p)
--Video_zapis_zanr(#naslov*, #zanr)
--Lista_zelbi(#naslov*, #k_ime*, #ime*)
--Preporaka(#ID, k_ime_od*, k_ime_na*, naslov*, datum, komentar, ocena)

--Примарниот клуч е означен со # пред него,  додека па надворешните (foreign клучевите) се означени со * по него

--Да се напише DML израз со кој ќе се вратат корисничките имиња и насловите на препорачаните видео записи за 
--сите премиум корисници кои добиле препорака со оцена поголема од 3 за барем еден видео запис во 2021 година 
--кој е дел од листата на желби во барем еден од нивните профили, подредени според корисничкото име.


select distinct p.k_ime_na as k_ime, p.naslov
from Preporaka p
join Premium_korisnik pk on p.k_ime_na = pk.k_ime
join Lista_zelbi lz on pk.k_ime = lz.k_ime and p.naslov = lz.naslov
--join Profil pr on lz.k_ime = pr.k_ime and lz.ime = pr.ime
--join Video_zapis vz on lz.naslov = vz.naslov
where ocena > 3 and p.datum like '2021%'
order by 1

