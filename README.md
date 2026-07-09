# Kop-V
Projet Mme Baovola S4

## Installation
- Créer une base de données PostgreSQL:
```sql
create database kopv;
\c kopv
create extension postgis;
```
- Vérifier que [application.properties](transport/src/main/resources/application.properties) est correct:
```bash
spring.datasource.url=jdbc:postgresql://localhost:5432/kopv
spring.datasource.username=postgres
spring.datasource.password=votre_mot_de_passe
```
- Ouvrir un terminal dans le dossier [transport](transport) et exécuter la commande suivante:
```bash
mvn spring-boot:run
```
- Exécuter les commandes SQL dans [post-install.sql](sql/post-install.sql)
