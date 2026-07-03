package com.cooperative.transport.services;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.cooperative.transport.repositories.EmployesRepository;

import com.cooperative.transport.entities.Employes;
import java.util.List;

@Service
public class EmployesService {
    @Autowired
    private EmployesRepository employesRepo;
    public List<Object[]> findEmp() {
        return employesRepo.findEmploye();
    }
    public List<Object[]> findByid(Long id) {
        return employesRepo.findEmployeById(id);
    }
    public Employes findempById(Long id) {
        return employesRepo.findById(id).orElse(null);
    }
    public void updateEmploye(Employes employe) {
        employesRepo.save(employe);
    }
}