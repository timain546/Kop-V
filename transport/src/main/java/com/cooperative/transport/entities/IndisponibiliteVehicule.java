package com.cooperative.transport.entities;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "indisponibilite_vehicule")
public class IndisponibiliteVehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_vehicule", nullable = false)
    private Vehicule vehicule;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MotifIndisponibilite motif;

    @Column(name = "date_debut", nullable = false)
    private LocalDate dateDebut;

    @Column(name = "date_fin_estimee")
    private LocalDate dateFinEstimee;

    public enum MotifIndisponibilite {
        EN_PANNE,
        VISITE_TECHNIQUE,
        REVISION
    }

    public IndisponibiliteVehicule() {}

    public IndisponibiliteVehicule(Vehicule vehicule, MotifIndisponibilite motif,
                                    LocalDate dateDebut, LocalDate dateFinEstimee) {
        this.vehicule = vehicule;
        this.motif = motif;
        this.dateDebut = dateDebut;
        this.dateFinEstimee = dateFinEstimee;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Vehicule getVehicule() { return vehicule; }
    public void setVehicule(Vehicule vehicule) { this.vehicule = vehicule; }

    public MotifIndisponibilite getMotif() { return motif; }
    public void setMotif(MotifIndisponibilite motif) { this.motif = motif; }

    public LocalDate getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDate dateDebut) { this.dateDebut = dateDebut; }

    public LocalDate getDateFinEstimee() { return dateFinEstimee; }
    public void setDateFinEstimee(LocalDate dateFinEstimee) { this.dateFinEstimee = dateFinEstimee; }
}