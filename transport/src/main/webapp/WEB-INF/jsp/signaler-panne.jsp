<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entity.MotifPanne" %>

<%
    List<MotifPanne> motifs = (List<MotifPanne>) request.getAttribute("listeMotifs");
    Long idVoyage = (Long) request.getAttribute("idVoyage");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signaler une panne</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 400px;
            margin: auto;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }
        textarea {
            resize: vertical;
            height: 100px;
        }
        button {
            width: 100%;
            padding: 15px;
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #c0392b;
        }
        .success-msg {
            color: green;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Signaler une Panne</h2>

    <% if (success != null && success.equals("true")) { %>
        <div class="success-msg">Panne signalée avec succès !</div>
    <% } %>

    <form action="/chauffeur/voyage/panne" method="post" enctype="multipart/form-data">
        <input type="hidden" name="idVoyage" value="<%= idVoyage != null ? idVoyage : "" %>">

        <div class="form-group">
            <label for="lieu">Lieu de la panne *</label>
            <input type="text" id="lieu" name="lieu" placeholder="Ex: Autoroute A6, PK 123" required>
        </div>

        <div class="form-group">
            <label for="idMotif">Motif *</label>
            <select id="idMotif" name="idMotif" required>
                <option value="">Sélectionnez un motif</option>
                <% if (motifs != null) {
                    for (MotifPanne motif : motifs) { %>
                        <option value="<%= motif.getId() %>"><%= motif.getLibelle() %></option>
                <%  }
                } %>
            </select>
        </div>

        <div class="form-group">
            <label for="description">Description (Optionnel)</label>
            <textarea id="description" name="description" placeholder="Détails supplémentaires..."></textarea>
        </div>

        <div class="form-group">
            <label for="photo">Photo</label>
            <!-- 
              NOTE: Pour rendre la photo obligatoire, ajoutez simplement l'attribut 'required' 
              à la balise <input> ci-dessous.
              Exemple : <input type="file" id="photo" name="photo" accept="image/*" required>
            -->
            <input type="file" id="photo" name="photo" accept="image/*">
        </div>

        <button type="submit">Envoyer le signalement</button>
    </form>
</div>

</body>
</html>
