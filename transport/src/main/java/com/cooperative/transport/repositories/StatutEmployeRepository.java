package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.cooperative.transport.entities.StatutEmploye;

@Repository
public interface StatutEmployeRepository extends JpaRepository<StatutEmploye,Integer> {
}
