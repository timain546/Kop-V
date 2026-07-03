package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Gare;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GareRepository extends JpaRepository<Gare, Long> {
}
