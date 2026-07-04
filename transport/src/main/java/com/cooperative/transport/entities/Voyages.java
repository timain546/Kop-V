package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "voyages")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Voyages {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_trajet", nullable = false)
    private Trajets trajet;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_vehicule", nullable = false)
    private Vehicules vehicule;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_chauffeur", nullable = false)
    private Utilisateurs chauffeur;

    @Column(name = "date_heure_depart", nullable = false)
    private LocalDateTime dateHeureDepart;

    @Column(name = "duree_estimee_minutes", nullable = false)
    private Integer dureeEstimeeMinutes;

    @Column(name = "tarif", precision = 10, scale = 2, nullable = false)
    private BigDecimal tarif;

    @OneToMany(mappedBy = "voyage", fetch = FetchType.LAZY)
    private List<VoyageStatut> voyageStatuts;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_statut_actuel", nullable = false)
    private VoyageStatut statutActuel;
}
