package com.cooperative.transport.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cooperative.transport.entities.Client;

public interface ClientRepository extends JpaRepository<Client, Long> {

    public Optional<Client> findByTelephone(String telephone);
}
