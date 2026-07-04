package com.cooperative.transport.services;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.cooperative.transport.repositories.UtilisateursRepository;

import com.cooperative.transport.entities.Utilisateurs;
import java.util.List;

@Service
public class UtilisateurService {
    @Autowired
    private UtilisateursRepository utilisateurrepository;
    public List<Utilisateurs> findAllChauffeurDispo(java.time.LocalDateTime dateCible) {
        return utilisateurrepository.findAllChauffeurDispo(dateCible);
    }
}