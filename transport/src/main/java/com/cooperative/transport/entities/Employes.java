package com.cooperative.transport.entities;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import jakarta.persistence.OneToMany;
@Entity
@Table(name = "utilisateurs")
@Getter
@Setter
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
    private Role role;

    @OneToMany(mappedBy="employe")
    private List<Salaires> salaires;
    @OneToMany(mappedBy="employe")
    private List<ContratsEmployes> contratEmployes;

    public Employes(int id, String nom, String prenom, String email, String motDePasse, Role role,List<Salaires> salaires, List<ContratsEmployes> contratEmployes) {
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
