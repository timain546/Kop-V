package com.cooperative.transport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.PlaceStatut;
import com.cooperative.transport.entities.Voyage;

public interface PlaceStatutRepository extends JpaRepository<PlaceStatut, Long> {

    public List<PlaceStatut> findByVoyage(Voyage voyage);
}
