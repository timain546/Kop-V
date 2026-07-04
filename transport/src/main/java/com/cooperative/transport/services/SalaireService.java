package com.cooperative.transport.services;
import com.cooperative.transport.entities.Salaires;
import com.cooperative.transport.repositories.SalairesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SalaireService {
    @Autowired
    private SalairesRepository salairesRepository;
    public List<Salaires> findAllSalaires() {   
        return salairesRepository.findAll();
    }
    public void saveSalaire(Salaires salaire) {
        salairesRepository.save(salaire);
    }
    public Salaires findSalaireById(Long id) {
        return salairesRepository.findById(id).orElse(null);
    }
    public Salaires findByIdEmp(Long id) {
        return salairesRepository.findByIdEmp(id);
    }
}
