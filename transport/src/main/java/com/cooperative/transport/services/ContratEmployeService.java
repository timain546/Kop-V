package com.cooperative.transport.services;
import com.cooperative.transport.entities.ContratsEmployes;
import com.cooperative.transport.repositories.ContratEmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ContratEmployeService {
    @Autowired
    private ContratEmployeRepository contratEmployeRepository;
    public List<ContratsEmployes> findAllContrats() {
        return contratEmployeRepository.findAll();
    }
    public void saveContrat(ContratsEmployes contrat) {
        contratEmployeRepository.save(contrat);
    }
    public ContratsEmployes findContratById(Integer id) {
        return contratEmployeRepository.findById(id).orElse(null);
    }
    public ContratsEmployes findContratByIdEmp(Integer id) {
        return contratEmployeRepository.findByIdEmp(id);
    }
    public void updateContrat(ContratsEmployes contrat) {
        contratEmployeRepository.save(contrat);
    }
}
