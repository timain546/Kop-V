<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Roles" %>
<%
    List<Roles> roles = (List<Roles>) request.getAttribute("roles");
%>
<!DOCTYPE html>

<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire employe</title>
    <link rel="stylesheet" href="../assets/css/ajouter-employe.css">


</head>

<body>

    <div class="form-card">
        <div class="form-header">
            <div class="form-icon">&#128100;</div>
            <h1>Formulaire d'ajout employe</h1>
            <p class="form-subtitle">Veuiller Remplir les informations ci-dessous</p>
        </div>

        <form action="ajouter" method="post" style="display: flex; flex-direction: column; gap: 12px;">
            <div class="form-group" style="margin-bottom: 0;">
                <label for="nom">Nom</label>
                <input type="text" name="nom" id="nom" placeholder="Entrez le nom" style="padding: 10px 14px;">
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="prenom">Prenom</label>
                <input type="text" name="prenom" id="prenom" placeholder="Entrez le prenom" style="padding: 10px 14px;">
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="email">Email</label>
                <input type="text" name="email" id="email" placeholder="exemple@email.com" autocomplete="off" style="padding: 10px 14px;">
            </div>

                <div class="form-group" style="margin-bottom: 0; position: relative;">
                    <label for="mdp">Mot de passe</label>
                    <input type="password" name="mdp" id="mdp" placeholder="Entrez le mot de passe" autocomplete="off" style="padding: 10px 40px 10px 14px; width: 100%;">
                    <button type="button" id="togglePassword" onclick="togglemdp()" style="position: absolute; right: 12px; top: 50%; transform: translateY(6px); background: none; border: none; cursor: pointer; font-size: 18px; padding: 0; color: #94a3b8;">👁️</button>
                </div>
            <div class="form-group" style="margin-bottom: 0;">
                <label for="role">Role</label>
                <select name="role" id="role" style="padding: 10px 14px;">
                    <% for (Roles r : roles) { %>
                        <option value="<%= r.getId() %>">
                            <%= r.getLibelle() %>
                        </option>
                    <% } %>
                </select>
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="salaire">Salaire</label>
                <input type="text" name="salaire" id="salaire" placeholder="Montant en Ariary" style="padding: 10px 14px;">
            </div>

            <div class="form-group" style="margin-bottom: 0;">
                <label for="date_embauche">Date d'embauche</label>
                <input type="date" name="dateEmbauche" id="date_embauche" style="padding: 10px 14px;">
            </div>

            <input type="submit" value="Ajouter l'employe" class="btn-submit" style="padding: 12px; margin-top: 4px;">

            <div class="divider" style="margin: 8px 0;">
                <span>ou</span>
            </div>

            <a href="list" class="btn-retour" style="padding: 10px; margin-top: 0;">Retour a la liste</a>
        </form>
    </div>
    <script src="../assets/js/ajouter-employe.js"></script>

</body>
</html>
