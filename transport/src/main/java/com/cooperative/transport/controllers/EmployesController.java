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
import com.cooperative.transport.services.ContratEmployeService;
import com.cooperative.transport.services.EmployeStatutService;
import com.cooperative.transport.services.EmployesService;
import com.cooperative.transport.services.RoleService;
import com.cooperative.transport.services.SalaireService;
import com.cooperative.transport.services.StatutEmployeService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

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
    private ContratEmployeService contratService;
    public String EMAIL_REGEX = 
        "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";

    @GetMapping("/employes/test-simple")
    @ResponseBody
    public String testSimple() {
        System.out.println("=== /employes/test-simple appelé ===");
        return "✅ Le controller est chargé !";
    }

  @GetMapping("/employes/list")
public String getListeEmployes(
        @RequestParam(required = false) String nom,
        @RequestParam(required = false) String prenom,
        @RequestParam(required = false) String email,
        @RequestParam(required = false) Double salaireMin,
        @RequestParam(required = false) Double salaireMax,
        @RequestParam(defaultValue = "1") int page,     
        @RequestParam(defaultValue = "10") int size,    
        Model model) {

  
    int pageIndexInterne = (page < 1) ? 0 : page - 1; 

    // Création du Pageable avec l'index interne de Spring (qui commence à 0)
    Pageable pageable = PageRequest.of(pageIndexInterne, size);

    // Récupération de la page de données
    Page<Object[]> employesPage = employesService.findwithcritere(nom, prenom, email, salaireMin, salaireMax, pageable);
    
    List<Object[]> employes = employesPage.getContent();
    List<String> statut = new ArrayList<>();

    for (Object[] row : employes) {
        Utilisateurs employe = (Utilisateurs) row[0];
        Integer statutId = employeStatutService.findIdbyIdemp(employe.getId());

        if (statutId == null) {
            statut.add("Inconnu / Aucun");
        } else {
            StatutEmploye statutList = statutEmployeService.findStatutById(statutId);
            statut.add(statutList != null ? statutList.getLibelle() : "Statut introuvable");
        }
    }

    // Données de recherche
    model.addAttribute("nomRecherche", nom);
    model.addAttribute("prenomRecherche", prenom);
    model.addAttribute("emailRecherche", email);
    model.addAttribute("salaireMinRecherche", salaireMin);
    model.addAttribute("salaireMaxRecherche", salaireMax);
    model.addAttribute("statut", statut);
    model.addAttribute("listeEmployes", employes);

    
    model.addAttribute("currentPage", pageIndexInterne + 1);             // Page humaine (1, 2, 3...)
    model.addAttribute("totalPages", employesPage.getTotalPages());      // Total des pages
    model.addAttribute("pageSize", size);                                // Éléments par page
    model.addAttribute("totalElements", employesPage.getTotalElements());// Total global

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
            @RequestParam("mdp") String motDePasse,
            Model model
    ) {
        if(montant<=0){
            List<Object[]> employes = employesService.findByid(id);
            List<Role> roles = roleservice.findAll();
            model.addAttribute("employe", employes.get(0));
            model.addAttribute("roles", roles);
            model.addAttribute("errorMessage", "Le salaire invalide");
            return "admin/modifier-employe";

        }
        if(!email.matches(EMAIL_REGEX)) {
            List<Object[]> employes = employesService.findByid(id);
            List<Role> roles = roleservice.findAll();
            model.addAttribute("employe", employes.get(0));
            model.addAttribute("roles", roles);
            model.addAttribute("errorMessage", "L'adresse email n'est pas valide.");
            return "admin/modifier-employe";
        }
        else{
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
                                 @RequestParam("role") String roleLibelle,
                                 @RequestParam("salaire") Double montant,
                                 @RequestParam("dateEmbauche") java.sql.Date dateEmbauche,
                                 Model model) {
        if(montant<=0){
            Role role=roleservice.findRoleById(roleId);
            model.addAttribute("role", role);
            model.addAttribute("roles", roleservice.findAll());
            model.addAttribute("nom", nom);
            model.addAttribute("prenom", prenom);
            model.addAttribute("email", email);
            model.addAttribute("mdp", motDePasse);
            model.addAttribute("salaire", montant.toString());
            model.addAttribute("dateEmbauche", dateEmbauche.toString());
            model.addAttribute("errorMessage", "Le salaire invalide.");
            return "admin/ajouter-employe";
        }
        if(!email.matches(EMAIL_REGEX)) {
            Role role=roleservice.findRoleById(roleId);
            model.addAttribute("role", role);
            model.addAttribute("roles", roleservice.findAll());
            model.addAttribute("nom", nom);
            model.addAttribute("prenom", prenom);
            model.addAttribute("email", email);
            model.addAttribute("mdp", motDePasse);
            model.addAttribute("salaire", montant.toString());
            model.addAttribute("dateEmbauche", dateEmbauche.toString());
            model.addAttribute("errorMessage", "L'adresse email n'est pas valide.");
            return "admin/ajouter-employe";
        }
        else{
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
