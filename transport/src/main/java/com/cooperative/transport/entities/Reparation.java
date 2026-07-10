package com.cooperative.transport.entities;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "reparation")
public class Reparation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Pas de relation JPA : la table "pannes" est gérée par une autre équipe.
    @Column(name = "id_panne", nullable = false)
    private Long idPanne;

    @ManyToOne
    @JoinColumn(name = "id_statut_reparation", nullable = false)
    private StatutReparation statutReparation;

    @Column(name = "date_modification", nullable = false)
    private LocalDate dateModification;

    @Column(name = "cout")
    private Double cout;

    public Reparation() {}

    public Reparation(Long idPanne, StatutReparation statutReparation, Double cout) {
        this.idPanne = idPanne;
        this.statutReparation = statutReparation;
        this.cout = cout;
        this.dateModification = LocalDate.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getIdPanne() { return idPanne; }
    public void setIdPanne(Long idPanne) { this.idPanne = idPanne; }

    public StatutReparation getStatutReparation() { return statutReparation; }
    public void setStatutReparation(StatutReparation statutReparation) { this.statutReparation = statutReparation; }

    public LocalDate getDateModification() { return dateModification; }
    public void setDateModification(LocalDate dateModification) { this.dateModification = dateModification; }

    public Double getCout() { return cout; }
    public void setCout(Double cout) { this.cout = cout; }
}