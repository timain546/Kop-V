package com.cooperative.transport.entities;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "vehicules")
public class Vehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String immatriculation;

    @Column(nullable = false)
    private String marque;

    @Column(nullable = false)
    private String modele;

    @Column(name = "nombre_places", nullable = false)
    private Integer nombrePlaces;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CategorieVehicule categorie;

    @Column(name = "prix", nullable = false)
    private Double prixAchat;

    @Column(name = "date_vente")
    private LocalDate dateVente;

    @Column(name = "date_achat", nullable = false)
    private LocalDate dateAchat;

    public Vehicule() {}

    public Vehicule(String immatriculation, String marque, String modele,
                     Integer nombrePlaces, CategorieVehicule categorie, Double prixAchat) {
        this.immatriculation = immatriculation;
        this.marque = marque;
        this.modele = modele;
        this.nombrePlaces = nombrePlaces;
        this.categorie = categorie;
        this.prixAchat = prixAchat;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getImmatriculation() { return immatriculation; }
    public void setImmatriculation(String immatriculation) { this.immatriculation = immatriculation; }

    public String getMarque() { return marque; }
    public void setMarque(String marque) { this.marque = marque; }

    public String getModele() { return modele; }
    public void setModele(String modele) { this.modele = modele; }

    public Integer getNombrePlaces() { return nombrePlaces; }
    public void setNombrePlaces(Integer nombrePlaces) { this.nombrePlaces = nombrePlaces; }

    public CategorieVehicule getCategorie() { return categorie; }
    public void setCategorie(CategorieVehicule categorie) { this.categorie = categorie; }

    public Double getPrixAchat() { return prixAchat; }
    public void setPrixAchat(Double prixAchat) { this.prixAchat = prixAchat; }

    public LocalDate getDateVente() { return dateVente; }
    public void setDateVente(LocalDate dateVente) { this.dateVente = dateVente; }

    public LocalDate getDateAchat() { return dateAchat; }
    public void setDateAchat(LocalDate dateAchat) { this.dateAchat = dateAchat; }
}