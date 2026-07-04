package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "utilisateurs")
@Getter
@Setter
public class Utilisateurs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nom", nullable = false, length = 150)
    private String nom;

    @Column(name = "prenom", nullable = false, length = 50)
    private String prenom;


    @Column (name = "email", nullable = false, unique = true, length = 100)
    private String email;


    @Column (name = "mot_de_passe", nullable = false, length = 100)
    private String motDePasse;

    @ManyToOne
    @JoinColumn(name = "id_role", nullable = false)
    private Role role;
}
