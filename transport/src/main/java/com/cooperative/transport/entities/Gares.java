package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.OneToMany;
import org.locationtech.jts.geom.Point;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "gares")
@Getter
@Setter
public class Gares {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String nom;
    private String ville;

    @Column(columnDefinition = "geometry(Point, 4326)")
    private Point position;

    // Relation avec les trajets au départ de cette gare
    @OneToMany(mappedBy = "gareDepart")
    private List<Trajets> trajetsDepart;

    // Relation avec les trajets à l'arrivée de cette gare
    @OneToMany(mappedBy = "gareArrivee")
    private List<Trajets> trajetsArrivee;

    public Gares() {
    }

    public Gares(String nom, String ville, Point position) {
        this.nom = nom;
        this.ville = ville;
        this.position = position;
    }
}