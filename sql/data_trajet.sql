-- 1. Trajet : Antananarivo (1) -> Toamasina (2) via la RN2 (Courbes réelles)
UPDATE trajets 
SET distance_km = 358.50,
    trace = ST_GeomFromText('LINESTRING(47.5162 -18.8792, 47.7852 -18.9105, 48.0124 -18.9412, 48.2215 -18.9348, 48.4210 -18.9512, 48.5632 -18.8105, 48.8145 -18.5214, 49.0214 -18.3325, 49.2015 -18.2104, 49.3852 -18.1610, 49.4000 -18.1500)', 4326)
WHERE id = 1;

-- 2. Trajet : Toamasina (2) -> Antsirabe (3) via RN2 + RN7 (Passage par Tana contournement)
UPDATE trajets 
SET distance_km = 527.30,
    trace = ST_GeomFromText('LINESTRING(49.4000 -18.1500, 49.3852 -18.1610, 49.2015 -18.2104, 49.0214 -18.3325, 48.8145 -18.5214, 48.5632 -18.8105, 48.4210 -18.9512, 48.2215 -18.9348, 48.0124 -18.9412, 47.7852 -18.9105, 47.5162 -18.8792, 47.4812 -19.0512, 47.4210 -19.2214, 47.3105 -19.4521, 47.2104 -19.6201, 47.0852 -19.7852, 47.0333 -19.8667)', 4326)
WHERE id = 2;

-- 3. Trajet : Antsirabe (3) -> Antananarivo (1) via la RN7 (Courbes réelles Ambatolampy)
UPDATE trajets 
SET distance_km = 168.80,
    trace = ST_GeomFromText('LINESTRING(47.0333 -19.8667, 47.0852 -19.7852, 47.2104 -19.6201, 47.3105 -19.4521, 47.4210 -19.2214, 47.4812 -19.0512, 47.5162 -18.8792)', 4326)
WHERE id = 3;

UPDATE gares SET position = ST_SetSRID(ST_MakePoint(47.5162, -18.8792), 4326) WHERE id = 1;
UPDATE gares SET position = ST_SetSRID(ST_MakePoint(49.4000, -18.1500), 4326) WHERE id = 2;
UPDATE gares SET position = ST_SetSRID(ST_MakePoint(47.0333, -19.8667), 4326) WHERE id = 3;