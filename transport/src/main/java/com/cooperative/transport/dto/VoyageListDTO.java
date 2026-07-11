package com.cooperative.transport.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class VoyageListDTO {
    private Integer id;
    private String gareDepart;
    private String gareArrivee;
    private String gareDepartVille;
    private String gareArriveeVille;
    private LocalDateTime dateHeureDepart;
    private Integer dureeEstimeeMinutes;
    private BigDecimal tarif;
    private String vehiculeImmatriculation;
    private String vehiculeModele;
    private Integer vehiculeNombrePlaces;
    private String vehiculeCategorie;
    private BigDecimal distanceKm;
    private String statutLibelle;

    /** For JSTL fmt:formatDate which requires java.util.Date */
    public java.util.Date getDateHeureDepartAsDate() {
        if (dateHeureDepart == null) return null;
        return java.util.Date.from(dateHeureDepart.atZone(java.time.ZoneId.systemDefault()).toInstant());
    }
}
