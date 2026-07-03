package com.cooperative.transport.entities;
import jakarta.persistence.*;
@Entity
@Table(name = "statut_employe")
public class StatutEmploye {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String libelle;
    
    public StatutEmploye(int id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }
    public StatutEmploye() {
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getLibelle() {
        return libelle;
    }
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
}