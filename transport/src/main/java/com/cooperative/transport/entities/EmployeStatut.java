package com.cooperative.transport.entities;
import jakarta.persistence.*;
@Entity
@Table(name = "employe_statut")
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
    public EmployeStatut() {
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public Employes getEmploye() {  
        return employe;
    }
    public void setEmploye(Employes employe) {
        this.employe = employe;
    }
    public StatutEmploye getStatutEmploye() {   
        return statutEmploye;
    }
    public void setStatutEmploye(StatutEmploye statutEmploye) {
        this.statutEmploye = statutEmploye;
    }
    public java.sql.Date getDate_modification() {
        return date_modification;
    }
    public void setDate_modification(java.sql.Date date_modification) {
        this.date_modification = date_modification;
    }
}