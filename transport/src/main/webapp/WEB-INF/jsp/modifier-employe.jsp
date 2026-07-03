<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Employes" %>
<%@ page import="com.cooperative.transport.entities.Salaires" %>
<%@ page import="com.cooperative.transport.entities.Roles" %>
<%
    Object[] employes = (Object[]) request.getAttribute("employe");
    System.out.println("Employé trouvé: " + (employes != null ? employes.length : "null"));
    List<Roles> roles = (List<Roles>) request.getAttribute("roles");    
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modification de l'employe</title>
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
            max-width: 560px;
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
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%2316a34a' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            padding-right: 44px;
        }

        select option {
            padding: 10px;
        }

        .current-role-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #dcfce7;
            color: #166534;
            font-size: 11px;
            font-weight: 600;
            padding: 4px 12px;
            border-radius: 50px;
            border: 1px solid #86efac;
            margin-left: 8px;
            vertical-align: middle;
        }

        .current-role-badge::before {
            content: "";
            width: 6px;
            height: 6px;
            background: #22c55e;
            border-radius: 50%;
            display: inline-block;
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

        .message-info {
            background: #fef3c7;
            border-left: 4px solid #f59e0b;
            padding: 16px 20px;
            border-radius: 12px;
            color: #92400e;
            font-weight: 500;
            margin-bottom: 24px;
            text-align: center;
        }

        .message-info-icon {
            font-size: 32px;
            margin-bottom: 8px;
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

            .current-role-badge {
                display: inline-flex;
                margin-left: 0;
                margin-top: 6px;
            }
        }
    </style>
</head>
<body>
        <% if (employes != null) {
            Employes emp = (Employes) employes[0];
            Salaires sal = (Salaires) employes[1];
            Roles role = (Roles) employes[2];
        %>
    <div class="form-card">
        <div class="form-header">
            <h1>Modification de l'employe#<%= emp.getId() %></h1>
            <p class="form-subtitle">Modifiez les informations ci-dessous</p>
        </div>

       
            <form action="miseajour" method="post">
                <div class="form-group">
                    <label for="nom">Nom</label>
                    <input type="text" name="nom" id="nom" value="<%= emp.getNom()%>" required>
                </div>

                <div class="form-group">
                    <label for="prenom">Prenom</label>
                    <input type="text" name="prenom" id="prenom" value="<%= emp.getPrenom()%>" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" name="email" id="email" value="<%= emp.getEmail()%>" required>
                </div>

                <div class="form-group">
                    <label for="role">
                        Role
                        <span class="current-role-badge"><%= role.getLibelle()%></span>
                    </label>
                    <select name="role" id="role">
                        <% for (Roles r : roles) { %>
                            <option value="<%= r.getId() %>" <%= r.getId() == role.getId() ? "selected" : "" %>>
                                <%= r.getLibelle() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="salaire">Salaire</label>
                    <input type="text" name="salaire" id="salaire" value="<%= sal != null ? sal.getSalaire() : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="date">Date de modification</label>
                    <input type="date" name="date" id="date" value="<%= sal != null ? sal.getDate_modification() : "" %>" required>
                </div>

                <input type="hidden" name="id" value="<%= emp.getId() %>">

                <input type="submit" value="Mettre a jour" class="btn-submit">

                <div class="divider"><span>ou</span></div>

                <a href="list" class="btn-retour">Retour a la liste</a>
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
</html>