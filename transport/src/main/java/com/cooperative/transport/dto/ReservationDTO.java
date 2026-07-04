package com.cooperative.transport.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.math.BigDecimal;

public interface ReservationDTO {

    Integer getIdReservation();

    LocalDateTime getDateReservation();

    String getClient();

    String getTelephone();

    LocalDateTime getDateVoyage();

    String getGareDepart();

    String getGareArrivee();

    String getNumeroPlace();

    String getStatutPaiement();

    BigDecimal getTarif();

}