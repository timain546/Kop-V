UPDATE trajets 
SET distance_km = 360.0,
    trace = ST_GeomFromText('LINESTRING(47.5162 -18.8792, 47.7833 -18.9167, 48.4667 -18.9333, 49.2167 -18.1500, 49.4000 -18.1500)', 4326)
WHERE id = 1;

UPDATE trajets 
SET distance_km = 530.0,
    trace = ST_GeomFromText('LINESTRING(49.4000 -18.1500, 49.2167 -18.1500, 48.4667 -18.9333, 47.5162 -18.8792, 47.3000 -19.3400, 47.0333 -19.8667)', 4326)
WHERE id = 2;

UPDATE trajets 
SET distance_km = 170.0,
    trace = ST_GeomFromText('LINESTRING(47.0333 -19.8667, 47.3000 -19.3400, 47.4500 -19.1000, 47.5162 -18.8792)', 4326)
WHERE id = 3;

UPDATE gares SET position = ST_SetSRID(ST_MakePoint(47.5162, -18.8792), 4326) WHERE id = 1;
UPDATE gares SET position = ST_SetSRID(ST_MakePoint(49.4000, -18.1500), 4326) WHERE id = 2;
UPDATE gares SET position = ST_SetSRID(ST_MakePoint(47.0333, -19.8667), 4326) WHERE id = 3;