package com.cooperative.transport.dto;

import java.time.LocalDate;

public interface VoyageDisponibleDTO {

    Integer getId();

    LocalDate getDateDepart();

    String getHeureDepart();

    String getHeureArrivee();

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
