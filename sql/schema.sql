CREATE DATABASE kopv;
\c kopv;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    semestre VARCHAR(2)
);