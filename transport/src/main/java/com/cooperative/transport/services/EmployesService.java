package com.cooperative.transport.services;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.cooperative.transport.repositories.UtilisateurRepository;

import com.cooperative.transport.entities.Utilisateurs;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Service
public class EmployesService {
    @Autowired
    private UtilisateurRepository utilisateurRepository;
    public List<Object[]> findEmp() {
        return utilisateurRepository.findEmploye();
    }
    public List<Object[]> findByid(Integer id) {
        return utilisateurRepository.findEmployeById(id);
    }
    public Utilisateurs findEmpById(Integer id) {
        return utilisateurRepository.findById(id).orElse(null);
    }
    public void updateEmploye(Utilisateurs employe) {
        utilisateurRepository.save(employe);
    }
    public Page<Object[]> findwithcritere(String nom, String prenom, String email, Double salaireMin, Double salaireMax,Pageable pageable) {
        return utilisateurRepository.findwithcritere(nom, prenom, email, salaireMin, salaireMax,pageable);
    }
}
