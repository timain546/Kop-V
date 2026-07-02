package com.cooperative.transport.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.repositories.UsersRepository;
@Service
public class LoginService {

    @Autowired
    private UsersRepository usersRepo;

    public Utilisateurs login(String email, String motDePasse) {
        Utilisateurs user = usersRepo.findByEmail(email);

        if (user != null && user.getMotDePasse().equals(motDePasse)) {
            return user;
        }
  
  return null;
    }


    

}