package com.cooperative.transport.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.PlaceStatut;
import com.cooperative.transport.entities.Places;
import com.cooperative.transport.entities.Voyages;

public interface PlaceStatutRepository extends JpaRepository<PlaceStatut, Integer> {

    public List<PlaceStatut> findByVoyage(Voyages voyage);
    public Optional<PlaceStatut> findByVoyageAndPlace(Voyages voyage, Places place);
}
