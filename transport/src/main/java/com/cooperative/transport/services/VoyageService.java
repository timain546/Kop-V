package com.cooperative.transport.services;

import com.cooperative.transport.dto.VoyageDTO;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.cooperative.transport.repositories.VoyageRepository;

@Service
public class VoyageService {

    private final VoyageRepository voyageRepository;

    public VoyageService(VoyageRepository voyageRepository) {
        this.voyageRepository = voyageRepository;
    }

    public List<VoyageDTO> getVoyagesDisponibles(LocalDate date1, LocalDate date2, Integer nbPlaces, String villeDepart, String villeArrivee) {
        return voyageRepository.findByDateBetweenAndVilleAndNbPlaces(date1, date2, villeDepart, villeArrivee, nbPlaces);
    }
}
