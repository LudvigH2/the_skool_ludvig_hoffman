
-- Uppgift 4 - Bonusfragor
-- Fragorna fran uppgift 1 med den nya datamodellen


-- 1a. Antal ansokningar per utbildningsomrade
SELECT s.utbildningsomrade, COUNT(*) AS antal
FROM ansokan a
JOIN sun5_inriktning s ON a.sun5_kod = s.sun5_kod
GROUP BY s.utbildningsomrade
ORDER BY antal DESC;


-- 1b. Beviljade ansokningar per utbildningsomrade
SELECT s.utbildningsomrade, COUNT(*) AS antal
FROM ansokan a
JOIN sun5_inriktning s ON a.sun5_kod = s.sun5_kod
WHERE a.beslut = 'Beviljad'
GROUP BY s.utbildningsomrade
ORDER BY antal DESC;


-- 1c. Avslagna ansokningar per utbildningsomrade
SELECT s.utbildningsomrade, COUNT(*) AS antal
FROM ansokan a
JOIN sun5_inriktning s ON a.sun5_kod = s.sun5_kod
WHERE a.beslut = 'Avslag'
GROUP BY s.utbildningsomrade
ORDER BY antal DESC;


-- 1d. Beviljade utbildningar inom Data/IT
SELECT a.utbildningsnamn, COUNT(*) AS antal
FROM ansokan a
JOIN sun5_inriktning s ON a.sun5_kod = s.sun5_kod
WHERE a.beslut = 'Beviljad'
AND s.utbildningsomrade = 'Data/IT'
GROUP BY a.utbildningsnamn
ORDER BY antal DESC;


-- 1e. Avslagna utbildningar inom Data/IT
SELECT a.utbildningsnamn, COUNT(*) AS antal
FROM ansokan a
JOIN sun5_inriktning s ON a.sun5_kod = s.sun5_kod
WHERE a.beslut = 'Avslag'
AND s.utbildningsomrade = 'Data/IT'
GROUP BY a.utbildningsnamn
ORDER BY antal DESC;


-- 1f. Beviljade utbildningar per anordnare inom Data/IT
SELECT u.namn, a.utbildningsnamn, COUNT(*) AS antal
FROM ansokan a
JOIN utbildningsanordnare u ON a.anordnare_id = u.anordnare_id
JOIN sun5_inriktning s ON a.sun5_kod = s.sun5_kod
WHERE a.beslut = 'Beviljad'
AND s.utbildningsomrade = 'Data/IT'
GROUP BY u.namn, a.utbildningsnamn
ORDER BY antal DESC;


-- 1g. Topp 5 lan med flest beviljade ansokningar
SELECT l.lan_name, COUNT(*) AS antal
FROM ansokan a
JOIN ansokan_kommun ak ON a.diarienummer = ak.diarienummer
JOIN kommun k ON ak.kommun_id = k.kommun_id
JOIN lan l ON k.lan_id = l.lan_id
WHERE a.beslut = 'Beviljad'
AND l.lan_name <> 'Flera kommuner'
GROUP BY l.lan_name
ORDER BY antal DESC
FETCH FIRST 5 ROWS ONLY;


-- 1h. Andel distans och bundna utbildningar
SELECT
    s.utbildningsomrade,
    ROUND(SUM(CASE WHEN a.studieform = 'Distans' THEN 1 ELSE 0 END) * 100 / COUNT(*), 1) AS distans,
    ROUND(SUM(CASE WHEN a.studieform = 'Bunden' THEN 1 ELSE 0 END) * 100 / COUNT(*), 1) AS bunden
FROM ansokan a
JOIN sun5_inriktning s ON a.sun5_kod = s.sun5_kod
GROUP BY s.utbildningsomrade;


-- 1i. Antal utbildningar med AI i namnet
SELECT COUNT(*) AS antal
FROM ansokan
WHERE UPPER(utbildningsnamn) LIKE '% AI%'
OR UPPER(utbildningsnamn) LIKE 'AI%';
