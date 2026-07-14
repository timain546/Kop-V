package com.cooperative.transport.services;
import com.cooperative.transport.entities.Role;
import com.cooperative.transport.repositories.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RoleService {
    @Autowired
    private RoleRepository rolesRepository;
    public List<Role> findAllRoles(String libelle) {
        return rolesRepository.findRole(libelle);
    }
    public List<Role> findAll() {
        return rolesRepository.findAll();
    }
    public Role findRoleById(Integer id) {
        return rolesRepository.findRoleById(id);
    }
}