package com.cooperative.transport.entities;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
    private Employes employe;
    private java.sql.Date date_modification;
    public Salaires(int id, double salaire, Employes employe, java.sql.Date date_modification) {
        this.id = id;
        this.salaire = salaire;
        this.employe = employe;
        this.date_modification = date_modification;
    }
}
