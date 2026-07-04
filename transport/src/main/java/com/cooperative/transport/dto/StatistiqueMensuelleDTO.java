package com.cooperative.transport.dto;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StatistiqueMensuelleDTO {

    private Integer annee;
    private Integer mois;
    private BigDecimal recetteTotale;
    private Integer nbVoyagesTotal;
    private Integer nbClientsTotal;
    private BigDecimal evolution;
    private BigDecimal moyenneJournaliere;
}
