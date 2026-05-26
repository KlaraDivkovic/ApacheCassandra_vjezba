SELECT now() FROM system.local;

CREATE KEYSPACE IF NOT EXISTS vjezba WITH replication = {'class': 'SimpleStrategy','replication_factor': 1};

USE vjezba;

CREATE TABLE narudzbe (korisnik_id UUID,created_at TIMESTAMP,narudzba_id UUID,ukupno DECIMAL,status TEXT,grad TEXT,PRIMARY KEY (korisnik_id, created_at)) WITH CLUSTERING ORDER BY (created_at DESC);

CREATE TABLE proizvodi (id UUID PRIMARY KEY,naziv TEXT,cijena DECIMAL,kategorija TEXT,dostupnost BOOLEAN);

CREATE TABLE recenzije (proizvod_id UUID,korisnik_id UUID,ocjena INT,komentar TEXT,created_at TIMESTAMP,PRIMARY KEY (proizvod_id, korisnik_id));

CREATE TABLE pregledi_proizvoda (korisnik_id UUID,datum TIMESTAMP,proizvod TEXT,PRIMARY KEY (korisnik_id, datum));

INSERT INTO proizvodi (id, naziv, cijena, kategorija, dostupnost)VALUES (uuid(), 'Laptop Pro 15', 1299.99, 'elektronika', true);

INSERT INTO proizvodi (id, naziv, cijena, kategorija, dostupnost)VALUES (uuid(), 'Bežične slušalice', 149.99, 'elektronika', true);

INSERT INTO proizvodi (id, naziv, cijena, kategorija, dostupnost)VALUES (uuid(), 'Ergonomska stolica', 349.00, 'namještaj', true);

SELECT * FROM proizvodi;

INSERT INTO narudzbe (korisnik_id,created_at,narudzba_id,ukupno,status,grad)VALUES (11111111-1111-1111-1111-111111111111,toTimestamp(now()),uuid(),1449.98,'isporuceno','Zagreb');

INSERT INTO narudzbe (korisnik_id,created_at,narudzba_id,ukupno,status,grad)VALUES (11111111-1111-1111-1111-111111111111,toTimestamp(now()),uuid(),349.00,'u_obradi','Zagreb');

INSERT INTO narudzbe (korisnik_id,created_at,narudzba_id,ukupno,status,grad)VALUES (22222222-2222-2222-2222-222222222222,toTimestamp(now()),uuid(),499.00,'isporuceno','Split');

INSERT INTO narudzbe (korisnik_id,created_at,narudzba_id,ukupno,status,grad)VALUES (33333333-3333-3333-3333-333333333333,toTimestamp(now()),uuid(),799.99,'isporuceno','Mostar');

INSERT INTO narudzbe (korisnik_id,created_at,narudzba_id,ukupno,status,grad)VALUES (33333333-3333-3333-3333-333333333333,toTimestamp(now()),uuid(),199.99,'u_obradi','Sarajevo');

INSERT INTO narudzbe (korisnik_id,created_at,narudzba_id,ukupno,status,grad)VALUES (33333333-3333-3333-3333-333333333333,toTimestamp(now()),uuid(),129.99,'isporuceno','Tuzla');

SELECT * FROM narudzbe;

INSERT INTO narudzbe (korisnik_id,created_at,narudzba_id,ukupno,status,grad)VALUES (44444444-4444-4444-4444-444444444444,toTimestamp(now()),uuid(),9.99,'test','Mostar')USING TTL 30;

SELECT TTL(status), status FROM narudzbe WHERE korisnik_id = 44444444-4444-4444-4444-444444444444;

SELECT * FROM narudzbe WHERE korisnik_id = 44444444-4444-4444-4444-444444444444;

SELECT * FROM narudzbe WHERE status = 'isporuceno' ALLOW FILTERING;

UPDATE narudzbe SET status = 'isporuceno' WHERE korisnik_id = 33333333-3333-3333-3333-333333333333 AND created_at = '2026-05-26 08:22:01.108000+0000';

DELETE FROM narudzbe WHERE korisnik_id = 33333333-3333-3333-3333-333333333333 AND created_at = '2026-05-26 08:21:56.170000+0000';

CREATE INDEX idx_dostupnost ON proizvodi (dostupnost);

SELECT * FROM proizvodi WHERE dostupnost = true;

INSERT INTO proizvodi (id, naziv, cijena, kategorija, dostupnost) VALUES (ea1f8222-d77d-448a-9b0d-9439fede6b58,'Novi proizvod',49.99,'ostalo',true) IF NOT EXISTS;

CREATE MATERIALIZED VIEW narudzbe_po_statusu AS SELECT * FROM narudzbe WHERE status IS NOT NULL AND korisnik_id IS NOT NULL AND created_at IS NOT NULL PRIMARY KEY (status, korisnik_id, created_at);

SELECT * FROM narudzbe_po_statusu WHERE status = 'isporuceno';

SELECT SUM(ukupno) FROM narudzbe WHERE korisnik_id = 33333333-3333-3333-3333-333333333333;

SELECT AVG(ukupno) FROM narudzbe WHERE korisnik_id = 33333333-3333-3333-3333-333333333333;



Završni zadatak

CREATE TABLE tecaj (tecaj_id UUID PRIMARY KEY,naziv TEXT,instruktor TEXT,kategorija TEXT,cijena DECIMAL,trajanje_sati INT);

CREATE TABLE upis (student_id UUID,tecaj_id UUID,datum_upisa TIMESTAMP,napredak INT,status TEXT,PRIMARY KEY (student_id, tecaj_id));

CREATE TABLE lekcija (tecaj_id UUID,redni_broj INT,naslov TEXT,trajanje_min INT,sadrzaj_url TEXT,PRIMARY KEY (tecaj_id, redni_broj));

INSERT INTO tecaj (tecaj_id,naziv,instruktor,kategorija,cijena,trajanje_sati)VALUES (uuid(),'Python osnove','Marko Marić','programiranje',99.99,40);

INSERT INTO tecaj (tecaj_id,naziv,instruktor,kategorija,cijena,trajanje_sati)VALUES (uuid(),'Web razvoj','Ana Kovač','web',149.99,55);

INSERT INTO tecaj (tecaj_id,naziv,instruktor,kategorija,cijena,trajanje_sati)VALUES (uuid(),'Baze podataka','Ivan Perić','database',119.99,45);

INSERT INTO tecaj (tecaj_id,naziv,instruktor,kategorija,cijena,trajanje_sati)VALUES (uuid(),'UI UX dizajn','Petra Marić','dizajn',89.99,30);

INSERT INTO tecaj (tecaj_id,naziv,instruktor,kategorija,cijena,trajanje_sati)VALUES (uuid(),'Java programiranje','Luka Tomić','programiranje',159.99,60);

SELECT * FROM tecaj;

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (11111111-1111-1111-1111-111111111111,uuid(),toTimestamp(now()),20,'aktivan');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (11111111-1111-1111-1111-111111111111,uuid(),toTimestamp(now()),50,'aktivan');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (22222222-2222-2222-2222-222222222222,uuid(),toTimestamp(now()),70,'zavrsen');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (22222222-2222-2222-2222-222222222222,uuid(),toTimestamp(now()),40,'aktivan');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (33333333-3333-3333-3333-333333333333,uuid(),toTimestamp(now()),10,'aktivan');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (33333333-3333-3333-3333-333333333333,uuid(),toTimestamp(now()),90,'zavrsen');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (44444444-4444-4444-4444-444444444444,uuid(),toTimestamp(now()),60,'aktivan');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (44444444-4444-4444-4444-444444444444,uuid(),toTimestamp(now()),30,'aktivan');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (55555555-5555-5555-5555-555555555555,uuid(),toTimestamp(now()),100,'zavrsen');

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (55555555-5555-5555-5555-555555555555,uuid(),toTimestamp(now()),15,'aktivan');

INSERT INTO lekcija (tecaj_id,redni_broj,naslov,trajanje_min,sadrzaj_url)VALUES (11111111-1111-1111-1111-111111111111,1,'Uvod u Python',20,'https://lesson1.com');

INSERT INTO lekcija (tecaj_id,redni_broj,naslov,trajanje_min,sadrzaj_url)VALUES (11111111-1111-1111-1111-111111111111,2,'Varijable',25,'https://lesson2.com');

INSERT INTO lekcija (tecaj_id,redni_broj,naslov,trajanje_min,sadrzaj_url)VALUES (11111111-1111-1111-1111-111111111111,3,'Petlje',30,'https://lesson3.com');

SELECT * FROM lekcija WHERE tecaj_id = 11111111-1111-1111-1111-111111111111;

SELECT * FROM upis WHERE student_id = 11111111-1111-1111-1111-111111111111;

UPDATE upis SET napredak = 80 WHERE student_id = 11111111-1111-1111-1111-111111111111 AND tecaj_id = 22222222-2222-2222-2222-222222222222;

INSERT INTO upis (student_id,tecaj_id,datum_upisa,napredak,status)VALUES (uuid(),uuid(),toTimestamp(now()),0,'trial') USING TTL 604800;

CREATE MATERIALIZED VIEW tecaj_po_kategoriji AS SELECT * FROM tecaj WHERE kategorija IS NOT NULL AND tecaj_id IS NOT NULL PRIMARY KEY (kategorija, tecaj_id);

SELECT * FROM tecaj_po_kategoriji WHERE kategorija = 'programiranje';

SELECT COUNT(*) FROM upis WHERE student_id = 11111111-1111-1111-1111-111111111111;

SELECT AVG(napredak) FROM upis WHERE student_id = 11111111-1111-1111-1111-111111111111;