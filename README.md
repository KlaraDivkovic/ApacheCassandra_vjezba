# ApacheCassandra_vjezba

Apache Cassandra – Vježba

Projekt sadrži rješenja zadataka iz vježbe Apache Cassandra.

Sadržaj repozitorija:
- docker-compose.yml
- queries.cql
- ODGOVORI.md
- screenshots/

Pokretanje projekta:
1. Pokretanje Cassandra containera:
docker compose up -d

2. Spajanje na Cassandra konzolu:
docker exec -it cassandra-cassandra-1 cqlsh

3. Pokretanje upita:
- otvoriti queries.cql
- kopirati upite u cqlsh konzolu

Projekt uključuje:
- kreiranje keyspace-a i tablica
- INSERT, SELECT, UPDATE i DELETE upite
- TTL mehanizam
- Secondary Index
- Materialized View
- agregacijske funkcije
- završni zadatak za platformu online tečajeva
