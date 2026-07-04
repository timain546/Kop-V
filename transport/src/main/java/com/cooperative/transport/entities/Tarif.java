package com.cooperative.transport.entities;

import jakarta.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "tarif_voyage")
public class Tarif {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_trajet", nullable = false)
    private Trajet trajet;

    // Remplace l'ancien champ "vehicule" : on ne cible plus un véhicule précis,
    // mais une gamme de confort (Standard / Premium / VIP)
    @Enumerated(EnumType.STRING)
    @Column(name = "categorie", nullable = false)
    private CategorieVehicule categorie;

    @Column(name = "date_insertion", nullable = false)
    private LocalDate dateInsertion;

    // Renseignée uniquement lors d'une modification de prix (saisie manuelle par l'utilisateur)
    // @Column(name = "date_modification")
    // private LocalDate dateModification;

    @Column(name = "date_enregistrement", nullable = false)
    private LocalDateTime dateEnregistrement;

    @Column(name = "prix_tarif", nullable = false)
    private Double prixTarif;

    public Tarif() {}

    public Tarif(Trajet trajet, CategorieVehicule categorie, LocalDate dateInsertion, Double prixTarif) {
        this.trajet = trajet;
        this.categorie = categorie;
        this.dateInsertion = dateInsertion;
        this.prixTarif = prixTarif;
        this.dateEnregistrement = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Trajet getTrajet() { return trajet; }
    public void setTrajet(Trajet trajet) { this.trajet = trajet; }

    public CategorieVehicule getCategorie() { return categorie; }
    public void setCategorie(CategorieVehicule categorie) { this.categorie = categorie; }

    public LocalDate getDateInsertion() { return dateInsertion; }
    public void setDateInsertion(LocalDate dateInsertion) { this.dateInsertion = dateInsertion; }

    // public LocalDate getDateModification() { return dateModification; }
    // public void setDateModification(LocalDate dateModification) { this.dateModification = dateModification; }

    public LocalDateTime getDateEnregistrement() { return dateEnregistrement; }
    public void setDateEnregistrement(LocalDateTime dateEnregistrement) { this.dateEnregistrement = dateEnregistrement; }

    public Double getPrixTarif() { return prixTarif; }
    public void setPrixTarif(Double prixTarif) { this.prixTarif = prixTarif; }

    // Utilitaire pour l'affichage JSP (fmt:formatDate a besoin de java.util.Date)
    public Date getDateEnregistrementAsDate() {
        return dateEnregistrement != null ? Timestamp.valueOf(dateEnregistrement) : null;
    }
}