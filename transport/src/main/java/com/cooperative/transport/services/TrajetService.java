package com.cooperative.transport.services;

import com.cooperative.transport.entities.Trajet;
import com.cooperative.transport.repositories.TrajetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

// ⚠️ TEMPORAIRE — juste pour que TarifController compile et fonctionne en attendant
// mon binôme, qui adaptera / remplacera cette classe avec sa vraie logique.
@Service
public class TrajetService {

    @Autowired
    private TrajetRepository trajetRepository;

    public List<Trajet> listerTrajets() {
        return trajetRepository.findAll();
    }

    public Trajet rechercherParId(Long id) {
        return trajetRepository.findById(id).orElse(null);
    }
}