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
    
    
        if (user == null) {
            session.setAttribute("erreur", "Veuillez vous connecter pour accéder à cette page.");
            response.sendRedirect(request.getContextPath() + "/");
            return false; 
        }
        
        String role = user.getRole().getLibelle().toLowerCase();
        
        if (uri.contains("/admin") && !role.equals("admin")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Vous devez être Administrateur.");
        }
        
        if (uri.contains("/guichet") && !role.equals("guichet")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Réservé au personnel de Guichet.");
        }
        
       if (uri.contains("/rh") && !role.equals("rh")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Réservé aux Ressources Humaines.");
        }

         if (uri.contains("/re") && !role.equals("re")) {
            return redirigerAvecErreur(request, response, session, "Accès refusé. Réservé au Responsable d'Exploitation.");
        }
        
        return true; 
    }

    // Petite méthode utilitaire pour éviter de répéter le code de redirection
    private boolean redirigerAvecErreur(HttpServletRequest request, HttpServletResponse response, HttpSession session, String message) throws Exception {
        session.setAttribute("erreur", message);
        // On le renvoie vers son propre dashboard légitime au lieu de le déconnecter
        Utilisateurs user = (Utilisateurs) session.getAttribute("utilisateur");
        String redirectionTarget = "/" + user.getRole().getLibelle().toLowerCase() + "/";
        
        response.sendRedirect(request.getContextPath() + redirectionTarget);
        return false;
    }
}