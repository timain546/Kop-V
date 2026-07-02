package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "vehicules")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Vehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, length = 20)
    private String immatriculation;

    @Column(length = 100)
    private String modele;

    @ManyToOne
    @JoinColumn(name = "id_categorie")
    private CategorieVehicule categorie;

    @Column(name = "nombre_places")
    private Integer nombrePlaces;
}
