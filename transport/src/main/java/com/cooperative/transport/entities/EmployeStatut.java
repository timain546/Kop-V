package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "employe_statut")
@Getter
@Setter
public class EmployeStatut {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="id_employe")
    private Utilisateurs employe;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="id_statut")
    private StatutEmploye statutEmploye;
    @Column(name = "date_modification")
    private java.sql.Date dateModification;

    public EmployeStatut() {}

    public EmployeStatut(int id, Utilisateurs employe, StatutEmploye statutEmploye, java.sql.Date dateModification) {
        this.id = id;
        this.employe = employe;
        this.statutEmploye = statutEmploye;
        this.dateModification = dateModification;

    }
}
