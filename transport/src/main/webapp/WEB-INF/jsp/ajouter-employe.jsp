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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f0fdf4;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
            color: #1e293b;
        }

        .form-card {
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(34, 197, 94, 0.1);
            padding: 48px 44px;
            width: 100%;
            max-width: 520px;
            animation: slideUp 0.5s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-header {
            text-align: center;
            margin-bottom: 36px;
        }

        .form-icon {
            width: 64px;
            height: 64px;
            background: #dcfce7;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 28px;
        }

        h1 {
            font-family: Arial, Helvetica, sans-serif;
            color: #15803d;
            font-size: 26px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .form-subtitle {
            color: #64748b;
            font-size: 14px;
            margin-top: 8px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        label {
            font-family: Arial, Helvetica, sans-serif;
            display: block;
            color: #374151;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        label::after {
            content: " *";
            color: #16a34a;
        }

        input[type="text"],
        input[type="date"],
        select {
            font-family: Arial, Helvetica, sans-serif;
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            color: #1e293b;
            background-color: #fafafa;
            transition: all 0.25s ease;
            outline: none;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        select:focus {
            border-color: #16a34a;
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(22, 163, 74, 0.1);
        }

        input[type="text"]::placeholder {
            color: #94a3b8;
        }

        select {
            cursor: pointer;
            appearance: none;
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 44px;
        }

        select option {
            padding: 10px;
        }

        .btn-submit {
            font-family: Arial, Helvetica, sans-serif;
            width: 100%;
            padding: 16px;
            background-color: #16a34a;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 8px;
            box-shadow: 0 4px 16px rgba(22, 163, 74, 0.3);
        }

        .btn-submit:hover {
            background-color: #15803d;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(22, 163, 74, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .btn-retour {
            font-family: Arial, Helvetica, sans-serif;
            display: block;
            width: 100%;
            padding: 14px;
            background-color: transparent;
            color: #64748b;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 12px;
            text-align: center;
            text-decoration: none;
        }

        .btn-retour:hover {
            border-color: #16a34a;
            color: #16a34a;
            background-color: #f0fdf4;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 24px 0;
            color: #94a3b8;
            font-size: 13px;
        }

        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background-color: #e2e8f0;
        }

        .divider span {
            padding: 0 16px;
        }

        @media (max-width: 600px) {
            body {
                padding: 16px;
                align-items: flex-start;
                padding-top: 40px;
            }

            .form-card {
                padding: 32px 24px;
                border-radius: 16px;
            }

            h1 {
                font-size: 22px;
            }

            input[type="text"],
            input[type="date"],
            select {
                padding: 12px 14px;
                font-size: 16px;
            }
        }
    </style>
</head>

<body>

    <div class="form-card">
        <div class="form-header">
            <div class="form-icon">&#128100;</div>
            <h1>Formulaire d'ajout employe</h1>
            <p class="form-subtitle">Veuiller Remplir les informations ci-dessous</p>
        </div>

        <form action="ajouter" method="post">
            <div class="form-group">
                <label for="nom">Nom</label>
                <input type="text" name="nom" id="nom" placeholder="Entrez le nom">
            </div>

            <div class="form-group">
                <label for="prenom">Prenom</label>
                <input type="text" name="prenom" id="prenom" placeholder="Entrez le prenom">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="text" name="email" id="email" placeholder="exemple@email.com">
            </div>

            <div class="form-group">
                <label for="role">Role</label>
                <select name="role" id="role">
                    <% for (Roles r : roles) { %>
                        <option value="<%= r.getId() %>">
                            <%= r.getLibelle() %>
                        </option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label for="salaire">Salaire</label>
                <input type="text" name="salaire" id="salaire" placeholder="Montant en Ariary">
            </div>

            <div class="form-group">
                <label for="date_embauche">Date d'embauche</label>
                <input type="date" name="date_embauche" id="date_embauche">
            </div>

            <input type="submit" value="Ajouter l'employe" class="btn-submit">

            <div class="divider"><span>ou</span></div>

            <a href="list" class="btn-retour">Retour a la liste</a>
        </form>
    </div>

</body>
</html>