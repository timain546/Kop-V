<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Role" %>
<%
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html>

<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire employe</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ajouter-employe.css">
    <script>!function(){var t=localStorage.getItem('kop-v-theme')||('matchMedia' in window&&matchMedia('(prefers-color-scheme:dark)').matches?'dark':'light');document.documentElement.setAttribute('data-theme',t)}();</script>
</head>

<body>
    <nav class="navbar">
        <div class="nav-container">
            <a class="nav-brand" href="${pageContext.request.contextPath}/admin/list">
                <i class="fas fa-bus"></i> KOP-V
            </a>
            <div class="nav-links">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/list">
                    <i class="fas fa-users"></i> Employés
                </a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/ajouter">
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

    <div class="form-card">
        <div class="form-header">
            <div class="form-icon"><i class="fas fa-user-plus" style="font-size:2rem;color:var(--primary)"></i></div>
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
                    <% for (Role r : roles) { %>
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
    <script src="${pageContext.request.contextPath}/assets/js/ajouter-employe.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/animations.js"></script>

</body>
</html>
