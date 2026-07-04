package com.cooperative.transport.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "etudiants")
public class Etudiants {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String semestre;

    public Etudiants() {}

    public Etudiants(String nom, String semestre) {
        this.nom = nom;
        this.semestre = semestre;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getNom() {
        return nom;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public String getSemestre() {
        return semestre;
    }
}