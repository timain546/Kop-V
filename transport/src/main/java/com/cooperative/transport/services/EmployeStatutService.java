package com.cooperative.transport.services;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.cooperative.transport.repositories.EmployeStatutRepository;

import com.cooperative.transport.entities.EmployeStatut;

import java.util.List;

import org.springframework.data.annotation.Id;
@Service
public class EmployeStatutService {
    @Autowired
    private EmployeStatutRepository employeStatutRepository;
    public Integer findIdbyIdemp(Integer employeId) {
        return employeStatutRepository.findIdbyIdemp(employeId);
    }
    public void updateEmployeStatut(EmployeStatut employeStatut) {
        employeStatutRepository.save(employeStatut);
    }

}