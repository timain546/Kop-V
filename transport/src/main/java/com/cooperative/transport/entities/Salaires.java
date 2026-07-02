package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.FetchType;

@Entity
public class Salaires {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private double salaire;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="id_employe")
    private Employes employe;
    private java.sql.Date date_modification;

    public Salaires(int id, double salaire, Employes employe, java.sql.Date date_modification) {
        this.id = id;
        this.salaire = salaire;
        this.employe = employe;
        this.date_modification = date_modification;
    }

    public Salaires() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getSalaire() {
        return salaire;
    }

    public void setSalaire(double salaire) {
        this.salaire = salaire;
    }

    public Employes getEmploye() {
        return employe;
    }

    public void setEmploye(Employes employe) {
        this.employe = employe;
    }

    public java.sql.Date getDate_modification() {
        return date_modification;
    }

    public void setDate_modification(java.sql.Date date_modification) {
        this.date_modification = date_modification;
    }
}
