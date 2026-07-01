package com.cooperative.transport.controllers;

import com.cooperative.transport.services.EmployesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.cooperative.transport.entities.Employes;
import java.util.List;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class EmployesController {
    @Autowired
    private EmployesService employesService;
    
    @GetMapping("/employes/test-simple")
    @ResponseBody
    public String testSimple() {
        System.out.println("=== /employes/test-simple appelé ===");
        return "✅ Le controller est chargé !";
    }

    @GetMapping("/employes/list")
    public String getListeEmployes(Model model) {
        List<Object[]> employes = employesService.findEmp();
        model.addAttribute("listeEmployes", employes);
        return "list-employes";
    }
}