package com.cooperative.transport.services;

import com.cooperative.transport.entities.StatutVoyage;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cooperative.transport.repositories.StatutVoyageRepository;

@Service
public class StatuVoyageService {

    @Autowired
    private StatutVoyageRepository statutVoyageRepository;

    Optional<StatutVoyage> findAllStatutVoyage() {
        return statutVoyageRepository.findByLibelle(null);
    }
}
