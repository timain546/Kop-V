package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.FetchType;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "utilisateurs")
@Getter
@Setter
public class Utilisateurs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String nom;
    private String prenom;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_role", nullable = false)
    private Role role;

    private String email;

    @Column(name = "mot_de_passe")
    private String motDePasse;

    @OneToMany(mappedBy = "chauffeur")
    private List<Voyages> voyages;

    @OneToMany(mappedBy="employe")
    private List<Salaires> salaires;

    @OneToMany(mappedBy="employe")
    private List<ContratsEmployes> contratEmployes;

    public Utilisateurs() {
    }

    public Utilisateurs(String nom, String prenom, Role role, String email, String motDePasse) {
        this.nom = nom;
        this.prenom = prenom;
        this.role = role;
        this.email = email;
        this.motDePasse = motDePasse;
    }

    public Utilisateurs(int id, String nom, String prenom, String email, String motDePasse, Role role,List<Salaires> salaires, List<ContratsEmployes> contratEmployes) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.role = role;
        this.salaires = salaires;
        this.contratEmployes = contratEmployes;
    }
}
