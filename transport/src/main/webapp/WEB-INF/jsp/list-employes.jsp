<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Employes" %>
<%@ page import="com.cooperative.transport.entities.Salaires" %>
<%@ page import="com.cooperative.transport.entities.Roles" %>
<%
    List<Object[]> employes = (List<Object[]>) request.getAttribute("listeEmployes");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Employes</title>
    <style>
        table { border-collapse: collapse; width: 100%; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .container { padding: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Liste des Employés</h1>
        <p>Nombre total des employés : <%= employes != null ? employes.size() : 0 %></p>
        
        <table border="1">
            <thead>
                <tr>
                   
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Email</th>
                    <th>Rôle</th>
                    <th>Salaires</th>
                </tr>
            </thead>
            <tbody>
                <% if (employes != null && !employes.isEmpty()) { 
                    for(Object[] row : employes) { 
                        // row[0] = Employes, row[1] = Salaires, row[2] = Roles
                        Employes employe = (Employes) row[0];
                        Salaires salaire = (Salaires) row[1];
                        Roles role = (Roles) row[2];
                %>
                <tr>
                    <td><%= employe.getNom() %></td>
                    <td><%= employe.getPrenom() %></td>
                    <td><%= employe.getEmail() %></td>
                    <td><%=role.getLibelle() %></td>
                    <td>
                       
                            <% if (salaire != null) { %>
                                <%= salaire.getSalaire() %> (Modifié le: <%= salaire.getDate_modification() %>)
                            <% } else { %>
                                Aucun salaire disponible
                            <% } %>
                    </td>
                </tr>
                <% 
                    } 
                } else { 
                %>
                <tr>
                    <td colspan="6" style="text-align: center; color: red;">
                        ❌ Aucun employé trouvé
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>