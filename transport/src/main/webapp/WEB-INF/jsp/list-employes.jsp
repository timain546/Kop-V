<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.Employes" %>
<%@ page import="com.cooperative.transport.entities.Salaires" %>
<%@ page import="com.cooperative.transport.entities.Roles" %>
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
            padding: 30px;
            color: #1e293b;
        }

        .container {
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(34, 197, 94, 0.08);
            padding: 32px 40px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 28px;
            padding-bottom: 20px;
            border-bottom: 2px solid #dcfce7;
        }

        h1 {
            font-family: Arial, Helvetica, sans-serif;
            color: #15803d;
            font-size: 28px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .total-employes {
            font-family: Arial, Helvetica, sans-serif;
            color: #166534;
            font-weight: 600;
            font-size: 14px;
            background: #dcfce7;
            padding: 10px 20px;
            border-radius: 50px;
            border: 1px solid #bbf7d0;
        }

        .total-employes span {
            font-weight: 700;
            color: #14532d;
            font-size: 16px;
        }

        .btn-ajouter {
            font-family: Arial, Helvetica, sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 28px;
            background-color: #16a34a;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(22, 163, 74, 0.25);
        }

        .btn-ajouter:hover {
            background-color: #15803d;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(22, 163, 74, 0.35);
        }

        .btn-ajouter::before {
            content: "+";
            font-size: 18px;
            font-weight: 700;
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid #bbf7d0;
            background: #ffffff;
        }

        table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }

        thead {
            position: sticky;
            top: 0;
        }

        th {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #16a34a;
            color: white;
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            white-space: nowrap;
        }

        th:first-child {
            border-top-left-radius: 12px;
        }

        th:last-child {
            border-top-right-radius: 12px;
        }

        td {
            font-family: Arial, Helvetica, sans-serif;
            padding: 16px 20px;
            border-bottom: 1px solid #f0fdf4;
            vertical-align: middle;
            color: #334155;
            transition: background-color 0.2s ease;
        }

        tbody tr {
            transition: all 0.2s ease;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:last-child td:first-child {
            border-bottom-left-radius: 12px;
        }

        tbody tr:last-child td:last-child {
            border-bottom-right-radius: 12px;
        }

        tbody tr:hover {
            background-color: #f0fdf4;
            transform: scale(1.002);
        }

        .nom-employe {
            font-weight: 700;
            color: #14532d;
            font-size: 15px;
        }

        .email-cell {
            color: #64748b;
            font-size: 13px;
        }

        .role-cell {
            font-weight: 600;
            color: #166534;
            background: #dcfce7;
            padding: 6px 14px;
            border-radius: 8px;
            display: inline-block;
            font-size: 12px;
        }

        .statut-badge {
            font-family: Arial, Helvetica, sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        .statut-badge::before {
            content: "";
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
        }

        .statut-engage {
            background-color: #dcfce7;
            color: #166534;
            border: 1px solid #86efac;
        }

        .statut-engage::before {
            background-color: #22c55e;
            box-shadow: 0 0 6px rgba(34, 197, 94, 0.4);
        }

        .statut-renvoye {
            background-color: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .statut-renvoye::before {
            background-color: #ef4444;
            box-shadow: 0 0 6px rgba(239, 68, 68, 0.4);
        }

        .statut-reembauche {
            background-color: #fefce8;
            color: #a16207;
            border: 1px solid #fde68a;
        }

        .statut-reembauche::before {
            background-color: #eab308;
            box-shadow: 0 0 6px rgba(234, 179, 8, 0.4);
        }

        .statut-default {
            background-color: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .statut-default::before {
            background-color: #94a3b8;
        }

        .salaire-montant {
            font-family: Arial, Helvetica, sans-serif;
            font-weight: 700;
            color: #15803d;
            font-size: 15px;
        }

        .salaire-indisponible {
            font-family: Arial, Helvetica, sans-serif;
            color: #94a3b8;
            font-style: italic;
            font-size: 13px;
            background: #f8fafc;
            padding: 6px 12px;
            border-radius: 6px;
            border: 1px dashed #cbd5e1;
        }

        .actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-action {
            font-family: Arial, Helvetica, sans-serif;
            padding: 8px 18px;
            border: none;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.25s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-modifier {
            background-color: #f0fdf4;
            color: #15803d;
            border: 1px solid #86efac;
        }

        .btn-modifier:hover {
            background-color: #dcfce7;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(22, 163, 74, 0.15);
        }

        .btn-supprimer {
            background-color: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .btn-supprimer:hover {
            background-color: #fee2e2;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.15);
        }

        .aucun-employe {
            font-family: Arial, Helvetica, sans-serif;
            text-align: center;
            padding: 50px 20px !important;
            color: #64748b;
            font-size: 16px;
            font-weight: 500;
        }

        .aucun-employe-icon {
            font-size: 48px;
            margin-bottom: 16px;
            color: #bbf7d0;
        }

        /* Subtle entrance animation for rows */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        tbody tr {
            animation: fadeInUp 0.4s ease forwards;
        }

        tbody tr:nth-child(1) { animation-delay: 0.05s; }
        tbody tr:nth-child(2) { animation-delay: 0.1s; }
        tbody tr:nth-child(3) { animation-delay: 0.15s; }
        tbody tr:nth-child(4) { animation-delay: 0.2s; }
        tbody tr:nth-child(5) { animation-delay: 0.25s; }
        tbody tr:nth-child(6) { animation-delay: 0.3s; }
        tbody tr:nth-child(7) { animation-delay: 0.35s; }
        tbody tr:nth-child(8) { animation-delay: 0.4s; }
        tbody tr:nth-child(9) { animation-delay: 0.45s; }
        tbody tr:nth-child(10) { animation-delay: 0.5s; }

        @media (max-width: 768px) {
            body {
                padding: 16px;
                background-color: #f0fdf4;
            }

            .container {
                padding: 24px 20px;
                border-radius: 12px;
            }

            .header {
                flex-direction: column;
                align-items: stretch;
                gap: 16px;
                margin-bottom: 24px;
            }

            h1 {
                font-size: 24px;
                text-align: center;
            }

            .header-actions {
                justify-content: center;
            }

            th, td {
                padding: 12px 14px;
                font-size: 13px;
            }

            .actions {
                flex-direction: column;
                gap: 6px;
            }

            .btn-action {
                text-align: center;
                padding: 10px 14px;
                font-size: 11px;
                justify-content: center;
            }

            .role-cell {
                padding: 4px 10px;
                font-size: 11px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .container {
                padding: 20px 14px;
            }

            th, td {
                padding: 10px 12px;
                font-size: 12px;
            }

            .statut-badge {
                font-size: 10px;
                padding: 4px 10px;
            }

            .btn-ajouter {
                font-size: 13px;
                padding: 10px 20px;
                width: 100%;
                justify-content: center;
            }

            .total-employes {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
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
                            Employes employe = (Employes) row[0];
                            Salaires salaire = (Salaires) row[1];
                            Roles role = (Roles) row[2];
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