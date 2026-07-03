package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.CategorieVehicule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategorieVehiculeRepository extends JpaRepository<CategorieVehicule, Long> {
}
