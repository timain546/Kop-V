package com.cooperative.transport.services;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.cooperative.transport.repositories.EtudiantsRepository;
import com.cooperative.transport.entities.Etudiants;

import java.util.List;

@Service
public class EtudiantsService {

    @Autowired
    private EtudiantsRepository etudiantsRepo;

    public List<Etudiants> findAllEtudiants() {
        return etudiantsRepo.findAll();
    }
}