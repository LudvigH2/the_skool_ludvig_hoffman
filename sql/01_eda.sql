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
