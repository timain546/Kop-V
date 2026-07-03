package com.cooperative.transport.models;

import java.math.BigDecimal;

import com.cooperative.transport.entities.ModePaiement;

public class ReservationPaiementForm {

    private BigDecimal montant;
    private ModePaiement modePaiement;
    private String reference;

    public ReservationPaiementForm() {}

    public BigDecimal getMontant() { return montant; }
    public void setMontant(BigDecimal montant) { this.montant = montant; }

    public ModePaiement getModePaiement() { return modePaiement; }
    public void setModePaiement(ModePaiement modePaiement) { this.modePaiement = modePaiement; }

    public String getReference() { return reference; }
    public void setReference(String reference) { this.reference = reference; }
}
