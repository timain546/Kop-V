package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "voyages")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Voyage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_trajet")
    private Trajet trajet;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_vehicule")
    private Vehicule vehicule;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_chauffeur")
    private Utilisateur chauffeur;

    @Column(name = "date_heure_depart")
    private LocalDateTime dateHeureDepart;

    @Column(name = "duree_estimee_minutes")
    private Integer dureeEstimeeMinutes;

    @Column(name = "tarif", precision = 10, scale = 2)
    private BigDecimal tarif;
}
