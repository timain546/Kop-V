package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Place;

public interface PlaceRepository extends JpaRepository<Place, Long> {
}
