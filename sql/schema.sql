CREATE DATABASE kopv;
\c kopv;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    semestre VARCHAR(2)
);
CREATE TABLE role(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);
CREATE TABLE utilisateurs(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    id_role INT REFERENCES role(id),
    email VARCHAR(50) UNIQUE,
    mot_de_passe varchar(50)
    );

CREATE TABLE salaires(
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES utilisateurs(id),
    salaire DECIMAL(10, 2),
    date_modification date
);

insert into role(libelle) values('RE');
insert into role(libelle) values('chauffeur');
insert into role(libelle) values('employe');

insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rakoto', 'Jean', 1,'rakoto@gmail.com','123');
insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rabe', 'Marie', 2,'rabe@gmail.com','456');
insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rajaonarivelo', 'Andry', 3,'rajaonarivelo@gmail.com','789');
insert into utilisateurs(nom, prenom, id_role, email, mot_de_passe) values('Rasoa', 'Lalao', 3,'rasoa@gmail.com','012');

insert into salaires(id_employe, salaire, date_modification) values(1, 1500.00, '2024-01-01');
insert into salaires(id_employe, salaire, date_modification) values(2, 2000.00, '2024-02-01');
insert into salaires(id_employe, salaire, date_modification) values(3, 2500.00, '2024-03-01');
insert into salaires(id_employe, salaire, date_modification) values(1, 2600.00, '2024-04-01');