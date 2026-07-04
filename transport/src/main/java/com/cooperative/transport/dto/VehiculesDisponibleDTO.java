package com.cooperative.transport.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VehiculesDisponibleDTO {
    
    private Integer id;
    private String immatriculation;
    private String modele;
    private Integer nombrePlaces;

    public VehiculesDisponibleDTO() {
    }

    public VehiculesDisponibleDTO(Integer id, String immatriculation, String modele, Integer nombrePlaces) {
        this.id = id;
        this.immatriculation = immatriculation;
        this.modele = modele;
        this.nombrePlaces = nombrePlaces;
    }
}