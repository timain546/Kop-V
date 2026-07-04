<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOPERATIVE - Gestion des Tarifs</title>
    <style>
        :root { --primary: #1b5e20; --primary-dark: #0d3c12; --secondary: #e65100; --bg: #f8f9fa; --dark: #212121; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg); color: var(--dark); margin: 0; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        h1 { color: var(--primary); border-bottom: 3px solid var(--primary); padding-bottom: 12px; }
        h3 { margin-top: 0; color: var(--primary); }
        .card-form { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); margin-bottom: 35px; }
        .grid-champs { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 14px; color: #424242; }
        input, select { width: 100%; padding: 12px; border: 1px solid #bdbdbd; border-radius: 6px; box-sizing: border-box; font-size: 14px; }
        input:focus, select:focus { border-color: var(--primary); outline: none; }
        .btn-valider { background-color: var(--primary); color: white; border: none; padding: 14px 24px; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 14px; }
        .btn-valider:hover { background-color: var(--primary-dark); }
        .toolbar { background: white; padding: 18px 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 15px; display: flex; flex-wrap: wrap; gap: 16px; align-items: flex-end; }
        .toolbar-item { display: flex; flex-direction: column; gap: 6px; }
        .toolbar-item label { font-size: 12px; margin: 0; color: #616161; }
        .toolbar-item input { min-width: 160px; }
        .btn-reset-filtre { background: #f5f5f5; border: 1px solid #bdbdbd; padding: 10px 16px; border-radius: 6px; font-size: 13px; color: #616161; height: 42px; text-decoration:none; }
        .table-container { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 16px; border-bottom: 1px solid #e0e0e0; }
        th { background-color: var(--primary); color: white; font-weight: 600; text-transform: uppercase; font-size: 13px; }
        th a { color: white; text-decoration: none; }
        tr:hover { background-color: #f5f5f5; }
        .confort { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; display: inline-block; }
        .confort-VIP { background: #fff3e0; color: var(--secondary); border: 1px solid #ffe0b2; }
        .confort-PREMIUM { background: #e3f2fd; color: #0d47a1; border: 1px solid #bbdefb; }
        .confort-STANDARD { background: #e8f5e9; color: var(--primary); border: 1px solid #c8e6c9; }
        .action-modifier { color: #0288d1; font-weight: 600; background:none; border:none; cursor:pointer; font-size:14px; }
        .empty-state { text-align:center; padding: 40px; color:#9e9e9e; }
        .badge-code { font-family: monospace; font-weight: bold; color: var(--primary); }
        .modal-overlay { display:none; position: fixed; inset: 0; background: rgba(0,0,0,0.45); align-items: center; justify-content: center; z-index: 100; }
        .modal-overlay.active { display: flex; }
        .modal-box { background: white; width: 100%; max-width: 480px; border-radius: 8px; padding: 25px; box-shadow: 0 8px 30px rgba(0,0,0,0.2); }
        .modal-close { cursor:pointer; font-size: 20px; color:#757575; border:none; background:none; float:right; }
        .modal-footer { margin-top: 20px; text-align: right; }
        .btn-annuler { background: white; color: var(--dark); border: 1px solid #bdbdbd; padding: 14px 24px; border-radius: 6px; cursor: pointer; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <h1>💰 Gestion des Tarifs de Voyage</h1>

    <div class="card-form">
        <h3>Enregistrer un Nouveau Tarif</h3>
        <form action="${pageContext.request.contextPath}/tarifs/ajouter" method="post">
            <div class="grid-champs">
                <div>
                    <label for="trajetId">Trajet (Itinéraire)</label>
                    <select id="trajetId" name="trajetId" required>
                        <option value="">-- Sélectionner un trajet --</option>
                        <c:forEach var="t" items="${trajets}">
                            <option value="${t.id}">${t.villeDepart} ➔ ${t.villeArrivee} — ${t.distanceKm} km</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label for="categorie">Gamme de Confort</label>
                    <select id="categorie" name="categorie" required>
                        <option value="">-- Sélectionner une gamme --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}">${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label for="dateInsertion">Date d'Insertion</label>
                    <input type="date" id="dateInsertion" name="dateInsertion" required>
                </div>
                <div>
                    <label for="prix">Prix du Tarif (Ariary)</label>
                    <input type="number" id="prix" name="prix" min="0" step="500" placeholder="Ex: 45000" required>
                </div>
            </div>
            <div style="margin-top: 20px;">
                <button type="submit" class="btn-valider">Enregistrer le Tarif</button>
            </div>
        </form>
    </div>

    <h3>Tarifs Actuellement Enregistrés</h3>

    <form class="toolbar" action="${pageContext.request.contextPath}/tarifs" method="get">
        <div class="toolbar-item">
            <label>Date d'enregistrement — Du</label>
            <input type="date" name="dateDebut" value="${dateDebut}">
        </div>
        <div class="toolbar-item">
            <label>Au</label>
            <input type="date" name="dateFin" value="${dateFin}">
        </div>
        <button type="submit" class="btn-valider" style="height:42px;">Rechercher</button>
        <a href="${pageContext.request.contextPath}/tarifs" class="btn-reset-filtre">✕ Effacer les filtres</a>
    </form>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Code Tarif</th>
                    <th>Ligne Routière (Itinéraire)</th>
                    <th>Gamme de Confort</th>
                    <th>Prix Tarif</th>
                    <th>
                        <a href="${pageContext.request.contextPath}/tarifs?asc=${!asc}">
                            Date Enregistrement ${asc ? '▲' : '▼'}
                        </a>
                    </th>
                    
                    <th>Options de Gestion</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="tarif" items="${tarifs}">
                    <tr>
                        <td class="badge-code">#TAR-<fmt:formatNumber value="${tarif.id}" minIntegerDigits="3"/></td>
                        <td><b>${tarif.trajet.villeDepart} ➔ ${tarif.trajet.villeArrivee}</b><br>
                            <small>Distance : ${tarif.trajet.distanceKm} km</small></td>
                        <td><span class="confort confort-${tarif.categorie}">${tarif.categorie}</span></td>
                        <td><b><fmt:formatNumber value="${tarif.prixTarif}" pattern="#,##0"/> Ar</b></td>
                        <td><fmt:formatDate value="${tarif.dateEnregistrementAsDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                        
                        <td>
                            <button type="button" class="action-modifier"
                                onclick="ouvrirModale('${tarif.id}', '${tarif.prixTarif}')">Modifier</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty tarifs}">
            <div class="empty-state">Aucun tarif enregistré pour le moment.</div>
        </c:if>
    </div>

    <p style="margin-top:20px;">
        <a href="${pageContext.request.contextPath}/tarifs/historique" style="color:var(--primary); font-weight:600;">
            📜 Voir l'historique complet des tarifs (lecture seule) →
        </a>
    </p>
</div>

<div class="modal-overlay" id="modal-overlay">
    <div class="modal-box">
        <button class="modal-close" onclick="fermerModale()">✕</button>
        <h3>Modifier le Tarif</h3>
        <form id="form-modif" method="post">
            <div style="margin-bottom:16px;">
                <label for="modif-prix">Nouveau Prix (Ariary)</label>
                <input type="number" id="modif-prix" name="prix" min="0" step="500" required>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-annuler" onclick="fermerModale()">Annuler</button>
                <button type="submit" class="btn-valider">Enregistrer la Modification</button>
            </div>
        </form>
    </div>
</div>

<script>
    function ouvrirModale(id, prixActuel) {
        document.getElementById('form-modif').action = '${pageContext.request.contextPath}/tarifs/modifier/' + id;
        document.getElementById('modif-prix').value = prixActuel;
        document.getElementById('modal-overlay').classList.add('active');
    }
    function fermerModale() {
        document.getElementById('modal-overlay').classList.remove('active');
    }
</script>
</script>
</body>
</html>