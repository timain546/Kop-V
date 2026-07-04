package com.cooperative.transport.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.cooperative.transport.entities.EmployeStatut;
import com.cooperative.transport.entities.StatutEmploye;
import com.cooperative.transport.entities.Utilisateurs;
import org.springframework.data.repository.query.Param;

@Repository
public interface EmployeStatutRepository extends JpaRepository<EmployeStatut, Integer> {
    @Query(value = "SELECT es.id_statut FROM employe_statut es WHERE es.id_employe =:employeId ORDER BY es.date_modification DESC LIMIT 1", nativeQuery = true)
    Integer findIdByIdEmp(@Param("employeId") Integer employeId);
}
