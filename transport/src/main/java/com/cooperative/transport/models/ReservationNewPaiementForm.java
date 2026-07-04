package com.cooperative.transport.models;

import java.math.BigDecimal;

import com.cooperative.transport.entities.ModePaiement;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReservationNewPaiementForm {

    private String nomClient;
    private String telephoneClient;
    private BigDecimal montant;
    private ModePaiement modePaiement;
    private String reference;
}
