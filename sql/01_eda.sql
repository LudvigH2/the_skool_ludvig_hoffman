-- Sorterat flest ansokningar

SELECT
    utbildningsomrade,
    COUNT(*) AS antal_ansokningar
FROM myh_2025
GROUP BY utbildningsomrade
ORDER BY antal_ansokningar DESC;



-- Antal beviljade ansoknningar per utbildningssomrade

SELECT
    utbildningsomrade,
    COUNT(*) AS antal_beviljade
FROM myh_2025
WHERE beslut = 'Beviljad'
GROUP BY utbildningsomrade
ORDER BY antal_beviljade DESC;



-- Antal avslagna ansoknningar per utbildningsomrade

SELECT
    utbildningsomrade,
    COUNT(*) AS antal_avslag
FROM myh_2025
WHERE beslut = 'Avslag'
GROUP BY utbildningsomrade
ORDER BY antal_avslag DESC;


-- Antal beviljade ansokningar per utbildningsnamn inom Data/IT

SELECT
    utbildningsnamn,
    COUNT(*) AS antal_beviljade
FROM myh_2025
WHERE beslut = 'Beviljad'
    AND utbildningsomrade = 'Data/IT'
GROUP BY utbildningsnamn
ORDER BY antal_beviljade DESC;

-- Antal avslagna ansokningar per utbildningsnamn inom Data/IT

SELECT
    utbildningsnamn,
    COUNT(*) AS antal_avslag
FROM myh_2025
WHERE beslut = 'Avslag'
    AND utbildningsomrade = 'Data/IT'
GROUP BY utbildningsnamn
ORDER BY antal_avslag DESC;


-- Beviljade ansokningar per utbildningsanordnare och utbildningsnamn inom Data/IT

SELECT
    utbildningsanordnare,
    utbildningsnamn,
    COUNT(*) AS antal_beviljade
FROM myh_2025
WHERE beslut = 'Beviljad'
    AND utbildningsomrade = 'Data/IT'
GROUP BY utbildningsanordnare, utbildningsnamn
ORDER BY antal_beviljade DESC;



-- Topp 5 lan med flest beviljade ansokningar
SELECT
    lan,
    COUNT(*) AS antal_beviljade
FROM myh_2025
WHERE beslut = 'Beviljad'
    AND lan <> 'Flera kommuner'
GROUP BY lan
ORDER BY antal_beviljade DESC
FETCH FIRST 5 ROWS ONLY;



-- Antal utbildningar per utbildningsomrade och studieform
SELECT
    utbildningsomrade,
    studieform,
    COUNT(*) AS antal
FROM myh_2025
GROUP BY utbildningsomrade, studieform
ORDER BY utbildningsomrade;



-- Antal ansokningar med AI i utbildningsnanet

SELECT COUNT(*) AS antal_ai_utbildningar
FROM myh_2025
WHERE UPPER(utbildningsnamn) LIKE '% AI%'
   OR UPPER(utbildningsnamn) LIKE 'AI%';
