<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOPERATIVE - Dépenses</title>
    <style>
        :root { --primary: #1b5e20; --blue: #0288d1; --red: #c62828; --bg: #f8f9fa; --dark: #212121; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg); color: var(--dark); margin: 0; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        h1 { color: var(--primary); border-bottom: 3px solid var(--primary); padding-bottom: 12px; }
        .toolbar { background: white; padding: 18px 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-bottom: 20px; display: flex; flex-wrap: wrap; gap: 16px; align-items: flex-end; }
        .toolbar-item { display: flex; flex-direction: column; gap: 6px; }
        .toolbar-item label { font-size: 12px; margin: 0; color: #616161; }
        .toolbar input, .toolbar select { padding: 10px 12px; border: 1px solid #bdbdbd; border-radius: 6px; }
        .separateur-toolbar { align-self: center; color: #9e9e9e; font-size: 13px; margin: 0 4px 10px; }
        .btn-valider { background-color: var(--primary); color: white; border: none; padding: 10px 20px; border-radius: 6px; cursor: pointer; font-weight: bold; }
        .btn-reset-filtre { background: #f5f5f5; border: 1px solid #bdbdbd; padding: 10px 16px; border-radius: 6px; font-size: 13px; color: #616161; height: 42px; text-decoration: none; display: inline-flex; align-items: center; }

        .cartes { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px; margin-bottom: 20px; }
        .carte { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-left: 4px solid var(--primary); }
        .carte-total { border-left-color: var(--red); }
        .carte-label { font-size: 12px; text-transform: uppercase; color: #757575; font-weight: 600; margin-bottom: 8px; }
        .carte-montant { font-size: 24px; font-weight: bold; color: var(--dark); }
        .carte-total .carte-montant { color: var(--red); }

        .table-container { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 14px 16px; border-bottom: 1px solid #e0e0e0; font-size: 14px; }
        th { background-color: var(--primary); color: white; font-weight: 600; text-transform: uppercase; font-size: 12px; }
        .montant { font-weight: bold; }
        tr.ligne-total td { font-weight: bold; background: #fafafa; }
    </style>
</head>
<body>
<div class="container">
    <h1>💸 Dépenses de l'entreprise</h1>

    <form class="toolbar" action="${pageContext.request.contextPath}/depenses" method="get">
        <div class="toolbar-item">
            <label>Du</label>
            <input type="date" name="dateDebut" value="${dateDebut}">
        </div>
        <div class="toolbar-item">
            <label>Au</label>
            <input type="date" name="dateFin" value="${dateFin}">
        </div>

        <span class="separateur-toolbar">ou</span>

        <div class="toolbar-item">
            <label>Mois</label>
            <select name="mois">
                <option value="">--</option>
                <c:forEach var="m" begin="1" end="12">
                    <option value="${m}" ${mois == m ? 'selected' : ''}>
                        <fmt:parseDate value="2000-${m}-01" pattern="yyyy-M-dd" var="dateMois"/>
                        <fmt:formatDate value="${dateMois}" pattern="MMMM"/>
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="toolbar-item">
            <label>Année</label>
            <input type="number" name="annee" placeholder="2026" value="${annee}" min="2000" max="2100">
        </div>

        <button type="submit" class="btn-valider">Filtrer</button>
        <a href="${pageContext.request.contextPath}/depenses" class="btn-reset-filtre">✕ Effacer les filtres</a>
    </form>

    <div class="cartes">
        <div class="carte">
            <div class="carte-label">Achat véhicules</div>
            <div class="carte-montant"><fmt:formatNumber value="${depenseVehicules}" pattern="#,##0"/> Ar</div>
        </div>
        <div class="carte">
            <div class="carte-label">Salaires</div>
            <div class="carte-montant"><fmt:formatNumber value="${depenseSalaires}" pattern="#,##0"/> Ar</div>
        </div>
        <div class="carte">
            <div class="carte-label">Réparations</div>
            <div class="carte-montant"><fmt:formatNumber value="${depenseReparations}" pattern="#,##0"/> Ar</div>
        </div>
        <div class="carte carte-total">
            <div class="carte-label">Total dépenses</div>
            <div class="carte-montant"><fmt:formatNumber value="${depenseTotale}" pattern="#,##0"/> Ar</div>
        </div>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Catégorie</th>
                    <th>Montant</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Achat véhicules</td>
                    <td class="montant"><fmt:formatNumber value="${depenseVehicules}" pattern="#,##0"/> Ar</td>
                </tr>
                <tr>
                    <td>Salaires</td>
                    <td class="montant"><fmt:formatNumber value="${depenseSalaires}" pattern="#,##0"/> Ar</td>
                </tr>
                <tr>
                    <td>Réparations</td>
                    <td class="montant"><fmt:formatNumber value="${depenseReparations}" pattern="#,##0"/> Ar</td>
                </tr>
                <tr class="ligne-total">
                    <td>Total</td>
                    <td class="montant"><fmt:formatNumber value="${depenseTotale}" pattern="#,##0"/> Ar</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
