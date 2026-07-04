package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.ContratEmploye;

public interface ContratEmployeRepository extends JpaRepository<ContratEmploye, Long> {
    ContratEmploye findTopByEmployeIdOrderByDateEmbaucheDesc(Integer id);
}