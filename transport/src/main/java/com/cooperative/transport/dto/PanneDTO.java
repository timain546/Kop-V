package com.cooperative.transport.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PanneDTO {
    private Long id;
    private Long voyageId;
    private LocalDate dateSignalement;
    private String lieu;
    private String motifPanneLibelle;
    private String description;
    private String photoUrl;
}
