package com.cooperative.transport.models;

public class ReservationFiltreVM {
    private String dateDebut;
    private String dateFin;
    private String villeDepart;
    private String villeArrivee;

    public ReservationFiltreVM(String dateDebut, String dateFin, String villeDepart, String villeArrivee) {
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.villeDepart = villeDepart;
        this.villeArrivee = villeArrivee;
    }

    public String getDateDebut() { return dateDebut; }
    public String getDateFin() { return dateFin; }
    public String getVilleDepart() { return villeDepart; }
    public String getVilleArrivee() { return villeArrivee; }
}