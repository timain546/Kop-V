package com.cooperative.transport.services;
import com.cooperative.transport.entities.Roles;
import com.cooperative.transport.repositories.RolesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RoleService {
    @Autowired
    private RolesRepository rolesRepository;
    public List<Roles> findAllRoles(String libelle) {
        return rolesRepository.findRole(libelle);
    }
    public List<Roles> findAll() {
        return rolesRepository.findAll();
    }
}