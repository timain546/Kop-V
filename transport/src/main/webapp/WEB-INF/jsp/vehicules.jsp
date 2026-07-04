<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KOPERATIVE - Gestion des Véhicules</title>
    <style>
        :root {
            --primary: #2e6b47;         /* vert palmier profond */
            --primary-dark: #1f4d33;    /* vert plus foncé pour hover */
            --primary-light: #e6f0ea;   /* fond très clair, teinté vert */
            --accent: #d97706;          /* orange discret pour alertes */
            --bg: #f7f9f8;
            --dark: #212121;
            --danger: #c0392b;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: var(--bg);
            color: var(--dark);
            margin: 0;
            padding: 20px;
        }
        .container { max-width: 1150px; margin: 0 auto; }
        h1 { color: var(--primary); border-bottom: 3px solid var(--primary); padding-bottom: 12px; }
        h3 { margin-top: 0; color: var(--primary); }

        .card-form {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(46,107,71,0.08);
            margin-bottom: 35px;
            border: 1px solid #e0e8e3;
        }
        .grid-champs {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 14px; color: #435347; }
        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #c8d6cd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
            background: #fdfefd;
        }
        input:focus, select:focus { border-color: var(--primary); outline: none; box-shadow: 0 0 0 3px rgba(46,107,71,0.1); }

        .btn-valider {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 14px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            transition: background 0.2s;
        }
        .btn-valider:hover { background-color: var(--primary-dark); }

        .table-container {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 14px rgba(46,107,71,0.08);
            border: 1px solid #e0e8e3;
        }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 16px; border-bottom: 1px solid #eef2ef; }
        th {
            background-color: var(--primary);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.03em;
        }
        tr:hover { background-color: var(--primary-light); }
        tbody tr:last-child td { border-bottom: none; }

        .confort {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }
        .confort-VIP { background: #fdf0e0; color: var(--accent); border: 1px solid #f5d9ad; }
        .confort-PREMIUM { background: #e3edf5; color: #2c5f8a; border: 1px solid #c2d9ea; }
        .confort-STANDARD { background: var(--primary-light); color: var(--primary); border: 1px solid #c8ddd0; }

        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }
        .status-actif { background: var(--primary-light); color: var(--primary); border: 1px solid #c8ddd0; }
        .status-vendre { background: #fbe9e7; color: var(--danger); border: 1px solid #f3c6bf; }
        .date-vente { font-size: 12px; color: #7c8a80; display: block; margin-top: 4px; }

        .action-modifier {
            color: #2c5f8a;
            font-weight: 600;
            margin-right: 12px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .action-vendre {
            color: var(--danger);
            font-weight: 600;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .action-modifier:hover, .action-vendre:hover { text-decoration: underline; }

        .empty-state { text-align: center; padding: 40px; color: #9aa89f; }

        .modal-overlay {
            display: none;
            position: fixed; inset: 0;
            background: rgba(31,77,51,0.35);
            align-items: center; justify-content: center;
            z-index: 100;
        }
        .modal-overlay.active { display: flex; }
        .modal-box {
            background: white;
            width: 100%; max-width: 500px;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 10px 34px rgba(0,0,0,0.18);
        }
        .modal-close { cursor: pointer; font-size: 20px; color: #7c8a80; border: none; background: none; float: right; }
        .modal-footer { margin-top: 20px; text-align: right; }
        .btn-annuler {
            background: white;
            color: var(--dark);
            border: 1px solid #c8d6cd;
            padding: 14px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        @media (max-width: 600px) {
            th, td { padding: 10px; font-size: 13px; }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🚐 Gestion des Véhicules</h1>

    <div class="card-form">
        <h3>Enregistrer un Nouveau Véhicule</h3>
        <form action="${pageContext.request.contextPath}/vehicules/ajouter" method="post">
            <div class="grid-champs">
                <div>
                    <label for="immatriculation">Immatriculation</label>
                    <input type="text" id="immatriculation" name="immatriculation" placeholder="Ex: 4567 TBA" required>
                </div>
                <div>
                    <label for="marque">Marque</label>
                    <input type="text" id="marque" name="marque" placeholder="Ex: Toyota" required>
                </div>
                <div>
                    <label for="modele">Modèle</label>
                    <input type="text" id="modele" name="modele" placeholder="Ex: Hiace" required>
                </div>
                <div>
                    <label for="nombrePlaces">Nombre de Places</label>
                    <input type="number" id="nombrePlaces" name="nombrePlaces" min="1" placeholder="Ex: 18" required>
                </div>
                <div>
                    <label for="categorie">Gamme de Confort</label>
                    <select id="categorie" name="categorie" required>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}">${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label for="prixAchat">Prix d'Achat (Ariary)</label>
                    <input type="number" id="prixAchat" name="prixAchat" min="0" step="10000" placeholder="Ex: 25000000" required>
                </div>
            </div>
            <div style="margin-top: 20px;">
                <button type="submit" class="btn-valider">Enregistrer le Véhicule</button>
            </div>
        </form>
    </div>

    <h3>Véhicules Enregistrés</h3>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Immatriculation</th>
                    <th>Marque / Modèle</th>
                    <th>Places</th>
                    <th>Gamme de Confort</th>
                    <th>Prix d'Achat</th>
                    <th>STATUS</th>
                    <th>Options de Gestion</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="v" items="${vehicules}">
                    <tr>
                        <td><b>${v.immatriculation}</b></td>
                        <td>${v.marque} ${v.modele}</td>
                        <td>${v.nombrePlaces}</td>
                        <td><span class="confort confort-${v.categorie}">${v.categorie}</span></td>
                        <td><fmt:formatNumber value="${v.prixAchat}" pattern="#,##0"/> Ar</td>
                        <td>
                            <c:choose>
                                <c:when test="${v.dateVente != null}">
                                    <span class="status status-vendre">À vendre</span>
                                    <span class="date-vente">${v.dateVente}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status status-actif">Actif</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="action-modifier"
                                onclick="ouvrirModale('${v.id}', '${v.immatriculation}', '${v.categorie}')">Modifier</button>

                            <c:if test="${statutHorsService[v.id] == true && v.dateVente == null}">
                                <form action="${pageContext.request.contextPath}/vehicules/vendre/${v.id}"
                                      method="post" style="display:inline;"
                                      onsubmit="return confirm('Confirmer la mise en vente de ce véhicule ? Cette action est définitive.');">
                                    <button type="submit" class="action-vendre">À vendre</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty vehicules}">
            <div class="empty-state">Aucun véhicule enregistré pour le moment.</div>
        </c:if>
    </div>
</div>

<div class="modal-overlay" id="modal-overlay">
    <div class="modal-box">
        <button class="modal-close" onclick="fermerModale()">✕</button>
        <h3>Modifier le Véhicule</h3>
        <form id="form-modif" method="post">
            <div style="margin-bottom:16px;">
                <label for="modif-immatriculation">Immatriculation</label>
                <input type="text" id="modif-immatriculation" name="immatriculation" required>
            </div>
            <div>
                <label for="modif-categorie">Gamme de Confort</label>
                <select id="modif-categorie" name="categorie" required>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}">${cat}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-annuler" onclick="fermerModale()">Annuler</button>
                <button type="submit" class="btn-valider">Enregistrer la Modification</button>
            </div>
        </form>
    </div>
</div>

<script>
    function ouvrirModale(id, immat, categorie) {
        document.getElementById('form-modif').action = '${pageContext.request.contextPath}/vehicules/modifier/' + id;
        document.getElementById('modif-immatriculation').value = immat;
        document.getElementById('modif-categorie').value = categorie;
        document.getElementById('modal-overlay').classList.add('active');
    }
    function fermerModale() {
        document.getElementById('modal-overlay').classList.remove('active');
    }
</script>
</body>
</html>