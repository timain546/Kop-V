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
    private Employes employe;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="id_statut")
    private StatutEmploye statutEmploye;
    private java.sql.Date date_modification;
    public EmployeStatut(int id, Employes employe, StatutEmploye statutEmploye, java.sql.Date date_modification) {
        this.id = id;
        this.employe = employe;
        this.statutEmploye = statutEmploye;
        this.date_modification = date_modification;

    }
}