package com.cooperative.transport.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Client;

public interface ClientRepository extends JpaRepository<Client, Long> {
}
