package com.cooperative.transport.services;
import com.cooperative.transport.entities.StatutEmploye;
import com.cooperative.transport.repositories.StatutEmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class StatutEmployeService {
    @Autowired
    private StatutEmployeRepository statutEmployeRepository;
    public List<StatutEmploye> findAllStatuts() {
        return statutEmployeRepository.findAll();
    }
    public void saveStatut(StatutEmploye statut) {
        statutEmployeRepository.save(statut);
    }
    public StatutEmploye findStatutById(Integer id) {
        return statutEmployeRepository.findById(id).orElse(null);
    }
}
