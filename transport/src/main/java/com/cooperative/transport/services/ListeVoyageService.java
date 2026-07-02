package com.cooperative.transport.services;

import com.cooperative.transport.dto.VoyageDTO;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cooperative.transport.repositories.VoyageRepository;

@Service
public class ListeVoyageService {
    
    private final VoyageRepository voyageRepository;

    public ListeVoyageService(VoyageRepository voyageRepository){
        this.voyageRepository = voyageRepository;
    }

    public List<VoyageDTO> getVoyages(String date1, String date2, Integer nbPlaces, String villeDepart, String villeArrivee) {
        return voyageRepository.findByDateBetween(date1, date2, villeDepart, villeArrivee, nbPlaces);
    }
}
