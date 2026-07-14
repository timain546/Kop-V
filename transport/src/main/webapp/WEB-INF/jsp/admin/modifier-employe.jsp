<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Utilisateurs" %>
<%@ page import="com.cooperative.transport.entities.Salaires" %>
<%@ page import="com.cooperative.transport.entities.Role" %>
<%
    Object[] employes = (Object[]) request.getAttribute("employe");
    System.out.println("Employé trouvé: " + (employes != null ? employes.length : "null"));
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modification de l'employe</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modifier-employe.css">
</head>
<body>
    <div class="form-card">
        <% if (employes != null) {
            Utilisateurs emp = (Utilisateurs) employes[0];
            Salaires sal = (Salaires) employes[1];
            Role role = (Role) employes[2];
        %>
            <div class="form-header">
                <h1>Modification de l'employe #<%= emp.getId() %></h1>
                <p class="form-subtitle">Modifiez les informations ci-dessous</p>
            </div>

            <form action="miseajour" method="post" style="display: flex; flex-direction: column; gap: 10px;">
                <div class="form-group" style="margin-bottom: 0;">
                    <label for="nom" style="margin-bottom: 4px;">Nom</label>
                    <input type="text" name="nom" id="nom" value="<%= emp.getNom()%>" required style="padding: 8px 12px;">
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="prenom" style="margin-bottom: 4px;">Prenom</label>
                    <input type="text" name="prenom" id="prenom" value="<%= emp.getPrenom()%>" required style="padding: 8px 12px;">
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="email" style="margin-bottom: 4px;">Email</label>
                    <input type="text" name="email" id="email" value="<%= emp.getEmail()%>" required style="padding: 8px 12px;">
                </div>

                <div class="form-group" style="margin-bottom: 0; position: relative;">
                    <label for="mdp">Mot de passe</label>
                    <input type="password" name="mdp" id="mdp" placeholder="Entrez le mot de passe" autocomplete="off" style="padding: 10px 40px 10px 14px; width: 100%;">
                    <button type="button" id="togglePassword" onclick="togglemdp()" style="position: absolute; right: 12px; top: 50%; transform: translateY(6px); background: none; border: none; cursor: pointer; font-size: 18px; padding: 0; color: #94a3b8;">👁️</button>
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="role" style="margin-bottom: 4px;">
                        Role
                        <span class="current-role-badge"><%= role.getLibelle()%></span>
                    </label>
                    <select name="role" id="role" style="padding: 8px 12px;">
                        <% for (Role r : roles) { %>
                            <option value="<%= r.getId() %>" <%= r.getId() == role.getId() ? "selected" : "" %>>
                                <%= r.getLibelle() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="salaire" style="margin-bottom: 4px;">Salaire</label>
                    <input type="text" name="salaire" id="salaire" value="<%= sal != null ? sal.getSalaire() : "" %>" required style="padding: 8px 12px;">
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="date" style="margin-bottom: 4px;">Date de modification</label>
                    <input type="date" name="date" id="date" value="<%= sal != null ? sal.getDateModification() : "" %>" required style="padding: 8px 12px;">
                </div>

                <input type="hidden" name="id" value="<%= emp.getId() %>">

                <input type="submit" value="Mettre a jour" class="btn-submit" style="padding: 10px; margin-top: 2px;">

                <div class="divider" style="margin: 6px 0;">
                    <span>ou</span>
                </div>

                <a href="list" class="btn-retour" style="padding: 10px; margin-top: 0;">Retour a la liste</a>
            </form>
        <% } else { %>
            <div class="message-info">
                <div class="message-info-icon">&#9888;</div>
                Aucun employe trouve.
            </div>
            <a href="list" class="btn-retour">Retour a la liste</a>
        <% } %>
    </div>
</body>

 <script src="${pageContext.request.contextPath}/assets/js/ajouter-employe.js"></script>
</html>
