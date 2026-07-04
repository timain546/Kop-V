package com.cooperative.transport.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChauffeurDTO {

    private Integer id;
    private String nom;
    private String prenom;

    public ChauffeurDTO() {}

    public ChauffeurDTO(Integer id, String nom, String prenom) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
    }
}