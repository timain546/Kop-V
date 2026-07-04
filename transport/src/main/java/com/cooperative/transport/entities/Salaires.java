package com.cooperative.transport.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import jakarta.persistence.FetchType;

@Entity
@Table(name = "salaires")
@Getter
@Setter
public class Salaires {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private double salaire;

    @ManyToOne(fetch =FetchType.LAZY)
    @JoinColumn(name="id_employe")
    private Utilisateurs employe;

    @Column(name = "date_modification")
    private java.sql.Date dateModification;

    public Salaires() {}

    public Salaires(int id, double salaire, Utilisateurs employe, java.sql.Date dateModification) {
        this.id = id;
        this.salaire = salaire;
        this.employe = employe;
        this.dateModification = dateModification;
    }
}
