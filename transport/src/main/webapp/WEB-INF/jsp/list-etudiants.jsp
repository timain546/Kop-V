<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Etudiants" %>

<%
    List<Etudiants> etudiants = (List<Etudiants>) request.getAttribute("listeEtudiants");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des étudiants</title>
</head>
<body>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Semestre</th>
        </tr>
        <% for(Etudiants etudiant : etudiants) { %>
            <tr>
                <td><%= etudiant.getId() %></td>
                <td><%= etudiant.getNom() %></td>
                <td><%= etudiant.getSemestre() %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>