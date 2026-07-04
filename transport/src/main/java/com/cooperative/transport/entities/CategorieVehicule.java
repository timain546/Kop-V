package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "categorie_vehicule")
@Getter
@Setter
public class CategorieVehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String libelle;

    @OneToMany(mappedBy = "categorie")
    private List<Vehicules> vehicules;

    @OneToMany(mappedBy = "categorie")
    @OrderBy("dateModification DESC")
    private List<TarifVoyage> tarifVoyages;

    public CategorieVehicule() {
    }

    public CategorieVehicule(String libelle) {
        this.libelle = libelle;
    }
}