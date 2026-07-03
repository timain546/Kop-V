package com.cooperative.transport.services;
import com.cooperative.transport.entities.ContratEmploye;
import com.cooperative.transport.repositories.ContratRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ContratService {
    @Autowired
    private ContratRepository contratRepository;
    public List<ContratEmploye> findAllContrats() {
        return contratRepository.findAll();
    }
    public void saveContrat(ContratEmploye contrat) {
        contratRepository.save(contrat);
    }
    public ContratEmploye findContratById(Long id) {
        return contratRepository.findById(id).orElse(null);
    }
    public ContratEmploye findContratByIdEmp(Long id) {
        return contratRepository.findByIdEmp(id);
    }
    public void updateContrat(ContratEmploye contrat) {
        contratRepository.save(contrat);
    }
}