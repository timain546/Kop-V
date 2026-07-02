package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Gare;

public interface GareRepository extends JpaRepository<Gare, Long> {
}
