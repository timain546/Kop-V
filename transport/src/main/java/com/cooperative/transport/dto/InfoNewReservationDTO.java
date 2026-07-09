package com.cooperative.transport.dto;

import java.time.LocalDate;
import java.util.List;

import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.entities.Places;
import com.cooperative.transport.entities.Voyages;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InfoNewReservationDTO {

    private Gares gareDepart;
    private Gares gareArrivee;
    private LocalDate dateMin;
    private LocalDate dateMax;
    private int nbPlaces;
    private Voyages voyage;
    private List<Places> places;
}
