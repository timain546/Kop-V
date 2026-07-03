package com.cooperative.transport.entities;

import java.math.BigDecimal;

public class StatistiqueMensuelle {
    
    private Integer annee;
    private Integer mois;
    private BigDecimal recetteTotale;
    private Integer nbVoyagesTotal;
    private Integer nbClientsTotal;
    private BigDecimal evolution;
    private BigDecimal moyenneJournaliere;
    
    // Constructeurs
    public StatistiqueMensuelle() {}
    
    // Getters et Setters
    public Integer getAnnee() { return annee; }
    public void setAnnee(Integer annee) { this.annee = annee; }
    
    public Integer getMois() { return mois; }
    public void setMois(Integer mois) { this.mois = mois; }
    
    public BigDecimal getRecetteTotale() { return recetteTotale; }
    public void setRecetteTotale(BigDecimal recetteTotale) { this.recetteTotale = recetteTotale; }
    
    public Integer getNbVoyagesTotal() { return nbVoyagesTotal; }
    public void setNbVoyagesTotal(Integer nbVoyagesTotal) { this.nbVoyagesTotal = nbVoyagesTotal; }
    
    public Integer getNbClientsTotal() { return nbClientsTotal; }
    public void setNbClientsTotal(Integer nbClientsTotal) { this.nbClientsTotal = nbClientsTotal; }
    
    public BigDecimal getEvolution() { return evolution; }
    public void setEvolution(BigDecimal evolution) { this.evolution = evolution; }
    
    public BigDecimal getMoyenneJournaliere() { return moyenneJournaliere; }
    public void setMoyenneJournaliere(BigDecimal moyenneJournaliere) { this.moyenneJournaliere = moyenneJournaliere; }
}