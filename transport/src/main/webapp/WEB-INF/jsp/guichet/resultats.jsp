<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Voyages disponibles - KOP-V</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/resultats.css">

    </head>

    <body>

        <div class="page">

            <!-- ================= HEADER ================= -->

            <header class="topbar">

                <div class="logo">

                    <div class="logo-icon">
                        <i class="bi bi-bus-front-fill"></i>
                    </div>

                    <span>KOP<span class="green">—V</span></span>

                </div>

                <div class="steps">

                    <div class="step completed">
                        <i class="bi bi-check-lg"></i>
                        Recherche
                    </div>

                    <div class="separator"></div>

                    <div class="step active">
                        <i class="bi bi-bus-front"></i>
                        Voyages
                    </div>

                    <div class="separator"></div>

                    <div class="step">
                        <i class="bi bi-credit-card"></i>
                        Places
                    </div>

                    <div class="separator"></div>

                    <div class="step">
                        <i class="bi bi-person"></i>
                        Passagers
                    </div>

                </div>

                <div class="help">
                    Aide ? +261 34 00 000 00
                </div>

            </header>

            <!-- ================= CONTENU ================= -->

            <main class="content">

                <section class="left-panel">

                    <div class="step-title">

                        <span>ÉTAPE 2 / 4</span>

                        <h1>Antananarivo → Antsirabe</h1>

                        <p>6 voyages disponibles · mardi 30 juin</p>

                    </div>

                    <div class="modify-search">
                        ← Modifier la recherche
                    </div>

                    <!-- ================= TRI ================= -->

                    <div class="toolbar">

                        <div class="sorting">

                            <span class="label">
                                <i class="bi bi-filter"></i>
                                Trier
                            </span>

                            <button class="selected">Horaire</button>
                            <button>Prix</button>
                            <button>Durée</button>

                        </div>

                        <div class="classes">

                            <span class="label">
                                <i class="bi bi-funnel"></i>
                                Classe
                            </span>

                            <button class="selected">Toutes</button>
                            <button>Standard</button>
                            <button>Confort</button>
                            <button>VIP</button>

                        </div>

                    </div>

                    <!-- ================= LISTE DES VOYAGES ================= -->

                    <div class="voyages">

                        <!-- VOYAGE 1 -->

                        <article class="voyage-card">

                            <div class="company">

                                <div class="bus-icon">
                                    <i class="bi bi-bus-front-fill"></i>
                                </div>

                                <div>

                                    <h3>KOP-V Express</h3>

                                    <span>Bus 45 places</span>

                                </div>

                            </div>

                            <div class="departure">

                                <h2>05:30</h2>

                                <span>Antananarivo</span>

                            </div>

                            <div class="timeline">

                                <div class="line"></div>

                                <div class="duration">
                                    <i class="bi bi-clock"></i>
                                    4h 45min
                                </div>

                                <div class="badge standard">
                                    STANDARD
                                </div>

                            </div>

                            <div class="arrival">

                                <h2>10:15</h2>

                                <span>Antsirabe</span>

                            </div>

                            <div class="price">

                                <h2>25 000 Ar</h2>

                                <span>12 places restantes</span>

                                <button>
                                    Choisir
                                    <i class="bi bi-arrow-right"></i>
                                </button>

                            </div>

                        </article>

                        <!-- VOYAGE 2 -->

                        <article class="voyage-card">

                            <div class="company">

                                <div class="bus-icon">
                                    <i class="bi bi-bus-front-fill"></i>
                                </div>

                                <div>

                                    <h3>KOP-V Confort</h3>

                                    <span>Minibus 22 places</span>

                                </div>

                            </div>

                            <div class="departure">

                                <h2>07:00</h2>

                                <span>Antananarivo</span>

                            </div>

                            <div class="timeline">

                                <div class="line"></div>

                                <div class="duration">
                                    <i class="bi bi-clock"></i>
                                    4h 45min
                                </div>

                                <div class="badge confort">
                                    CONFORT
                                </div>

                            </div>

                            <div class="arrival">

                                <h2>11:45</h2>

                                <span>Antsirabe</span>

                            </div>

                            <div class="price">

                                <h2>40 000 Ar</h2>

                                <span class="warning">
                                    Plus que 5 places
                                </span>

                                <button>
                                    Choisir
                                    <i class="bi bi-arrow-right"></i>
                                </button>

                            </div>

                        </article>
                        <!-- VOYAGE 3 -->

                        <article class="voyage-card">

                            <div class="company">

                                <div class="bus-icon">
                                    <i class="bi bi-bus-front-fill"></i>
                                </div>

                                <div>

                                    <h3>KOP-V Premium</h3>

                                    <span>Sprinter VIP 18 places</span>

                                </div>

                            </div>

                            <div class="departure">

                                <h2>09:15</h2>

                                <span>Antananarivo</span>

                            </div>

                            <div class="timeline">

                                <div class="line"></div>

                                <div class="duration">
                                    <i class="bi bi-clock"></i>
                                    4h 45min
                                </div>

                                <div class="badge vip">
                                    VIP
                                </div>

                            </div>

                            <div class="arrival">

                                <h2>14:00</h2>

                                <span>Antsirabe</span>

                            </div>

                            <div class="price">

                                <h2>55 000 Ar</h2>

                                <span>22 places restantes</span>

                                <button>
                                    Choisir
                                    <i class="bi bi-arrow-right"></i>
                                </button>

                            </div>

                        </article>

                        <!-- VOYAGE 4 -->

                        <article class="voyage-card">

                            <div class="company">

                                <div class="bus-icon">
                                    <i class="bi bi-bus-front-fill"></i>
                                </div>

                                <div>

                                    <h3>KOP-V Express</h3>

                                    <span>Bus 45 places</span>

                                </div>

                            </div>

                            <div class="departure">

                                <h2>12:00</h2>

                                <span>Antananarivo</span>

                            </div>

                            <div class="timeline">

                                <div class="line"></div>

                                <div class="duration">
                                    <i class="bi bi-clock"></i>
                                    4h 45min
                                </div>

                                <div class="badge standard">
                                    STANDARD
                                </div>

                            </div>

                            <div class="arrival">

                                <h2>16:50</h2>

                                <span>Antsirabe</span>

                            </div>

                            <div class="price">

                                <h2>27 000 Ar</h2>

                                <span class="warning">
                                    Plus que 3 places
                                </span>

                                <button>
                                    Choisir
                                    <i class="bi bi-arrow-right"></i>
                                </button>

                            </div>

                        </article>

                        <!-- VOYAGE 5 -->

                        <article class="voyage-card">

                            <div class="company">

                                <div class="bus-icon">
                                    <i class="bi bi-bus-front-fill"></i>
                                </div>

                                <div>

                                    <h3>KOP-V Confort</h3>

                                    <span>Minibus 22 places</span>

                                </div>

                            </div>

                            <div class="departure">

                                <h2>14:00</h2>

                                <span>Antananarivo</span>

                            </div>

                            <div class="timeline">

                                <div class="line"></div>

                                <div class="duration">
                                    <i class="bi bi-clock"></i>
                                    4h 45min
                                </div>

                                <div class="badge confort">
                                    CONFORT
                                </div>

                            </div>

                            <div class="arrival">

                                <h2>18:45</h2>

                                <span>Antsirabe</span>

                            </div>

                            <div class="price">

                                <h2>38 000 Ar</h2>

                                <span>15 places restantes</span>

                                <button>
                                    Choisir
                                    <i class="bi bi-arrow-right"></i>
                                </button>

                            </div>

                        </article>

                        <!-- VOYAGE 6 -->

                        <article class="voyage-card">

                            <div class="company">

                                <div class="bus-icon">
                                    <i class="bi bi-bus-front-fill"></i>
                                </div>

                                <div>

                                    <h3>KOP-V Premium</h3>

                                    <span>Sprinter VIP 18 places</span>

                                </div>

                            </div>

                            <div class="departure">

                                <h2>16:30</h2>

                                <span>Antananarivo</span>

                            </div>

                            <div class="timeline">

                                <div class="line"></div>

                                <div class="duration">
                                    <i class="bi bi-clock"></i>
                                    4h 45min
                                </div>

                                <div class="badge vip">
                                    VIP
                                </div>

                            </div>

                            <div class="arrival">

                                <h2>21:15</h2>

                                <span>Antsirabe</span>

                            </div>

                            <div class="price">

                                <h2>55 000 Ar</h2>

                                <span>8 places restantes</span>

                                <button>
                                    Choisir
                                    <i class="bi bi-arrow-right"></i>
                                </button>

                            </div>

                        </article>

                    </div>

                </section>

                <!-- ================= SIDEBAR ================= -->

                <aside class="summary">

                    <div class="summary-header">

                        <span>RÉCAPITULATIF</span>

                        <h2>Votre voyage</h2>

                    </div>

                    <div class="summary-body">

                        <div class="item">

                            <i class="bi bi-geo-alt"></i>

                            <div>

                                <small>TRAJET</small>

                                <strong>Antananarivo → Antsirabe</strong>

                            </div>

                        </div>

                        <div class="item">

                            <i class="bi bi-calendar3"></i>

                            <div>

                                <small>DATE</small>

                                <strong>mar. 30 juin</strong>

                            </div>

                        </div>

                        <div class="item">

                            <i class="bi bi-people"></i>

                            <div>

                                <small>PASSAGERS</small>

                                <strong>1 personne</strong>

                            </div>

                        </div>

                        <hr>

                        <div class="company-selected">

                            <small>COMPAGNIE</small>

                            <h3>KOP-V Express</h3>

                            <span>05:30 — 10:15 · Standard</span>

                        </div>

                        <hr>

                        <div class="total">

                            <span>TOTAL</span>

                            <h2>25 000 Ar</h2>

                        </div>

                        <p class="footer-note">

                            Place garantie · Paiement sécurisé ·
                            Annulation possible jusqu'à 24h avant départ.

                        </p>

                    </div>

                </aside>

            </main>

        </div>

    </body>

    </html>