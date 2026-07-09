package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.FetchType;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "indisponibilite_vehicule")
@Getter
@Setter
public class IndisponibiliteVehicule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_vehicule", nullable = false)
    private Vehicules vehicule;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_fin_estimee")
    private LocalDate dateFinEstimee;

    public IndisponibiliteVehicule() {
    }

    public IndisponibiliteVehicule(Vehicules vehicule, LocalDate dateDebut, LocalDate dateFinEstimee) {
        this.vehicule = vehicule;
        this.dateDebut = dateDebut;
        this.dateFinEstimee = dateFinEstimee;
    }
}
