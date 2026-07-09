package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Places;
import com.cooperative.transport.entities.Vehicules;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;



public interface PlaceRepository extends JpaRepository<Places, Long> {

    public Optional<Places> findByVehiculeAndNumero(Vehicules vehicule, String numero);
}
