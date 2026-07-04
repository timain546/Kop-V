<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOPERATIVE - Historique des Tarifs</title>
    <style>
        :root { --primary: #1b5e20; --blue: #0288d1; --bg: #f8f9fa; --dark: #212121; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg); color: var(--dark); margin: 0; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        h1 { color: var(--primary); border-bottom: 3px solid var(--primary); padding-bottom: 12px; }
        .retour { display:inline-block; margin-bottom: 20px; color: var(--primary); font-weight: 600; text-decoration: none; }
        .avis-lecture-seule { background: #fff8e1; border: 1px solid #ffe082; color: #8d6e00; padding: 12px 16px; border-radius: 6px; font-size: 13px; margin-bottom: 20px; }
        .toolbar { background: white; padding: 18px 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 15px; display: flex; flex-wrap: wrap; gap: 16px; align-items: flex-end; }
        .toolbar-item { display: flex; flex-direction: column; gap: 6px; }
        .toolbar-item label { font-size: 12px; margin: 0; color: #616161; }
        .toolbar input { padding: 10px 12px; border: 1px solid #bdbdbd; border-radius: 6px; }
        .btn-valider { background-color: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 6px; cursor: pointer; font-weight: bold; }
        .btn-reset-filtre { background: #f5f5f5; border: 1px solid #bdbdbd; padding: 10px 16px; border-radius: 6px; font-size: 13px; color: #616161; height: 42px; text-decoration:none; }
        .table-container { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 14px 16px; border-bottom: 1px solid #e0e0e0; font-size: 14px; }
        th { background-color: var(--primary); color: white; font-weight: 600; text-transform: uppercase; font-size: 12px; }
        th a { color: white; text-decoration: none; }
        .mouvement { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; display: inline-block; }
        .mouvement-ajout { background: #e8f5e9; color: var(--primary); border: 1px solid #c8e6c9; }
        .mouvement-modif { background: #e3f2fd; color: var(--blue); border: 1px solid #bbdefb; }
        .prix-apres { color: var(--dark); font-weight: bold; }
        .badge-code { font-family: monospace; font-weight: bold; color: var(--primary); }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/tarifs" class="retour">← Retour à la gestion des tarifs</a>
    <h1>📜 Historique des Tarifs de Voyage</h1>
    <!-- <div class="avis-lecture-seule">
        🔒 Ce journal est en <b>lecture seule</b>. Aucune saisie ni modification n'est possible ici : il s'alimente automatiquement depuis la page de gestion.
    </div> -->

    <form class="toolbar" action="${pageContext.request.contextPath}/tarifs/historique" method="get">
        <div class="toolbar-item">
            <label>Du</label>
            <input type="date" name="dateDebut" value="${dateDebut}">
        </div>
        <div class="toolbar-item">
            <label>Au</label>
            <input type="date" name="dateFin" value="${dateFin}">
        </div>
        <button type="submit" class="btn-valider">Rechercher</button>
        <a href="${pageContext.request.contextPath}/tarifs/historique" class="btn-reset-filtre">✕ Effacer les filtres</a>
    </form>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th><a href="${pageContext.request.contextPath}/tarifs/historique?asc=${!asc}">Date &amp; Heure ${asc ? '▲' : '▼'}</a></th>
                    <th>Mouvement</th>
                    <th>Code Tarif</th>
                    <th>Ligne Routière</th>
                    <th>Gamme de Confort</th>
                    <th>Évolution du Prix</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="h" items="${historique}">
                    <tr>
                        <td><fmt:formatDate value="${h.dateMouvementAsDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${h.typeMouvement == 'AJOUT'}">
                                    <span class="mouvement mouvement-ajout">＋ Ajout</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="mouvement mouvement-modif">✎ Modification</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="badge-code">#TAR-<fmt:formatNumber value="${h.tarif.id}" minIntegerDigits="3"/></td>
                        <td>${h.tarif.trajet.villeDepart} ➔ ${h.tarif.trajet.villeArrivee}</td>
                        <td>${h.tarif.categorie}</td>
                        <td>
                        <span class="prix-apres"><fmt:formatNumber value="${h.prixApres}" pattern="#,##0"/> Ar</span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty historique}">
            <div style="text-align:center; padding:40px; color:#9e9e9e;">Aucun mouvement enregistré pour le moment.</div>
        </c:if>
    </div>
</div>
</body>
</html>