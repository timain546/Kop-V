package com.cooperative.transport.dto;

public interface VoyageDTO {

    Integer getId();

    String getDateDepart();

    String getHeureDepart();

    String getGareDepart();

    String getGareArrivee();

    Integer getDuree();

    Double getDistance();

    String getImmatriculationVehicule();

    String getModeleVehicule();

    String getCategorieVehicule();

    Double getTarif();

    Integer getNbPlacesTotales();

    Integer getNbPlacesDisponibles();
}