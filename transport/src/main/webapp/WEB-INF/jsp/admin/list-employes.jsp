<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Utilisateurs" %>
<%@ page import="com.cooperative.transport.entities.Salaires" %>
<%@ page import="com.cooperative.transport.entities.Role" %>
<%
    List<Object[]> employes = (List<Object[]>) request.getAttribute("listeEmployes");
    List<String> statut = (List<String>) request.getAttribute("statut");

     String nomRecherche = (String) request.getAttribute("nomRecherche");
    String prenomRecherche = (String) request.getAttribute("prenomRecherche");
    String emailRecherche = (String) request.getAttribute("emailRecherche");
    Double salaireMinRecherche = (Double) request.getAttribute("salaireMinRecherche");
    Double salaireMaxRecherche = (Double) request.getAttribute("salaireMaxRecherche");

    if (nomRecherche == null) nomRecherche = "";
    if (prenomRecherche == null) prenomRecherche = "";
    if (emailRecherche == null) emailRecherche = "";
    if (salaireMinRecherche == null) salaireMinRecherche = null;
    if (salaireMaxRecherche == null) salaireMaxRecherche = null;
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Employes</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/list-employes.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sidebar.css">
</head>
<body>
    <!-- Sidebar -->
    <button class="sidebar-toggle" onclick="toggleSidebar()">
        <i class="fas fa-bars"></i>
    </button>
    <div class="sidebar-overlay" onclick="toggleSidebar()"></div>
    
    <div class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-icon"><i class="fa-solid fa-van-shuttle"></i></span>
            <h2>KopV</h2>
            <span>Gestion RH</span>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="list" class="active">
                    <span class="menu-icon"><i class="fas fa-users"></i></span>
                    Employés
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/stats">
                    <span class="menu-icon"><i class="fas fa-chart-bar"></i></span>
                    Statistiques
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/employes/form">
                    <span class="menu-icon"><i class="fas fa-user-plus"></i></span>
                    Ajouter
                </a>
            </li>
            <li class="menu-divider"></li>
            <li>
                <a href="${pageContext.request.contextPath}/logout">
                    <span class="menu-icon"><i class="fas fa-sign-out-alt"></i></span>
                    Déconnexion
                </a>
            </li>
        </ul>
        <div class="sidebar-footer">
            &copy; 2026 KopV
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-users" style="color: #15803d; margin-right: 10px;"></i>Liste de Employés</h1>
                <div class="header-actions">
                    <span class="total-employes">
                        <span>Total:<%= employes != null ? employes.size() : 0 %></span>
                    </span>
                    <a href="form" class="btn-ajouter"><i class="fas fa-plus"></i></a>
                </div>
            </div>

            <div class="search-container">
                <form action="list" method="get" class="search-form"><div class="search-title">
                        <i class="fas fa-search" style="color: #94a3b8;"></i>
                    </div>
                    <div class="search-group">
                        <input type="text" id="searchNom" name="nom" placeholder="Nom" value="<%= nomRecherche %>">
                    </div>
                    <div class="search-group">
                        <input type="text" id="searchPrenom" name="prenom" placeholder="Prénom" value="<%= prenomRecherche %>">
                    </div>
                    <div class="search-group">
                        <input type="text" id="searchEmail" name="email" placeholder="Email" value="<%= emailRecherche %>">
                    </div>
                    <div class="search-group">
                        <input type="number" id="searchSalaireMin" name="salaireMin" placeholder="Min" value="<%= salaireMinRecherche != null ? salaireMinRecherche : "" %>">
                    </div>
                    <div class="search-group">
                        <input type="number" id="searchSalaireMax" name="salaireMax" placeholder="Max" value="<%= salaireMaxRecherche != null ? salaireMaxRecherche : "" %>">
                    </div>
                    <div class="search-actions">
                        <button type="submit" class="btn-search"><i class="fas fa-search"></i></button>
                        <a href="list" class="btn-reset"><i class="fas fa-undo"></i></a>
                    </div>
                </form>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Email</th>
                            <th>Rôle</th>
                            <th>Salaire</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (employes != null && !employes.isEmpty()) { 
                            for(int i = 0; i < employes.size(); i++) { 
                                Object[] row = employes.get(i);
                                Utilisateurs employe = (Utilisateurs) row[0];
                                Salaires salaire = (Salaires) row[1];
                                Role role = (Role) row[2];
                                String statutEmploye = statut.get(i);
                                
                                String statutClass = "statut-default";
                                if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Engagé")) {
                                    statutClass = "statut-engage";
                                } else if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Renvoyé")) {
                                    statutClass = "statut-renvoye";
                                } else if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Reambauché")) {
                                    statutClass = "statut-reembauche";
                                }
                        %>
                            <tr>
                                <td><%= employe.getNom() %></td>
                                <td><%= employe.getPrenom() %></td>
                                <td><%= employe.getEmail() %></td>
                                <td><span class="role-cell"><%= role.getLibelle() %></span></td>
                                <td>
                                    <% if (salaire != null) { %>
                                        <span><%= salaire.getSalaire() %></span>
                                    <% } else { %>
                                        <span class="salaire-indisponible">-</span>
                                    <% } %>
                                </td>
                                <td>
                                    <span class="statut-badge <%= statutClass %>">
                                        <i class="fas fa-circle" style="font-size: 6px; margin-right: 4px;"></i>
                                        <%= statutEmploye != null ? statutEmploye : "-" %>
                                    </span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <form action="modifier" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= employe.getId() %>">
                                            <input type="hidden" name="role" value="<%= role.getLibelle() %>">
                                            <button type="submit" class="btn-action btn-modifier">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                        </form>
                                       <% if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Engagé") || statutEmploye.equalsIgnoreCase("Reambauché")) { %>
                                             <form action="supprimerEmploye" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= employe.getId() %>">
                                                <button type="submit" class="btn-action btn-supprimer" 
                                                onclick="return confirm('Etes-vous sur de vouloir renvoyer cet employe ?');">
                                                    <i class="fas fa-user-minus"></i>
                                                </button>
                                            </form>
                                        <% } 
                                        else if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Renvoyé")) { %>
                                            <form action="reembaucher" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= employe.getId() %>">
                                                <button type="submit" class="btn-action btn-modifier"
                                                onclick="return confirm('Etes-vous sur de vouloir reembaucher cet employe ?');">
                                                    <i class="fas fa-user-check"></i>
                                                </button>
                                            </form>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                        <% } 
                        } else { %>
                            <tr>
                                <td colspan="7" class="aucun-employe">
                                    <i class="fas fa-users-slash" style="font-size: 24px; display: block; margin-bottom: 10px; color: #bbf7d0;"></i>
                                    Aucun employé
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            const overlay = document.querySelector('.sidebar-overlay');
            sidebar.classList.toggle('open');
            overlay.classList.toggle('active');
        }
    </script>
</body>
</html>