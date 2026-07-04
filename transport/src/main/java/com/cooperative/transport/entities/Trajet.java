package com.cooperative.transport.entities;

import jakarta.persistence.*;

/**
 * ⚠️ CLASSE TEMPORAIRE — à remplacer par le vrai Trajet.java de mon binôme.
 * Sert uniquement à faire fonctionner et tester le module Tarif en attendant.
 */
@Entity
@Table(name = "trajet")
public class Trajet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "ville_depart", nullable = false)
    private String villeDepart;

    @Column(name = "ville_arrivee", nullable = false)
    private String villeArrivee;

    @Column(name = "distance_km", nullable = false)
    private Integer distanceKm;

    public Trajet() {}

    public Trajet(String villeDepart, String villeArrivee, Integer distanceKm) {
        this.villeDepart = villeDepart;
        this.villeArrivee = villeArrivee;
        this.distanceKm = distanceKm;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getVilleDepart() { return villeDepart; }
    public void setVilleDepart(String villeDepart) { this.villeDepart = villeDepart; }

    public String getVilleArrivee() { return villeArrivee; }
    public void setVilleArrivee(String villeArrivee) { this.villeArrivee = villeArrivee; }

    public Integer getDistanceKm() { return distanceKm; }
    public void setDistanceKm(Integer distanceKm) { this.distanceKm = distanceKm; }
}