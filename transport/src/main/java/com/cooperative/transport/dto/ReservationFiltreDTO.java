package com.cooperative.transport.dto;

import lombok.Getter;

@Getter
public class ReservationFiltreDTO {
    private String dateDebut;
    private String dateFin;
    private String villeDepart;
    private String villeArrivee;

    public ReservationFiltreDTO(String dateDebut, String dateFin, String villeDepart, String villeArrivee) {
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.villeDepart = villeDepart;
        this.villeArrivee = villeArrivee;
    }
}
