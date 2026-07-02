package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.util.List;
import jakarta.persistence.OneToMany;

@Entity
@Table(name = "utilisateurs")
public class Employes {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String motDePasse;

    @ManyToOne
    @JoinColumn(name="id_role")
    private Roles role;

    @OneToMany(mappedBy="employe")
    private List<Salaires> salaires;

    public Employes(int id, String nom, String prenom, String email, String motDePasse, Roles role, List<Salaires> salaires) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.role = role;
        this.salaires = salaires;
    }

    public Employes() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public Roles getRole() {
        return role;
    }

    public void setRole(Roles role) {
        this.role = role;
    }

    public List<Salaires> getSalaires() {
        return salaires;
    }

    public void setSalaires(List<Salaires> salaires) {
        this.salaires = salaires;
    }
}
