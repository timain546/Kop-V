package com.cooperative.transport.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "trajet_etapes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrajetEtape {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_trajet")
    private Trajet trajet;

    @ManyToOne
    @JoinColumn(name = "id_point_ramassage")
    private PointRamassage pointRamassage;

    @Column
    private Integer ordre;

    @Column(name = "duree_depuis_depart_minute")
    private Integer dureeDepuisDepartMinute;
}
