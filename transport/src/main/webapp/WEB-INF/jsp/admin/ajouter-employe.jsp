<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Role" %>
<%@ page import="java.sql.Date"%>
<%
    List<Role> roles = (List<Role>) request.getAttribute("roles");
    String erreur = (String) request.getAttribute("errorMessage");
    String nom = (String) request.getAttribute("nom");
    String prenom = (String) request.getAttribute("prenom");
    String email = (String) request.getAttribute("email");
    String salaire = (String) request.getAttribute("salaire");
    String dateEmbauche = (String) request.getAttribute("dateEmbauche");
    String mdp = (String) request.getAttribute("mdp");
    Role role = (Role) request.getAttribute("role");
    if (nom == null) nom = "";
    if (prenom == null) prenom = "";
    if (email == null) email = "";
    if (salaire == null) salaire = "";
    if (dateEmbauche == null) dateEmbauche = "";
    if(mdp == null) mdp = "";
%>
<!DOCTYPE html>

<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire employe</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ajouter-employe.css">


</head>

<body>
    <div class="form-card">
        <div class="form-header">
            <div class="form-icon">&#128100;</div>
            <h1>Formulaire d'ajout employe</h1>
            <p class="form-subtitle">Veuiller Remplir les informations ci-dessous</p>
        </div>

    <% if (erreur != null) { %>
        <div class="error-message">
            <%=erreur %>
        </div>
    <% } %>

        <form action="ajouter" method="post" style="display: flex; flex-direction: column; gap: 12px;">
            <div class="form-group" style="margin-bottom: 0;">
                <label for="nom">Nom</label>
                <input type="text" name="nom" id="nom" placeholder="Entrez le nom" style="padding: 10px 14px;" value="<%=nom%>" required>
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="prenom">Prenom</label>
                <input type="text" name="prenom" id="prenom" placeholder="Entrez le prenom" style="padding: 10px 14px;"value="<%=prenom%>" required>
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="email">Email</label>
                <input type="text" name="email" id="email" placeholder="exemple@email.com" autocomplete="off" style="padding: 10px 14px;"value="<%=email%>" required>
            </div>

                <div class="form-group" style="margin-bottom: 0; position: relative;">
                    <label for="mdp">Mot de passe</label>
                    <input type="password" name="mdp" id="mdp" placeholder="Entrez le mot de passe" autocomplete="off" style="padding: 10px 40px 10px 14px; width: 100%;" value="<%=mdp%>" required>
                    <button type="button" id="togglePassword" onclick="togglemdp()" style="position: absolute; right: 12px; bottom: 10px; background: none; border: none; cursor: pointer; padding: 0; color: #94a3b8; display: flex; align-items: center;">
                    <svg fill="none" viewBox="0 0 24 24" stroke-width="1.8" stroke="currentColor" style="width: 22px; height: 22px; display: block;">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
            </svg></button>
                </div>
            <div class="form-group" style="margin-bottom: 0;">
                <label for="role">Role</label>
                <select name="role" id="role" style="padding: 10px 14px;">
                <% if (role != null) { %>
                    <option value="<%= role.getId() %>" selected><%= role.getLibelle() %></option>
                <% 
                  for (Role r : roles) { 
                  if(r.getLibelle() != role.getLibelle()){%>
                        <option value="<%= r.getId() %>">
                            <%= r.getLibelle() %>
                        </option>
                    <% } 
                    }
                    }else
                    {
                        for (Role r : roles) { %>
                            <option value="<%= r.getId() %>">
                                <%= r.getLibelle() %>
                            </option>
                        <% } 
                    } %>
                  
                </select>
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="salaire">Salaire</label>
                <input type="text" name="salaire" id="salaire" placeholder="Montant en Ariary" style="padding: 10px 14px;"value="<%=salaire%>" required>
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="date_embauche">Date d'embauche</label>
                <input type="date" name="dateEmbauche" id="date_embauche" style="padding: 10px 14px;" value="<%=dateEmbauche%>" required>
            </div>

            <input type="submit" value="Ajouter l'employe" class="btn-submit" style="padding: 12px; margin-top: 4px;">

            <div class="divider" style="margin: 8px 0;">
                <span>ou</span>
            </div>

            <a href="list" class="btn-retour" style="padding: 10px; margin-top: 0;">Retour a la liste</a>
        </form>
    </div>
    <script>
  function togglemdp() {
    var mdpInput = document.getElementById("mdp");
    var toggleBtn = document.getElementById("togglePassword");

    if (mdpInput.type === "password") {
        mdpInput.type = "text";
        // 1. ŒIL OUVERT : Le mot de passe est en clair (visible), on montre l'œil normal
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

</body>
</html>
