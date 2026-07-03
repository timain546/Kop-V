package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "vehicules")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "immatriculation", length = 50)
    private String immatriculation;

    @Column(name = "modele", length = 50)
    private String modele;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_categorie")
    private CategorieVehicule categorie;

    @Column(name = "nombre_places")
    private Integer nombrePlaces;
}
