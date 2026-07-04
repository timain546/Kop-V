package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "voyages")
@Getter
@Setter
public class Voyages {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_trajet", nullable = false)
    private Trajets trajet;

    @ManyToOne
    @JoinColumn(name = "id_vehicule", nullable = false)
    private Vehicules vehicule;

    @ManyToOne
    @JoinColumn(name = "id_chauffeur", nullable = false)
    private Utilisateurs chauffeur;

    @Column(name = "date_heure_depart", nullable = false)
    private LocalDateTime dateHeureDepart;

    @Column(name = "duree_estimee_minutes", nullable = false)
    private Integer dureeEstimeeMinutes;

    @Column(name = "tarif", nullable = false, precision = 10, scale = 2)
    private BigDecimal tarif;
}
