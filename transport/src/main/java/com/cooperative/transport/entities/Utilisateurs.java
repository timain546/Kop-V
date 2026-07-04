package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "utilisateurs")
public class Utilisateurs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

   
    private String nom;
    private String email;
    private String motDePasse;

    @ManyToOne
    @JoinColumn(name = "id_role", insertable = false, updatable = false)
    private Roles role; 

    @ManyToOne
    @JoinColumn(name = "id_status", insertable = false, updatable = false)
    private StatutEmploye statusEmployee;

    public Utilisateurs() {}

    public Utilisateurs(String nom, String email, String motDePasse, Roles role, StatutEmploye statusEmployee) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.role =role;
        this.statusEmployee = statusEmployee;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setRole(Roles role) {
        this.role = role;
    }

    public Roles getRole() {
        return role;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getNom() {
        return nom;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getMotDePasse() {
        return motDePasse;
    }
    public StatutEmploye getStatusEmployee() {
        return statusEmployee;
    }
    public void setStatusEmployee(StatutEmploye statusEmployee) {
        this.statusEmployee = statusEmployee;
    }
}