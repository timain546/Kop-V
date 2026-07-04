<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Utilisateurs" %>
<%@ page import="com.cooperative.transport.entities.Salaires" %>
<%@ page import="com.cooperative.transport.entities.Role" %>
<%
    List<Object[]> employes = (List<Object[]>) request.getAttribute("listeEmployes");
    List<String> statut = (List<String>) request.getAttribute("statut");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Employes</title>
<link rel="stylesheet" href="../assets/css/list-employes.css"></head>
<body>
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
                                <div class="aucun-employe-icon">&#128100;</div>
                                Aucun employe trouve dans la base de donnees
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>