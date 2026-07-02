package com.cooperative.transport.models;

import java.time.LocalDate;
import java.util.List;

import com.cooperative.transport.entities.Gare;
import com.cooperative.transport.entities.Place;
import com.cooperative.transport.entities.Voyage;

public class InfoNewReservation {

    private Gare gareDepart;
    private Gare gareArrivee;
    private LocalDate dateMin;
    private LocalDate dateMax;
    private int nbPlaces;
    private Voyage voyage;
    private List<Place> places;

    public InfoNewReservation() {}

    public Gare getGareDepart() { return gareDepart; }
    public void setGareDepart(Gare gareDepart) { this.gareDepart = gareDepart; }

    public Gare getGareArrivee() { return gareArrivee; }
    public void setGareArrivee(Gare gareArrivee) { this.gareArrivee = gareArrivee; }

    public LocalDate getDateMin() { return dateMin; }
    public void setDateMin(LocalDate dateMin) { this.dateMin = dateMin; }

    public LocalDate getDateMax() { return dateMax; }
    public void setDateMax(LocalDate dateMax) { this.dateMax = dateMax; }

    public int getNbPlaces() { return nbPlaces; }
    public void setNbPlaces(int nbPlaces) { this.nbPlaces = nbPlaces; }

    public Voyage getVoyage() { return voyage; }
    public void setVoyage(Voyage voyage) { this.voyage = voyage; }

    public List<Place> getPlaces() { return places; }
    public void setPlaces(List<Place> places) { this.places = places; }
}
