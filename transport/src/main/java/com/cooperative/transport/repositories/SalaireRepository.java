package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Salaires;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

@Repository
public interface SalaireRepository extends JpaRepository<Salaires, Integer> {
    @Query("Select s from Salaires s where s.employe.id=:id order by s.dateModification desc limit 1")
    Salaires findByIdEmp(@Param("id") Integer id);
}
