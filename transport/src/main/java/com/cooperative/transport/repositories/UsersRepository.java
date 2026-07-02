package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Utilisateurs;

public interface UsersRepository extends JpaRepository<Utilisateurs, Long> {

    Utilisateurs findByEmail(String email);

}