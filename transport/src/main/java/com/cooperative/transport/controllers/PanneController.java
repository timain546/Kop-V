package com.cooperative.transport.controllers;

import java.util.List;

import com.cooperative.transport.entities.Pannes;
import com.cooperative.transport.services.PanneService;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/re")
public class PanneController {

    @Autowired
    private PanneService panneService;

    @GetMapping("/panne/list")
    public String getListPannes(Model model) {
        List<Pannes> pannes = panneService.findAllPannesSignale();
        model.addAttribute("pannes", pannes);
        return "re/carte-pannes";
    }
}