-- Fraga1: Vilka 5 utbildningsanordnare har flest beviljade ansokningar?
-- Detta visar vilka anordnare som har fatt flest godkanda ansokningar.
-- The Skool kan anvanda resultatet for att undersoka konkurrenterna.

SELECT utbildningsanordnare, COUNT(*) AS antal
FROM myh_2025
WHERE beslut = 'Beviljad'
GROUP BY utbildningsanordnare
ORDER BY antal DESC
FETCH FIRST 5 ROWS ONLY;



-- Fraga2: Vilka utbildningsomraden har flest avslag for distansutbildningar?
-- Detta hjalper The Skool att se var distansutbildningar oftare far avslag.

SELECT utbildningsomrade, COUNT(*) AS antal
FROM myh_2025
WHERE beslut = 'Avslag'
AND studieform = 'Distans'
GROUP BY utbildningsomrade
ORDER BY antal DESC;



-- Fraga3: Vilka 5 kommuner har flest beviljade ansokningar inom Data/IT?
-- Detta hjalper The Skool att se var det finns flest godkanda utbildningar inom Data/IT.

SELECT kommun, COUNT(*) AS antal
FROM myh_2025
WHERE beslut = 'Beviljad'
AND utbildningsomrade = 'Data/IT'
GROUP BY kommun
ORDER BY antal DESC
FETCH FIRST 5 ROWS ONLY;
