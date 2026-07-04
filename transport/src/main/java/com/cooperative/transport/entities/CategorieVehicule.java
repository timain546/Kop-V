package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "categorie_vehicule")
@Getter
@Setter
public class CategorieVehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "libelle", nullable = false, length = 50)
    private String libelle;

    public CategorieVehicule() {}

}
