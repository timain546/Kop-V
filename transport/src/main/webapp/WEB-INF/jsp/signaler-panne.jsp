<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cooperative.transport.entities.MotifPanne" %>

<%
    List<MotifPanne> motifs = (List<MotifPanne>) request.getAttribute("listeMotifs");
    Long idVoyage = (Long) request.getAttribute("idVoyage");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Signaler une panne</title>
    
    <!-- Police Google Fonts: Outfit (Moderne et Premium) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --border-color: rgba(255, 255, 255, 0.1);
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --primary: #ef4444;
            --primary-hover: #dc2626;
            --primary-glow: rgba(239, 68, 68, 0.25);
            --success: #10b981;
            --success-bg: rgba(16, 185, 129, 0.15);
            --input-bg: #1e293b;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Outfit', sans-serif;
            -webkit-tap-highlight-color: transparent;
        }

        body {
            background: radial-gradient(circle at top, #1e1b4b 0%, #0f172a 100%);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            padding: 16px;
        }

        /* En-tête de navigation mobile */
        .app-header {
            width: 100%;
            max-width: 480px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            padding: 8px 4px;
        }

        .back-btn {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border-color);
            color: var(--text-main);
            padding: 10px 16px;
            border-radius: 9999px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
        }

        .back-btn:active {
            background: rgba(255, 255, 255, 0.1);
            transform: scale(0.95);
        }

        .header-title {
            font-size: 15px;
            font-weight: 500;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .container {
            width: 100%;
            max-width: 480px;
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 24px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3), 0 10px 10px -5px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(12px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 8px;
            text-align: left;
            background: linear-gradient(135deg, #ff8a8a 0%, #ef4444 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .subtitle {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 24px;
            line-height: 1.5;
        }

        .success-card {
            background: var(--success-bg);
            border: 1px solid rgba(16, 185, 129, 0.3);
            border-radius: 16px;
            padding: 16px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-icon {
            background: var(--success);
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
            flex-shrink: 0;
        }

        .success-msg {
            color: #d1fae5;
            font-size: 14px;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-main);
        }

        /* Inputs & Select */
        input[type="text"], select, textarea {
            width: 100%;
            background-color: var(--input-bg);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            color: var(--text-main);
            padding: 14px 16px;
            font-size: 16px;
            font-weight: 400;
            outline: none;
            transition: all 0.2s ease;
            -webkit-appearance: none; /* remove iOS default arrow styling */
        }

        /* Select arrow icon custom styling for mobile */
        .select-wrapper {
            position: relative;
        }
        .select-wrapper::after {
            content: '▼';
            font-size: 10px;
            color: var(--text-muted);
            right: 16px;
            top: 18px;
            position: absolute;
            pointer-events: none;
        }

        textarea {
            resize: none;
            height: 96px;
            line-height: 1.5;
        }

        input[type="text"]:focus, select:focus, textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-glow);
        }

        /* Custom File Upload */
        .file-upload-wrapper {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border: 2px dashed rgba(255, 255, 255, 0.15);
            border-radius: 16px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.02);
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .file-upload-wrapper:active {
            background: rgba(255, 255, 255, 0.05);
            border-color: var(--primary);
        }

        .file-upload-icon {
            font-size: 28px;
            margin-bottom: 8px;
            color: var(--text-muted);
        }

        .file-upload-text {
            font-size: 14px;
            font-weight: 500;
            color: var(--text-main);
            margin-bottom: 4px;
        }

        .file-upload-subtext {
            font-size: 12px;
            color: var(--text-muted);
        }

        /* Cacher l'input natif moche */
        .file-upload-input {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .file-preview-name {
            margin-top: 8px;
            font-size: 13px;
            color: var(--primary);
            font-weight: 500;
            display: none;
        }

        /* Bouton Soumettre */
        button {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            border: none;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 0.02em;
            cursor: pointer;
            margin-top: 12px;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            transition: all 0.2s ease;
        }

        button:active {
            transform: scale(0.98);
            background: #b91c1c;
            box-shadow: 0 2px 6px rgba(239, 68, 68, 0.3);
        }
    </style>
</head>
<body>

    <!-- En-tête mobile -->
    <header class="app-header">
        <a href="#" class="back-btn">
            ← Voyage
        </a>
        <span class="header-title">Sécurité</span>
        <div style="width: 70px;"></div> <!-- Espaceur équilibré -->
    </header>

    <div class="container">
        <h2>Signaler une panne</h2>
        <p class="subtitle">Transmettez immédiatement le statut de votre panne au Responsable d'Exploitation (RE).</p>

        <% if (success != null && success.equals("true")) { %>
            <div class="success-card">
                <div class="success-icon">✓</div>
                <div class="success-msg">Panne signalée avec succès et transmise au RE. Voyage mis en arrêt.</div>
            </div>
        <% } %>

        <form action="/chauffeur/voyage/panne" method="post" enctype="multipart/form-data">
            <input type="hidden" name="idVoyage" value="<%= idVoyage != null ? idVoyage : "" %>">

            <div class="form-group">
                <label for="lieu">Lieu de la panne *</label>
                <input type="text" id="lieu" name="lieu" placeholder="Ex: RN7, PK 145 - Près d'Antsirabe" required>
            </div>

            <div class="form-group">
                <label for="idMotif">Motif de la panne *</label>
                <div class="select-wrapper">
                    <select id="idMotif" name="idMotif" required>
                        <option value="">Sélectionnez une catégorie</option>
                        <% if (motifs != null) {
                            for (MotifPanne motif : motifs) { %>
                                <option value="<%= motif.getId() %>"><%= motif.getLibelle() %></option>
                        <%  }
                        } %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Détails (Optionnel)</label>
                <textarea id="description" name="description" placeholder="Ex: Surchauffe moteur, bruit suspect, crevaison..."></textarea>
            </div>

            <div class="form-group">
                <label>Preuve visuelle (Optionnel)</label>
                <div class="file-upload-wrapper">
                    <div class="file-upload-icon">📸</div>
                    <div class="file-upload-text">Prendre ou uploader une photo</div>
                    <div class="file-upload-subtext">Format image accepté</div>
                    <input type="file" id="photo" name="photo" class="file-upload-input" accept="image/*">
                </div>
                <div class="file-preview-name" id="file-preview"></div>
            </div>

            <button type="submit">Signaler l'arrêt</button>
        </form>
    </div>

    <script>
        // Afficher le nom du fichier sélectionné
        const fileInput = document.getElementById('photo');
        const filePreview = document.getElementById('file-preview');
        const uploadWrapper = document.querySelector('.file-upload-wrapper');

        fileInput.addEventListener('change', function(e) {
            if (this.files && this.files.length > 0) {
                const name = this.files[0].name;
                filePreview.innerText = "Fichier sélectionné : " + name;
                filePreview.style.display = 'block';
                uploadWrapper.style.borderColor = 'var(--success)';
            } else {
                filePreview.style.display = 'none';
                uploadWrapper.style.borderColor = 'rgba(255, 255, 255, 0.15)';
            }
        });
    </script>
</body>
</html>
