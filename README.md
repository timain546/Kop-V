# Kop-V
Projet Mme Baovola S4


# Modifier les en-tete des controllers :

@Controller
@RequestMapping("/admin") // Toutes les routes de ce contrôleur commenceront par /admin
public class AdminController {

    @GetMapping("/dashboard")
    public String adminDashboard() {
        return "admin-dashboard"; // Renvoie vers WEB-INF/jsp/admin-dashboard.jsp
    }
}