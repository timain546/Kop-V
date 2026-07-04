package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "trajets")
@Getter
@Setter
public class Trajets {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_gare_depart", nullable = false)
    private Gares gareDepart;

    @ManyToOne
    @JoinColumn(name = "id_gare_arrivee", nullable = false)
    private Gares gareArrivee;

    @Column(name = "distance_km", nullable = false, precision = 10, scale = 2)
    private BigDecimal distanceKm;
}
