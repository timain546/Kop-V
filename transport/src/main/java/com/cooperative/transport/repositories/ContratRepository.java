package com.cooperative.transport.repositories;
import com.cooperative.transport.entities.ContratsEmployes;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
@Repository
public interface ContratRepository extends JpaRepository<ContratsEmployes, Integer> {
    @Query("Select c from ContratsEmployes c where c.employe.id=:id order by c.dateEmbauche desc limit 1")
    ContratsEmployes findByIdEmp(@Param("id") Integer id);
}
