package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Places;
import org.springframework.data.jpa.repository.JpaRepository;



public interface PlaceRepository extends JpaRepository<Places, Long> {
}
