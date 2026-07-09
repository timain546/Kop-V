package com.cooperative.transport.entities;

import jakarta.persistence.*;
import lombok.Setter;
import lombok.Getter;

@Entity
@Table(name = "client")
@Getter
@Setter
public class Client {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nom", nullable = false, length = 150)
    private String nom;

    @Column(name = "telephone", nullable = false, unique = true, length = 20)
    private String telephone;

    public Client() {}

}
