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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/list-employes.css">
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a class="nav-brand" href="${pageContext.request.contextPath}/admin/list">
                <i class="fas fa-bus"></i> KOP-V
            </a>
            <div class="nav-links">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/list">
                    <i class="fas fa-users"></i> Employés
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/ajouter">
                    <i class="fas fa-user-plus"></i> Ajouter
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/stats">
                    <i class="fas fa-chart-bar"></i> Statistiques
                </a>
            </div>
            <button class="theme-toggle" onclick="toggleTheme()" title="Changer de thème">
                <i class="fas fa-sun theme-icon-light"></i>
                <i class="fas fa-moon theme-icon-dark"></i>
            </button>
        </div>
    </nav>
    <div class="container">
        <div class="header">
            <h1>Liste des employes</h1>
            <div class="header-actions">
                <span class="total-employes">
                    Total : <span><%= employes != null ? employes.size() : 0 %></span> employe(s)
                </span>
                <a href="form" class="btn-ajouter">Ajouter un employe</a>
            </div>
        </div>

          
<div class="search-container">
    <form action="list" method="get" style="display: contents; width: 100%;">
     <div class="search-title">
            <h3>Rechercher par :</h3>
    </div>
        <div class="search-group">
            <label for="searchNom">Nom</label>
            <input type="text" id="searchNom" name="nom"  value="<%= nomRecherche %>">
        </div>
        <div class="search-group">
            <label for="searchPrenom">Prénom</label>
            <input type="text" id="searchPrenom" name="prenom" value="<%= prenomRecherche %>">
        </div>
        <div class="search-group">
            <label for="searchEmail">Email</label>
            <input type="text" id="searchEmail" name="email"value="<%= emailRecherche %>">
        </div>
        <div class="search-group">
            <label for="searchSalaireMin">Salaire Minimum</label>
            <input type="number" id="searchSalaireMin" name="salaireMin" ="Min" value="<%= salaireMinRecherche != null ? salaireMinRecherche : "" %>">
        </div>
        <div class="search-group">
            <label for="searchSalaireMax">Salaire Maximum</label>
            <input type="number" id="searchSalaireMax" name="salaireMax" ="Max" value="<%= salaireMaxRecherche != null ? salaireMaxRecherche : "" %>">
        </div>
        <div class="search-actions">
            <button type="submit" class="btn-search">Rechercher</button>
            <a href="list" class="btn-reset">Réinitialiser</a>
        </div>
    </form>
</div>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prenom</th>
                        <th>Email</th>
                        <th>Role</th>
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
                            <td class="nom-employe"><%= employe.getNom() %></td>
                            <td><%= employe.getPrenom() %></td>
                            <td class="email-cell"><%= employe.getEmail() %></td>
                            <td><span class="role-cell"><%= role.getLibelle() %></span></td>
                            <td>
                                <% if (salaire != null) { %>
                                    <span class="salaire-montant"><%= salaire.getSalaire() %> Ar</span>
                                <% } else { %>
                                    <span class="salaire-indisponible">Non defini</span>
                                <% } %>
                            </td>
                            <td>
                                <span class="statut-badge <%= statutClass %>">
                                    <%= statutEmploye != null ? statutEmploye : "Non defini" %>
                                </span>
                            </td>
                            <td>
                                <div class="actions">
                                    <form action="modifier" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= employe.getId() %>">
                                        <input type="hidden" name="role" value="<%= role.getLibelle() %>">
                                        <input type="submit" value="Modifier" class="btn-action btn-modifier">
                                    </form>
                                   <% if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Engagé") || statutEmploye.equalsIgnoreCase("Reambauché")) { %>
                                         <form action="supprimerEmploye" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= employe.getId() %>">
                                            <input type="submit" value="Renvoyer" class="btn-action btn-supprimer" 
                                            onclick="return confirm('Etes-vous sur de vouloir renvoyer cet employe ?');">
                                        </form>
                                    <% } 
                                    else if (statutEmploye != null && statutEmploye.equalsIgnoreCase("Renvoyé")) { %>
                                        <form action="reembaucher" method="post" style="display:inline;">
                                            <input type="hidden" name="id" value="<%= employe.getId() %>">
                                            <input type="submit" value="Reembaucher" class="btn-action btn-modifier"
                                            onclick="return confirm('Etes-vous sur de vouloir reembaucher cet employe ?');">
                                        </form>
                                    <% } %>
                                   
                                </div>
                            </td>
                        </tr>
                    <% } 
                    } else { %>
                        <tr>
                            <td colspan="7" class="aucun-employe">
                                <div class="aucun-employe-icon"><i class="fas fa-user-slash" style="font-size:2rem;color:var(--text-light)"></i></div>
                                Aucun employe trouve dans la base de donnees
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/animations.js"></script>
</body>
</html>