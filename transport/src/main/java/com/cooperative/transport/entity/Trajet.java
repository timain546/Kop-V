package com.cooperative.transport.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "trajets")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Trajet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_gare_depart")
    private Gare gareDepart;

    @ManyToOne
    @JoinColumn(name = "id_gare_arrivee")
    private Gare gareArrivee;

    @Column(name = "distance_km", precision = 10, scale = 2)
    private BigDecimal distanceKm;
}
