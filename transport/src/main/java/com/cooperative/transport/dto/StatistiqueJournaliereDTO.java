package com.cooperative.transport.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StatistiqueJournaliereDTO {

    private LocalDate date;
    private BigDecimal recette;
    private Integer nbVoyages;
    private Integer nbClients;
    // private BigDecimal panierMoyen;
}
