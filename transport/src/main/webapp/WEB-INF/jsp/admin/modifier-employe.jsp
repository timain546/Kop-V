<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Utilisateurs" %>
<%@ page import="com.cooperative.transport.entities.Salaires" %>
<%@ page import="com.cooperative.transport.entities.Role" %>
<%
    Object[] employes = (Object[]) request.getAttribute("employe");
    System.out.println("Employé trouvé: " + (employes != null ? employes.length : "null"));
    List<Role> roles = (List<Role>) request.getAttribute("roles");
    String errorMessage = (String) request.getAttribute("errorMessage");
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
           <% if (errorMessage != null) { %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
            <% } %>
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
                    <input type="password" name="mdp" id="mdp" placeholder="Entrez le mot de passe" value="<%=emp.getMotDePasse()%>"autocomplete="off" style="padding: 10px 40px 10px 14px; width: 100%;">
                    <button type="button" id="togglePassword" onclick="togglemdp()" style="position: absolute; right: 12px; bottom: 10px; background: none; border: none; cursor: pointer; padding: 0; color: #94a3b8; display: flex; align-items: center;"><svg fill="none" viewBox="0 0 24 24" stroke-width="1.8" stroke="currentColor" style="width: 22px; height: 22px; display: block;">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
            </svg></button>
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

 <script>
function togglemdp() {
    var mdpInput = document.getElementById("mdp");
    var toggleBtn = document.getElementById("togglePassword");

    if (mdpInput.type === "password") {
        mdpInput.type = "text";
        
        toggleBtn.innerHTML = `
            <svg fill="none" viewBox="0 0 24 24" stroke-width="1.8" stroke="currentColor" style="width: 22px; height: 22px; display: block;">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
            </svg>
        `;
    } else {
        mdpInput.type = "password";
        // 2. ŒIL BARRÉ : Le mot de passe est masqué (points), on montre l'œil barré (exactement comme sur ton image)
        toggleBtn.innerHTML = `
            <svg fill="none" viewBox="0 0 24 24" stroke-width="1.8" stroke="currentColor" style="width: 22px; height: 22px; display: block;">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
            </svg>
        `;
    }
}</script>
</html>
