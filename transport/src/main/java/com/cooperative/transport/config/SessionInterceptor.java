package com.cooperative.transport.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.cooperative.transport.entities.Utilisateurs;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Utilisateurs user = (Utilisateurs) session.getAttribute("utilisateur");

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();

        if (uri.equals(contextPath + "/") || uri.equals(contextPath + "/login")) {
            return true;
        }

        if(user == null) {
            session.setAttribute("erreur", "Vous devez être connecté pour accéder à cette page.");
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }


        String role = user.getRole().getLibelle().toLowerCase();

        if (uri.startsWith("/admin") && !role.equals("admin")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Vous devez être Administrateur.");
        }

        if (uri.startsWith("/guichet") && !role.equals("guichet")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Réservé au personnel de Guichet.");
        }

        if (uri.startsWith("/chauffeur") && !role.equals("chauffeur")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Réservé aux Chauffeurs.");
        }

        if (uri.startsWith("/re") && !role.equals("re")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Réservé au Responsable d'Exploitation.");
        }

        return true;
    }

    // Petite méthode utilitaire pour éviter de répéter le code de redirection
    private boolean redirigerAvecErreur(HttpServletRequest request, HttpServletResponse response, HttpSession session, String message) throws Exception {
        session.setAttribute("erreur", message);
        Utilisateurs user = (Utilisateurs) session.getAttribute("utilisateur");
        String redirectionTarget = switch (user.getRole().getLibelle().toLowerCase()) {
            case "admin"      -> "/admin/employes/list";
            case "guichet"    -> "/guichet/reservation";
            case "re"         -> "/re/voyage/list";
            case "chauffeur"  -> "/chauffeur/dashboard";
            default           -> "/login";
        };

        response.sendRedirect(request.getContextPath() + redirectionTarget);
        return false;
    }
}
