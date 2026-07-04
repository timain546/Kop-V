package com.cooperative.transport.services;

import java.util.List;
import java.time.LocalDate;
import java.util.Optional;

import com.cooperative.transport.entities.Voyages;
import com.cooperative.transport.entities.Trajets;
import com.cooperative.transport.repositories.TrajetRepository;
import com.cooperative.transport.repositories.VoyageRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TrajetService {
    @Autowired
    private TrajetRepository trajetRepo;

    @Autowired
    private VoyageRepository voyageRepo;

    public List<Trajets> findAllTrajets() {
        return trajetRepo.findAllTrajets();
    }

    public Optional<Trajets> findTrajetById(Integer id) {
        return trajetRepo.findById(id);
    }

    public void supprimerTrajet(Integer id) throws Exception {
        List<Voyages> voyagesPrevus = voyageRepo.findAllVoyagePrevusByTrajet(id);

        if(!voyagesPrevus.isEmpty()) {
            throw new Exception("Le trajet T-00" + id + " est déjà assigné à un voyage");
        }

        Optional<Trajets> trajetOptional = trajetRepo.findById(id);

        Trajets trajet = trajetOptional.get();
        trajet.setDateSuppression(LocalDate.now());

        // Mettre à jour la date de suppression du trajet dans la base
        trajetRepo.save(trajet);
    }
}
