package com.cooperative.transport.services;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.cooperative.transport.repositories.EmployeStatutRepository;

import com.cooperative.transport.entities.EmployeStatut;

@Service
public class EmployeStatutService {
    @Autowired
    private EmployeStatutRepository employeStatutRepository;
    public Integer findIdbyIdemp(Integer employeId) {
        return employeStatutRepository.findIdByIdEmp(employeId);
    }
    public void updateEmployeStatut(EmployeStatut employeStatut) {
        employeStatutRepository.save(employeStatut);
    }

}
