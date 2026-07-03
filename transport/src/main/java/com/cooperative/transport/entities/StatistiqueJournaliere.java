package com.cooperative.transport.entities;

import java.math.BigDecimal;
import java.time.LocalDate;

public class StatistiqueJournaliere {
    
    private LocalDate date;
    private BigDecimal recette;
    private Integer nbVoyages;
    private Integer nbClients;
    // private BigDecimal panierMoyen;
    
    // Constructeurs
    public StatistiqueJournaliere() {}
    
    // Getters et Setters
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }
    
    public BigDecimal getRecette() { return recette; }
    public void setRecette(BigDecimal recette) { this.recette = recette; }
    
    public Integer getNbVoyages() { return nbVoyages; }
    public void setNbVoyages(Integer nbVoyages) { this.nbVoyages = nbVoyages; }
    
    public Integer getNbClients() { return nbClients; }
    public void setNbClients(Integer nbClients) { this.nbClients = nbClients; }
    
    // public BigDecimal getPanierMoyen() { return panierMoyen; }
    // public void setPanierMoyen(BigDecimal panierMoyen) { this.panierMoyen = panierMoyen; }
}