package com.cooperative.transport.services;
import com.cooperative.transport.entities.ContratsEmployes;
import com.cooperative.transport.repositories.ContratRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ContratService {
    @Autowired
    private ContratRepository contratRepository;
    public List<ContratsEmployes> findAllContrats() {
        return contratRepository.findAll();
    }
    public void saveContrat(ContratsEmployes contrat) {
        contratRepository.save(contrat);
    }
    public ContratsEmployes findContratById(Integer id) {
        return contratRepository.findById(id).orElse(null);
    }
    public ContratsEmployes findContratByIdEmp(Integer id) {
        return contratRepository.findByIdEmp(id);
    }
    public void updateContrat(ContratsEmployes contrat) {
        contratRepository.save(contrat);
    }
}
