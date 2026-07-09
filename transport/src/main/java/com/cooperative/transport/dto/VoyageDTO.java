package com.cooperative.transport.dto;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;

@Getter
@Setter
public class VoyageDTO {

    private Integer idTrajet;
    private Integer idVehicule;
    private Integer idChauffeur;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate dateDepart;

    @DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
    private LocalTime heureDepart;

    private Integer dureeEstimeeMinutes;
    private Double tarif;
    private Double carburant;

    public VoyageDTO() {}

    public VoyageDTO(Integer idTrajet, Integer idVehicule, Integer idChauffeur, LocalDate dateDepart, LocalTime heureDepart, Integer dureeEstimeeMinutes, Double tarif, Double carburant) {
        this.idTrajet = idTrajet;
        this.idVehicule = idVehicule;
        this.idChauffeur = idChauffeur;
        this.dateDepart = dateDepart;
        this.heureDepart = heureDepart;
        this.dureeEstimeeMinutes = dureeEstimeeMinutes;
        this.tarif = tarif;
        this.carburant = carburant;
    }
}