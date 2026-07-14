package com.cooperative.transport.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cooperative.transport.entities.ContratsEmployes;
import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.services.LoginService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/")
    public String loginPage(HttpSession session, Model model) {
        Utilisateurs user = (Utilisateurs) session.getAttribute("utilisateur");
        if (user != null && user.getRole() != null) {
            String roleLibelle = user.getRole().getLibelle().toLowerCase();
            return switch (roleLibelle) {
                case "admin"      -> "redirect:/admin/employes/list";
                case "guichet"    -> "redirect:/guichet/reservation";
                case "re"         -> "redirect:/re/voyage/list";
                case "chauffeur"  -> "redirect:/chauffeur/dashboard";
                default           -> {
                    model.addAttribute("erreur", "Rôle non reconnu.");
                    yield "login";
                }
            };
        }
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

        if (user == null) {
            model.addAttribute("erreur", "Email ou mot de passe incorrect.");
            return "login";
        }

        ContratsEmployes contrat = loginService.getLatestContratEmploye(user);

        if (contrat == null || contrat.getDateRenvoie() != null) {
            model.addAttribute("erreur", "Votre contrat n'est plus valide. Veuillez contacter l'administrateur.");
            return "login";
        }

        session.setAttribute("utilisateur", user);
        String roleLibelle = user.getRole().getLibelle().toLowerCase();

        return switch (roleLibelle) {
            case "admin"      -> "redirect:/admin/employes/list";
            case "guichet"    -> "redirect:/guichet/reservation";
            case "re"         -> "redirect:/re/voyage/list";
            case "chauffeur"  -> "redirect:/chauffeur/dashboard";
            default           -> {
                model.addAttribute("erreur", "Rôle non reconnu.");
                yield "login";
            }
        };
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}
