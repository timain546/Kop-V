package com.cooperative.transport.repositories;
import com.cooperative.transport.entities.ContratEmploye;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
@Repository
public interface ContratRepository extends JpaRepository<ContratEmploye, Long> {
    @Query("Select c from ContratEmploye c where c.employe.id=:id order by c.date_embauche desc limit 1")
    ContratEmploye findByIdEmp(@Param("id") Long id);
}