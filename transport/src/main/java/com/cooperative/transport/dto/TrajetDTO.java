package com.cooperative.transport.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrajetDTO {
    
    private Integer gareDepart;
    private Integer gareArrivee;
    private Double distanceKm;
}