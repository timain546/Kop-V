package com.cooperative.transport.repositories;
import com.cooperative.transport.entities.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
@Repository
public interface RolesRepository extends JpaRepository<Roles, Long> {
@Query("SELECT r FROM Roles r WHERE r.libelle!= :nom")
    List<Roles> findRole(@Param("nom") String nom);
}