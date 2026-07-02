package com.cooperative.transport.models;

import java.math.BigDecimal;

import com.cooperative.transport.entities.ModePaiement;

public class ReservationNewPaiementForm {

    private String nomClient;
    private String telephoneClient;
    private BigDecimal montant;
    private ModePaiement modePaiement;
    private String reference;

    public ReservationNewPaiementForm() {}

    public String getNomClient() { return nomClient; }
    public void setNomClient(String nomClient) { this.nomClient = nomClient; }

    public String getTelephoneClient() { return telephoneClient; }
    public void setTelephoneClient(String telephoneClient) { this.telephoneClient = telephoneClient; }

    public BigDecimal getMontant() { return montant; }
    public void setMontant(BigDecimal montant) { this.montant = montant; }

    public ModePaiement getModePaiement() { return modePaiement; }
    public void setModePaiement(ModePaiement modePaiement) { this.modePaiement = modePaiement; }

    public String getReference() { return reference; }
    public void setReference(String reference) { this.reference = reference; }
}
