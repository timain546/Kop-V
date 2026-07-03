package com.cooperative.transport.entities;
import jakarta.persistence.*;
import java.sql.Date;
@Entity
@Table(name = "contrats_employes")
public class ContratEmploye {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private java.sql.Date date_embauche;
    private java.sql.Date date_renvoie;
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="id_employe")
    private Employes employe;

    public ContratEmploye(int id, java.sql.Date date_embauche, java.sql.Date date_renvoie, Employes employe) {
        this.id = id;
        this.date_embauche = date_embauche;
        this.date_renvoie = date_renvoie;
        this.employe = employe;
    }
    public ContratEmploye() {
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
    public java.sql.Date getDate_embauche() {
        return date_embauche;
    }
    public void setDate_embauche(java.sql.Date date_embauche) {
        this.date_embauche = date_embauche;
    }
    public java.sql.Date getDate_renvoie() {
        return date_renvoie;
    }
    public void setDate_renvoie(java.sql.Date date_renvoie) {
        this.date_renvoie = date_renvoie;
    }
}