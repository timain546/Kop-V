package com.cooperative.transport.services;

import com.cooperative.transport.entities.Gares;
import com.cooperative.transport.repositories.GareRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class GareService {

    @Autowired
    private GareRepository gareRepo;

    public List<Gares> findAllGares() {
        return gareRepo.findAll();
    }
}
