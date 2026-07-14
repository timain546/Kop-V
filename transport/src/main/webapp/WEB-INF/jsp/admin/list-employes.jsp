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
    
    // Récupération des attributs de pagination (Indexation commençant à 1)
    Integer pageActuelle = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer taillePage = (Integer) request.getAttribute("pageSize");
    Long totalElements = (Long) request.getAttribute("totalElements");

    if (pageActuelle == null) pageActuelle = 1;
    if (totalPages == null) totalPages = 1;
    if (taillePage == null) taillePage = 10;
    if (totalElements == null) totalElements = 0L;
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
            <span>Gestion des employés</span>
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
                <h1><i class="fas fa-users" style="color: #15803d; margin-right: 10px;"></i>Liste des Employés</h1>
                <div class="header-actions">
                    <span class="total-employes">
                        <span>Total: <%= totalElements %></span>
                    </span>
                    <a href="form" class="btn-ajouter"><i class="fas fa-plus"></i></a>
                </div>
            </div>

            <div class="search-container" style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 20px;">
                <form action="list" method="get">
                    <input type="hidden" name="page" value="1">
                    
                    <!-- LIGNE 1 : Les champs de filtres -->
                    <div class="search-form" style="display: flex; flex-wrap: wrap; gap: 12px; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px; margin-bottom: 15px;">
                        <div class="search-title" style="display: flex; align-items: center;">
                            <i class="fas fa-search" style="color: #94a3b8; font-size: 18px;"></i>
                        </div>
                        <div class="search-group" style="flex: 1; min-width: 120px;">
                            <input type="text" id="searchNom" name="nom" placeholder="Nom" value="<%= nomRecherche %>" style="width: 100%;">
                        </div>
                        <div class="search-group" style="flex: 1; min-width: 120px;">
                            <input type="text" id="searchPrenom" name="prenom" placeholder="Prénom" value="<%= prenomRecherche %>" style="width: 100%;">
                        </div>
                        <div class="search-group" style="flex: 1; min-width: 150px;">
                            <input type="text" id="searchEmail" name="email" placeholder="Email" value="<%= emailRecherche %>" style="width: 100%;">
                        </div>
                        <div class="search-group" style="width: 100px;">
                            <input type="number" id="searchSalaireMin" name="salaireMin" placeholder="Min" value="<%= salaireMinRecherche != null ? salaireMinRecherche : "" %>" style="width: 100%;">
                        </div>
                        <div class="search-group" style="width: 100px;">
                            <input type="number" id="searchSalaireMax" name="salaireMax" placeholder="Max" value="<%= salaireMaxRecherche != null ? salaireMaxRecherche : "" %>" style="width: 100%;">
                        </div>
                        
                        <div class="search-actions" style="display: flex; gap: 8px;">
                            <button type="submit" class="btn-search"><i class="fas fa-search"></i></button>
                            <a href="list" class="btn-reset"><i class="fas fa-undo"></i></a>
                        </div>
                    </div>

                   
                    <div class="page-size-row" style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;">
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <span style="font-size: 14px; color: #64748b; font-weight: 500;">
                                <i class="fas fa-list-ol" style="color: #64748b; margin-right: 5px;"></i> Afficher :
                            </span>
                            <input type="number" name="size" value="<%= taillePage %>" min="1" max="100" style="width: 70px; padding: 6px 10px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; text-align: center; font-weight: 600; color: #334155;">
                            <span style="font-size: 14px; color: #64748b;">éléments par page</span>
                            <button type="submit" class="btn-search btn-appliquer-override" style="background-color: #16a34a; color: white; border: none; padding: 6px 14px; border-radius: 6px; font-size: 13px; font-weight: 500; cursor: pointer; display: flex; align-items: center; gap: 6px; width: auto; min-width: max-content; height: 32px;">
                             <i class="fas fa-sync-alt"></i> Appliquer
                            </button>
                        </div>
                        
                        <div style="font-size: 13px; color: #64748b;">
                            Filtres actifs : <strong><%= (!nomRecherche.isEmpty() || !prenomRecherche.isEmpty() || !emailRecherche.isEmpty() || salaireMinRecherche != null || salaireMaxRecherche != null) ? "Oui" : "Aucun" %></strong>
                        </div>
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
                                       <% if (statutEmploye != null && (statutEmploye.equalsIgnoreCase("Engagé") || statutEmploye.equalsIgnoreCase("Reambauché"))) { %>
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

           
            <% if (totalPages > 1) { %>
                <div class="pagination-container" style="display: flex; justify-content: space-between; align-items: center; margin-top: 20px;">
                    <div class="pagination-info">
                        Page <strong><%= pageActuelle %></strong> sur <strong><%= totalPages %></strong> (Total: <%= totalElements %>)
                    </div>
                    <div class="pagination-buttons">
                       
                        <% if (pageActuelle > 1) { %>
                            <a href="list?page=<%= pageActuelle - 1 %>&size=<%= taillePage %>&nom=<%= nomRecherche %>&prenom=<%= prenomRecherche %>&email=<%= emailRecherche %>&salaireMin=<%= salaireMinRecherche != null ? salaireMinRecherche : "" %>&salaireMax=<%= salaireMaxRecherche != null ? salaireMaxRecherche : "" %>" class="btn-pag">
                                <i class="fas fa-chevron-left"></i> Précédent
                            </a>
                        <% } else { %>
                            <span class="btn-pag disabled"><i class="fas fa-chevron-left"></i> Précédent</span>
                        <% } %>

                        <% for (int p = 1; p <= totalPages; p++) { 
                            if (p == pageActuelle) { %>
                                <span class="btn-pag active"><%= p %></span>
                            <% } else { %>
                                <a href="list?page=<%= p %>&size=<%= taillePage %>&nom=<%= nomRecherche %>&prenom=<%= prenomRecherche %>&email=<%= emailRecherche %>&salaireMin=<%= salaireMinRecherche != null ? salaireMinRecherche : "" %>&salaireMax=<%= salaireMaxRecherche != null ? salaireMaxRecherche : "" %>" class="btn-pag"><%= p %></a>
                            <% } 
                        } %>

                        <% if (pageActuelle < totalPages) { %>
                            <a href="list?page=<%= pageActuelle + 1 %>&size=<%= taillePage %>&nom=<%= nomRecherche %>&prenom=<%= prenomRecherche %>&email=<%= emailRecherche %>&salaireMin=<%= salaireMinRecherche != null ? salaireMinRecherche : "" %>&salaireMax=<%= salaireMaxRecherche != null ? salaireMaxRecherche : "" %>" class="btn-pag">
                                Suivant <i class="fas fa-chevron-right"></i>
                            </a>
                        <% } else { %>
                            <span class="btn-pag disabled">Suivant <i class="fas fa-chevron-right"></i></span>
                        <% } %>
                    </div>
                </div>
            <% } %>
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