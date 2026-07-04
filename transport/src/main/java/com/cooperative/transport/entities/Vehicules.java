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
import java.time.LocalDate;

@Entity
@Table(name = "vehicules")
@Getter
@Setter
public class Vehicules {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String immatriculation;
    private String modele;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_categorie", nullable = false)
    private CategorieVehicule categorie;

    @Column(name = "nombre_places")
    private Integer nombrePlaces;

    @Column(name = "date_vente")
    private LocalDate dateVente;

    @OneToMany(mappedBy = "vehicule")
    private List<Voyages> voyages;

    @OneToMany(mappedBy = "vehicule")
    private List<IndisponibiliteVehicule> indisponibilites;

    public Vehicules() {
    }

    public Vehicules(String immatriculation, String modele, CategorieVehicule categorie, Integer nombrePlaces, LocalDate dateVente) {
        this.immatriculation = immatriculation;
        this.modele = modele;
        this.categorie = categorie;
        this.nombrePlaces = nombrePlaces;
        this.dateVente = dateVente;
    }
}