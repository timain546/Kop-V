package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Table(name = "trajets")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Trajet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_gare_depart")
    private Gare gareDepart;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_gare_arrivee")
    private Gare gareArrivee;

    @Column(name = "distance_km", precision = 10, scale = 2)
    private BigDecimal distanceKm;
}
