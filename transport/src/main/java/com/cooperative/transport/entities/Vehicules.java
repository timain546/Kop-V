package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "vehicules")
@Getter
@Setter
public class Vehicules {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "immatriculation", nullable = false, unique = true, length = 20)
    private String immatriculation;

    @Column(name = "modele", nullable = false, length = 100)
    private String modele;

    @ManyToOne
    @JoinColumn(name = "id_categorie", nullable = false)
    private CategorieVehicule categorieVehicule;

    @Column(name = "nombre_places", nullable = false)
    private Short nombrePlaces;
}
