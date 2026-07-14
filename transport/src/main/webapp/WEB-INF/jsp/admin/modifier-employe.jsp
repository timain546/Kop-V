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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/list-employes.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sidebar.css">
</head>
<body>
    <!-- Sidebar -->
    <button class="sidebar-toggle" onclick="toggleSidebar()">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="3" y1="12" x2="21" y2="12"></line>
            <line x1="3" y1="6" x2="21" y2="6"></line>
            <line x1="3" y1="18" x2="21" y2="18"></line>
        </svg>
    </button>
    <div class="sidebar-overlay" onclick="toggleSidebar()"></div>
    
    <div class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-icon">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#86efac" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="1" y="3" width="15" height="13" rx="2"></rect>
                    <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                    <circle cx="5.5" cy="18" r="2.5"></circle>
                    <circle cx="18.5" cy="18" r="2.5"></circle>
                </svg>
            </span>
            <h2>KopV</h2>
            <span>Gestion RH</span>
        </div>
        <ul class="sidebar-menu">
            <li>
                <a href="list" class="active">
                    <span class="menu-icon">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="9" cy="7" r="4"></circle>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                        </svg>
                    </span>
                    Employés
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/stats">
                    <span class="menu-icon">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M18 20V10"></path>
                            <path d="M12 20V4"></path>
                            <path d="M6 20v-6"></path>
                        </svg>
                    </span>
                    Stats
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/employes/form">
                    <span class="menu-icon">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="8.5" cy="7" r="4"></circle>
                            <line x1="20" y1="8" x2="20" y2="14"></line>
                            <line x1="23" y1="11" x2="17" y2="11"></line>
                        </svg>
                    </span>
                    Ajouter
                </a>
            </li>
            <li class="menu-divider"></li>
            <li>
                <a href="${pageContext.request.contextPath}/logout">
                    <span class="menu-icon">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                            <polyline points="16 17 21 12 16 7"></polyline>
                            <line x1="21" y1="12" x2="9" y2="12"></line>
                        </svg>
                    </span>
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
                <h1>Employés</h1>
                <div class="header-actions">
                    <span class="total-employes">
                        <span><%= employes != null ? employes.size() : 0 %></span>
                    </span>
                    <a href="form" class="btn-ajouter">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="12" y1="5" x2="12" y2="19"></line>
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                        </svg>
                    </a>
                </div>
            </div>

            <div class="search-container">
                <form action="list" method="get" style="display: contents; width: 100%;">
                    <div class="search-title">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
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
                        <button type="submit" class="btn-search">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                            </svg>
                        </button>
                        <a href="list" class="btn-reset">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#475569" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M23 4v6h-6"></path>
                                <path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"></path>
                            </svg>
                        </a>
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
                                        <span class="statut-dot"></span>
                                        <%= statutEmploye != null ? statutEmploye : "-" %>
                                    </span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <form action="modifier" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= employe.getId() %>">
                                            <input type="hidden" name="role" value="<%= role.getLibelle() %>">
                                            <button type="submit" class="btn-action btn-modifier">
                                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M12 20h9"></path>
                                                    <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                                                </svg>
                                            </button>
                                        </form>
                                       <% if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Engagé") || statutEmploye.equalsIgnoreCase("Reambauché")) { %>
                                             <form action="supprimerEmploye" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= employe.getId() %>">
                                                <button type="submit" class="btn-action btn-supprimer" 
                                                onclick="return confirm('Etes-vous sur de vouloir renvoyer cet employe ?');">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                                        <circle cx="12" cy="7" r="4"></circle>
                                                        <line x1="16" y1="13" x2="8" y2="13"></line>
                                                    </svg>
                                                </button>
                                            </form>
                                        <% } 
                                        else if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Renvoyé")) { %>
                                            <form action="reembaucher" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= employe.getId() %>">
                                                <button type="submit" class="btn-action btn-modifier"
                                                onclick="return confirm('Etes-vous sur de vouloir reembaucher cet employe ?');">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                                        <circle cx="12" cy="7" r="4"></circle>
                                                        <line x1="16" y1="11" x2="8" y2="11"></line>
                                                        <line x1="12" y1="7" x2="12" y2="15"></line>
                                                    </svg>
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