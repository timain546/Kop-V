package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "motif_panne")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MotifPanne {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "libelle", length = 50)
    private String libelle;
}
