package com.cooperative.transport.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.services.LoginService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/")
    public String loginPage(HttpSession session, Model model) {
        if (session.getAttribute("erreur") != null) {
            model.addAttribute("erreur", session.getAttribute("erreur"));
            session.removeAttribute("erreur"); 
        }
        return "login";
    }

  @PostMapping("/login")
public String login(
        @RequestParam String email,
        @RequestParam String password,
        HttpSession session,
        Model model) {

    Utilisateurs user = loginService.login(email, password);

    if (user != null) {
        session.setAttribute("utilisateur", user);

       String roleLibelle = user.getRole().getLibelle().toLowerCase();

        switch (roleLibelle) {
            case "admin":
                return "redirect:/admin/";
            case "guichet":
                return "redirect:/guichet/";
            case "rh":
                return "redirect:/rh/";
            case "re":
                return "redirect:/re/";
            case "chauffeur":
                return "redirect:/chauffeur/";
         }
    }

    model.addAttribute("erreur", "Email ou mot de passe incorrect.");
    return "login";
}

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}