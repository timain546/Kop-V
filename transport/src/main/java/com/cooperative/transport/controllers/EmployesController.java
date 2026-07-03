package com.cooperative.transport.controllers;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.cooperative.transport.entities.Roles;
import com.cooperative.transport.entities.Salaires;
import com.cooperative.transport.services.EmployesService;
import com.cooperative.transport.services.RoleService;
import com.cooperative.transport.services.SalaireService;
import com.cooperative.transport.services.EmployeStatutService;
import com.cooperative.transport.services.StatutEmployeService;
import com.cooperative.transport.services.ContratService;
import com.cooperative.transport.entities.StatutEmploye;
import com.cooperative.transport.entities.Employes;
import com.cooperative.transport.entities.ContratEmploye;
import java.util.ArrayList;
import com.cooperative.transport.entities.EmployeStatut;
import java.sql.Date;

@Controller
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
            Employes employe = (Employes) row[0];
            Integer statutId = employeStatutService.findIdbyIdemp(employe.getId());
            StatutEmploye statutList = statutEmployeService.findStatutById(statutId);
            System.out.println("Statut pour l'employé " + employe.getNom() + ": " + (statutList != null ? statutList.getLibelle() : "Aucun statut trouvé"));
            statut.add(statutList.getLibelle());

        }
        model.addAttribute("statut", statut);
        model.addAttribute("listeEmployes", employes);
        return "list-employes";
    }

    @PostMapping("/employes/modifier")
    public String modifierEmploye(@RequestParam("id") Long id, @RequestParam("role") String role, Model model) {
        List<Object[]> employes = employesService.findByid(id);
        List<Roles> roles = roleservice.findAllRoles(role);
        model.addAttribute("employe", employes.get(0));
        model.addAttribute("roles", roles);
        return "modifier-employe";
    }

    @PostMapping("/employes/miseajour")
    public String miseAJourEmploye(@RequestParam("id") Long id,
            @RequestParam("nom") String nom,
            @RequestParam("prenom") String prenom,
            @RequestParam("email") String email,
            @RequestParam("role") Integer roleId,
            @RequestParam("salaire") Double montant,
            @RequestParam("date") java.sql.Date date
    ) {

        Employes employe = employesService.findempById(id);
        employe.setNom(nom);
        employe.setPrenom(prenom);
        employe.setEmail(email);

        Salaires SalActuel = salaireService.findByIdEmp(id);
        if (SalActuel == null) {
            Salaires salaire = new Salaires();
            salaire.setEmploye(employe);
            salaire.setSalaire(montant);
            salaire.setDate_modification(date);
            salaireService.saveSalaire(salaire);
        } else {
            if(SalActuel.getSalaire() != montant) {
                if(SalActuel.getDate_modification().equals(date)){
                    SalActuel.setSalaire(montant);
                    salaireService.saveSalaire(SalActuel);
                }
                else{
                    Salaires salaire = new Salaires();
                    salaire.setEmploye(employe);
                    salaire.setSalaire(montant);
                    salaire.setDate_modification(date);
                    salaireService.saveSalaire(salaire);
                }

            }
            else{
                SalActuel.setDate_modification(date);
                salaireService.saveSalaire(SalActuel);
            }
        }

        Roles role = new Roles();
        role.setId(roleId);
        employe.setRole(role);
        employesService.updateEmploye(employe);

        return "redirect:/employes/list";
    }

    @PostMapping("/employes/supprimerEmploye")
    public String supprimerEmploye(@RequestParam("id") Long id) {
      ContratEmploye contrat = contratService.findContratByIdEmp(id);
      contrat.setDate_renvoie(new java.sql.Date(System.currentTimeMillis()));
      contratService.saveContrat(contrat);
      EmployeStatut employeStatut = new EmployeStatut();
      employeStatut.setDate_modification(new java.sql.Date(System.currentTimeMillis()));
      employeStatut.setEmploye(employesService.findempById(id));
      employeStatut.setStatutEmploye(statutEmployeService.findStatutById(2));
      employeStatutService.updateEmployeStatut(employeStatut);
      return "redirect:/employes/list";
    }
    @GetMapping("/employes/form")
    public String afficherFormulaire(Model model) {
        List<Roles> roles = roleservice.findAll();
        model.addAttribute("roles", roles);
        return "ajouter-employe";
    }
    @PostMapping("/employes/ajouter")
    public String ajouterEmploye(@RequestParam("nom") String nom,
                                 @RequestParam("prenom") String prenom,
                                 @RequestParam("email") String email,
                                //  @RequestParam("motDePasse") String motDePasse,
                                 @RequestParam("role") Integer roleId,
                                 @RequestParam("salaire") Double montant,
                                 @RequestParam("date_embauche") java.sql.Date dateEmbauche) {
        Employes employe = new Employes();
        employe.setNom(nom);
        employe.setPrenom(prenom);
        employe.setEmail(email);
        // employe.setMotDePasse(motDePasse);
        Roles role = new Roles();
        role.setId(roleId);
        employe.setRole(role);
        employesService.updateEmploye(employe);
        Salaires salaire = new Salaires();
        salaire.setEmploye(employe);
        salaire.setSalaire(montant);
        salaire.setDate_modification(dateEmbauche);
        salaireService.saveSalaire(salaire);

        ContratEmploye contrat = new ContratEmploye();
        contrat.setEmploye(employe);
        contrat.setDate_embauche(dateEmbauche);
        contratService.updateContrat(contrat);
        EmployeStatut employeStatut = new EmployeStatut();
        employeStatut.setEmploye(employe);
        employeStatut.setStatutEmploye(statutEmployeService.findStatutById(1));
        employeStatut.setDate_modification(dateEmbauche);
        employeStatutService.updateEmployeStatut(employeStatut);
        return "redirect:/employes/list";
    }
    @PostMapping("/employes/reembaucher")
    public String reembaucherEmploye(@RequestParam("id") Long id) {
        ContratEmploye contrat = new ContratEmploye();
        contrat.setEmploye(employesService.findempById(id));
        contrat.setDate_renvoie(null);
        contrat.setDate_embauche(new java.sql.Date(System.currentTimeMillis()));
        contratService.saveContrat(contrat);

        EmployeStatut employeStatut = new EmployeStatut();
        employeStatut.setEmploye(employesService.findempById(id));
        employeStatut.setStatutEmploye(statutEmployeService.findStatutById(3));
        employeStatut.setDate_modification(new java.sql.Date(System.currentTimeMillis()));
        employeStatutService.updateEmployeStatut(employeStatut);

        return "redirect:/employes/list";
    }

}
