package com.cooperative.transport.controllers;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooperative.transport.entities.ContratsEmployes;
import com.cooperative.transport.entities.EmployeStatut;
import com.cooperative.transport.entities.Role;
import com.cooperative.transport.entities.Salaires;
import com.cooperative.transport.entities.StatutEmploye;
import com.cooperative.transport.entities.Utilisateurs;
import com.cooperative.transport.services.ContratService;
import com.cooperative.transport.services.EmployeStatutService;
import com.cooperative.transport.services.EmployesService;
import com.cooperative.transport.services.RoleService;
import com.cooperative.transport.services.SalaireService;
import com.cooperative.transport.services.StatutEmployeService;

@Controller
@RequestMapping("/admin")
public class EmployesController {

    @Autowired
    private EmployesService employesService;
    @Autowired
    private RoleService roleservice;
    @Autowired
    private SalaireService salaireService;
    @Autowired
    private EmployeStatutService employeStatutService;
    @Autowired
    private StatutEmployeService statutEmployeService;
    @Autowired
    private ContratService contratService;
    

    @GetMapping("/employes/test-simple")
    @ResponseBody
    public String testSimple() {
        System.out.println("=== /employes/test-simple appelé ===");
        return "✅ Le controller est chargé !";
    }

    @GetMapping("/employes/list")
    public String getListeEmployes(Model model) {
        List<Object[]> employes = employesService.findEmp();
        List<String> statut = new ArrayList<>();
        
        for (Object[] row : employes) {
            Utilisateurs employe = (Utilisateurs) row[0];
            Integer statutId = employeStatutService.findIdbyIdemp(employe.getId());
            
            // Sécurisation contre le Null ID
            if (statutId == null) {
                System.out.println("Aucun ID de statut pour l'employé " + employe.getNom());
                statut.add("Inconnu / Aucun");
            } else {
                StatutEmploye statutList = statutEmployeService.findStatutById(statutId);
                if (statutList != null) {
                    System.out.println("Statut pour l'employé " + employe.getNom() + ": " + statutList.getLibelle());
                    statut.add(statutList.getLibelle());
                } else {
                    statut.add("Statut introuvable");
                }
            }
        }
        model.addAttribute("statut", statut);
        model.addAttribute("listeEmployes", employes);
        return "admin/list-employes";
    }

    @PostMapping("/employes/modifier")
    public String modifierEmploye(@RequestParam("id") Integer id, @RequestParam("role") String role, Model model) {
        List<Object[]> employes = employesService.findByid(id);
        List<Role> roles = roleservice.findAllRoles(role);
        model.addAttribute("employe", employes.get(0));
        model.addAttribute("roles", roles);
        return "admin/modifier-employe";
    }

    @PostMapping("/employes/miseajour")
    public String miseAJourEmploye(@RequestParam("id") Integer id,
            @RequestParam("nom") String nom,
            @RequestParam("prenom") String prenom,
            @RequestParam("email") String email,
            @RequestParam("role") Integer roleId,
            @RequestParam("salaire") Double montant,
            @RequestParam("date") java.sql.Date date,
            @RequestParam("mdp") String motDePasse
    ) {

        Utilisateurs employe = employesService.findEmpById(id);
        employe.setNom(nom);
        employe.setPrenom(prenom);
        employe.setEmail(email);
        employe.setMotDePasse(motDePasse);


        Salaires SalActuel = salaireService.findByIdEmp(id);
        if (SalActuel == null) {
            Salaires salaire = new Salaires();
            salaire.setEmploye(employe);
            salaire.setSalaire(montant);
            salaire.setDateModification(date);
            salaireService.saveSalaire(salaire);
        } else {
            if(SalActuel.getSalaire() != montant) {
                if(SalActuel.getDateModification().equals(date)){
                    SalActuel.setSalaire(montant);
                    salaireService.saveSalaire(SalActuel);
                }
                else{
                    Salaires salaire = new Salaires();
                    salaire.setEmploye(employe);
                    salaire.setSalaire(montant);
                    salaire.setDateModification(date);
                    salaireService.saveSalaire(salaire);
                }

            }
            else{
                SalActuel.setDateModification(date);
                salaireService.saveSalaire(SalActuel);
            }
        }

        Role role = new Role();
        role.setId(roleId);
        employe.setRole(role);
        employesService.updateEmploye(employe);

        return "redirect:/admin/employes/list";
    }

    @PostMapping("/employes/supprimerEmploye")
    public String supprimerEmploye(@RequestParam("id") Integer id) {
      ContratsEmployes contrat = contratService.findContratByIdEmp(id);
      contrat.setDateRenvoie(new java.sql.Date(System.currentTimeMillis()));
      contratService.saveContrat(contrat);
      EmployeStatut employeStatut = new EmployeStatut();
      employeStatut.setDateModification(new java.sql.Date(System.currentTimeMillis()));
      employeStatut.setEmploye(employesService.findEmpById(id));
      employeStatut.setStatutEmploye(statutEmployeService.findStatutById(2));
      employeStatutService.updateEmployeStatut(employeStatut);
      return "redirect:/admin/employes/list";
    }
    @GetMapping("/employes/form")
    public String afficherFormulaire(Model model) {
        List<Role> roles = roleservice.findAll();
        model.addAttribute("roles", roles);
        return "admin/ajouter-employe";
    }
    @PostMapping("/employes/ajouter")
    public String ajouterEmploye(@RequestParam("nom") String nom,
                                 @RequestParam("prenom") String prenom,
                                 @RequestParam("email") String email,
                                 @RequestParam("mdp") String motDePasse,
                                 @RequestParam("role") Integer roleId,
                                 @RequestParam("salaire") Double montant,
                                 @RequestParam("dateEmbauche") java.sql.Date dateEmbauche) {
        Utilisateurs employe = new Utilisateurs();
        employe.setNom(nom);
        employe.setPrenom(prenom);
        employe.setEmail(email);
        employe.setMotDePasse(motDePasse);
        Role role = new Role();
        role.setId(roleId);
        employe.setRole(role);
        employesService.updateEmploye(employe);
        Salaires salaire = new Salaires();
        salaire.setEmploye(employe);
        salaire.setSalaire(montant);
        salaire.setDateModification(dateEmbauche);
        salaireService.saveSalaire(salaire);

        ContratsEmployes contrat = new ContratsEmployes();
        contrat.setEmploye(employe);
        contrat.setDateEmbauche(dateEmbauche);
        contratService.updateContrat(contrat);
        EmployeStatut employeStatut = new EmployeStatut();
        employeStatut.setEmploye(employe);
        employeStatut.setStatutEmploye(statutEmployeService.findStatutById(1));
        employeStatut.setDateModification(dateEmbauche);
        employeStatutService.updateEmployeStatut(employeStatut);
        return "redirect:/admin/employes/list";
    }
    @PostMapping("/employes/reembaucher")
    public String reembaucherEmploye(@RequestParam("id") Integer id) {
        ContratsEmployes contrat = new ContratsEmployes();
        contrat.setEmploye(employesService.findEmpById(id));
        contrat.setDateRenvoie(null);
        contrat.setDateEmbauche(new java.sql.Date(System.currentTimeMillis()));
        contratService.saveContrat(contrat);

        EmployeStatut employeStatut = new EmployeStatut();
        employeStatut.setEmploye(employesService.findEmpById(id));
        employeStatut.setStatutEmploye(statutEmployeService.findStatutById(3));
        employeStatut.setDateModification(new java.sql.Date(System.currentTimeMillis()));
        employeStatutService.updateEmployeStatut(employeStatut);

        return "redirect:/admin/employes/list";
    }

}
