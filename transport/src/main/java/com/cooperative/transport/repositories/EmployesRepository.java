package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Employes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
@Repository
public interface EmployesRepository extends JpaRepository<Employes, Long> {
    @Query("SELECT DISTINCT e,s,r FROM Employes e LEFT JOIN e.salaires s JOIN e.role r where s.date_modification = (SELECT MAX(s2.date_modification) FROM Salaires s2 WHERE s2.employe.id = e.id ) or s is null")
    List<Object[]> findEmploye();
}