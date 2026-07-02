package com.cooperative.transport.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        
       if (session.getAttribute("utilisateur") == null) {
            session.setAttribute("erreur", "Veuillez vous connecter pour accéder au tableau de bord.");
            response.sendRedirect(request.getContextPath() + "/");
            return false; 
            }
        
        return true; 
    }
}