package com.cooperative.transport.repositories;

import com.cooperative.transport.entities.Role;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {
    @Query("SELECT r FROM Role r WHERE r.libelle!= :nom")
    List<Role> findRole(@Param("nom") String nom);
    @Query("SELECT r FROM Role r WHERE r.id = :id")
    Role findRoleById(@Param("id") Integer id);
}
