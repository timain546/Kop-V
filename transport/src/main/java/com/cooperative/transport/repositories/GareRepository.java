package com.cooperative.transport.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Gares;

public interface GareRepository extends JpaRepository<Gares, Long> {

    public Optional<Gares> findByVille(String ville);
}
