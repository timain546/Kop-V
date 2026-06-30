package com.cooperative.transport.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "gares")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Gare {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 150)
    private String nom;

    @Column(length = 100)
    private String ville;
}
