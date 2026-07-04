package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "voyages")
@Getter
@Setter
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
    @OrderBy("dateModification DESC")
    private List<VoyageStatut> voyageStatuts;

    public Voyages() {
    }

    public Voyages(Trajets trajet, Vehicules vehicule, Utilisateurs chauffeur, LocalDateTime dateHeureDepart,
            Integer dureeEstimeeMinutes, BigDecimal tarif) {
        this.trajet = trajet;
        this.vehicule = vehicule;
        this.chauffeur = chauffeur;
        this.dateHeureDepart = dateHeureDepart;
        this.dureeEstimeeMinutes = dureeEstimeeMinutes;
        this.tarif = tarif;
    }

    public VoyageStatut getStatutActuel() {
        if (voyageStatuts != null && !voyageStatuts.isEmpty()) {
            return voyageStatuts.get(0);
        }
        return null;
    }
}