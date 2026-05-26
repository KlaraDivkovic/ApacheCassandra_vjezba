Zadatak 1
Koji port Cassandra eksponira, čemu služi i zašto Cassandra nema web browser sučelje kao Neo4j?

- Cassandra koristi port 9042 za CQL komunikaciju između baze i klijentskih aplikacija poput cqlsh konzole.Taj port služi za izvršavanje CQL upita i povezivanje aplikacija s bazom podataka.Cassandra nema ugrađeno web sučelje kao Neo4j jer je fokusirana na distribuiranu obradu podataka i administraciju putem komandne linije i vanjskih alata.

Zadatak 2
Zašto je izbor partition key-a kritičan u Cassandri i što je hot partition problem?

- Partition key određuje na kojem će čvoru podaci biti pohranjeni.Ako velik broj zapisa koristi isti partition key, svi zahtjevi opterećuju isti čvor.Takva situacija naziva se hot partition problem i može uzrokovati pad performansi sustava.

Zadatak 4
Zašto je ALLOW FILTERING problematičan u produkciji?

- ALLOW FILTERING uzrokuje skeniranje velikog broja podataka i može značajno usporiti rad baze. Cassandra mora pregledavati više particija jer upit ne koristi partition key.U velikim sustavima to može dovesti do velikog opterećenja klastera.

Razlika između partition key i clustering column u CQL WHERE upitima

- Partition key određuje gdje se podaci fizički pohranjuju u klasteru. Clustering column određuje redoslijed podataka unutar particije. U ovoj vježbi korisnik_id je partition key, a created_at clustering column za sortiranje narudžbi po vremenu.

Zadatak 5
Što je tombstone u Cassandri i kada se briše?

- Tombstone je oznaka da je podatak obrisan, ali se fizički ne uklanja odmah iz baze. Cassandra koristi tombstone kako bi osigurala sinkronizaciju između distribuiranih čvorova. Tombstone se uklanja tijekom procesa Compaction kada više nije potreban.

Zadatak 6
Razlika između Secondary Index i Materialized View

- Secondary Index koristi se za jednostavno pretraživanje stupaca koji nisu partition key, primjerice dostupnost proizvoda. Materialized View stvara novu strukturu podataka s drugačijim primary key-em za brže izvršavanje određenih upita. Secondary Index je jednostavniji za manje sustave, dok je Materialized View koristan za često korištene pristupne obrasce.

Završni zadatak

- Kod tablice Tecaj koristi se tecaj_id kao partition key jer svaki tečaj ima jedinstveni identifikator i najčešće se dohvaća pojedinačno.
- Kod tablice Upis student_id je partition key jer se najčešće dohvaćaju svi tečajevi određenog studenta, dok tecaj_id služi za razlikovanje pojedinih upisa.
- Kod tablice Lekcija tecaj_id je partition key jer se lekcije dohvaćaju po određenom tečaju, a redni_broj omogućuje sortiranje lekcija pravilnim redoslijedom.
- Cassandra bi bila pogodna za platformu online tečajeva u situacijama kada sustav ima velik broj korisnika i veliku količinu podataka koji se često upisuju i čitaju. Posebno je korisna kod sustava koji zahtijevaju visoki write throughput i globalnu distribuciju podataka između više servera. Cassandra omogućava vrlo brzo spremanje velikog broja aktivnosti korisnika, napretka u učenju i pristupa lekcijama. Prednost predstavlja i mogućnost korištenja TTL opcije za trial pristupe koji automatski ističu nakon određenog vremena. Relacijske baze poput PostgreSQL-a bolje su za složene relacije i transakcije, ali kod velikih distribuiranih sustava mogu imati probleme sa skalabilnošću i performansama. Cassandra je pogodna za aplikacije koje imaju velik broj korisnika raspoređenih na više lokacija i zahtijevaju visoku dostupnost sustava.