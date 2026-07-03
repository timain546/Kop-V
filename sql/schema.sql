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
    date_modification 
);
CREATE TABLE contrats_employes(
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES utilisateurs(id),
    date_embauche date,
    date_renvoie date
);
create TABLE statut_employe(
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(50)
);
create TABLE employe_statut(
    id SERIAL PRIMARY KEY,
    id_employe INT REFERENCES utilisateurs(id),
    id_statut INT REFERENCES statut_employe(id),
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

insert into statut_employe(libelle) values('Engagé');
insert into statut_employe(libelle) values('Renvoyé');
insert into statut_employe(libelle) values('Reambauché');

insert into employe_statut(id_employe, id_statut, date_modification) values(1, 1, '2024-01-01');
insert into employe_statut(id_employe, id_statut, date_modification) values(2, 1, '2024-02-01');
insert into employe_statut(id_employe, id_statut, date_modification) values(3, 1, '2024-03-01');
insert into employe_statut(id_employe, id_statut, date_modification) values(4, 1, '2024-04-01');


insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(1, '2024-01-01', null);
insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(2, '2024-02-01', null);
insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(3, '2024-03-01', null);
insert into contrats_employes(id_employe, date_embauche, date_renvoie) values(4, '2024-04-01', null);
