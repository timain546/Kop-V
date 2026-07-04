package com.cooperative.transport.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.OneToMany;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "statut_voyage")
@Getter
@Setter
public class StatutVoyage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String libelle;

    @OneToMany(mappedBy = "statut")
    private List<VoyageStatut> voyageStatuts;

    public StatutVoyage() {
    }

    public StatutVoyage(String libelle) {
        this.libelle = libelle;
    }
}