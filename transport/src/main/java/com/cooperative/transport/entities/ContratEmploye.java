package com.cooperative.transport.entities;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
@Entity
@Table(name = "contrats_employes")
public class ContratEmploye {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "date_embauche")
    private java.sql.Date dateEmbauche;
    @Column(name = "date_renvoie")
    private java.sql.Date dateRenvoie;
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="id_employe")
    private Employes employe;

    public ContratEmploye(int id, java.sql.Date dateEmbauche, java.sql.Date dateRenvoie, Employes employe) {
        this.id = id;
        this.dateEmbauche = dateEmbauche;
        this.dateRenvoie = dateRenvoie;
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
    public java.sql.Date getDateEmbauche() {
        return dateEmbauche;
    }
    public void setDateEmbauche(java.sql.Date dateEmbauche) {
        this.dateEmbauche = dateEmbauche;
    }
    public java.sql.Date getDateRenvoie() {
        return dateRenvoie;
    }
    public void setDateRenvoie(java.sql.Date dateRenvoie) {
        this.dateRenvoie = dateRenvoie;
    }
}