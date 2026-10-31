-- Uppgift 4 - Datamodell
-- Tabell for lan

CREATE TABLE lan (
    lan_id NUMBER PRIMARY KEY,
    lan_name VARCHAR2(100)
);

-- Lagg in lan fran originaltabellen
INSERT INTO lan (lan_id, lan_name)
SELECT ROWNUM, lan
FROM (
    SELECT DISTINCT lan
    FROM myh_2025
);

-- Tabell for kommuner
CREATE TABLE kommun (
    kommun_id NUMBER PRIMARY KEY,
    kommun_name VARCHAR2(100),
    lan_id NUMBER,
    FOREIGN KEY (lan_id) REFERENCES lan(lan_id)
);

-- Lagg in kommuner och koppla dem till lan
INSERT INTO kommun (kommun_id, kommun_name, lan_id)
SELECT ROWNUM, kommun, lan_id
FROM (
    SELECT DISTINCT m.kommun, l.lan_id
    FROM myh_2025 m
    JOIN lan l ON m.lan = l.lan_name
);


-- Tabell for utbildningsanordnare
CREATE TABLE utbildningsanordnare (
    anordnare_id NUMBER PRIMARY KEY,
    namn VARCHAR2(300),
    huvudmannatyp VARCHAR2(100)
);

-- Lagg in utbildningsanordnare fran originaltabellen
INSERT INTO utbildningsanordnare (anordnare_id, namn, huvudmannatyp)
SELECT ROWNUM, utbildningsanordnare, huvudmannatyp
FROM (
    SELECT DISTINCT utbildningsanordnare, huvudmannatyp
    FROM myh_2025
);


-- Tabel for SEQF och examenstyp
CREATE TABLE seqf (
    seqf_kod VARCHAR2(50) PRIMARY KEY,
    examenstyp VARCHAR2(100)
);

-- Lagg in SEQF niva fran originaltabelen
INSERT INTO seqf (seqf_kod, examenstyp)
SELECT DISTINCT seqf_niva, examenstyp
FROM myh_2025
WHERE seqf_niva IS NOT NULL;


-- Tabell for SUN5 inriktningar
CREATE TABLE sun5_inriktning (
    sun5_kod VARCHAR2(100) PRIMARY KEY,
    sun5_namn VARCHAR2(200),
utbildningsomrade VARCHAR2(200)
);

-- Lagg in SUN5 inriktning fran originaltabell
INSERT INTO sun5_inriktning (sun5_kod, sun5_namn, utbildningsomrade)
SELECT DISTINCT
    sun5_inriktning,
    sun5_inriktning_namn,
    utbildningsomrade
FROM myh_2025;


-- Tabell for ansokningar
CREATE TABLE ansokan (
    diarienummer VARCHAR2(100) PRIMARY KEY,
    sun5_kod VARCHAR2(100),
    seqf_kod VARCHAR2(50),
    anordnare_id NUMBER,
    utbildningsnamn VARCHAR2(300),
    beslut VARCHAR2(50),
    yh_poang VARCHAR2(50),
    studieform VARCHAR2(50),
    studietakt_procent VARCHAR2(50),
    smalt_yrkesomrade VARCHAR2(200),
    sokta_utbildningsomgangar VARCHAR2(50),
    beviljade_utbildningsomgangar VARCHAR2(50),
    sokta_platser_totalt VARCHAR2(50),
    beviljade_platser_totalt VARCHAR2(50),
    FOREIGN KEY (sun5_kod) REFERENCES sun5_inriktning(sun5_kod),
    FOREIGN KEY (seqf_kod) REFERENCES seqf(seqf_kod),
    FOREIGN KEY (anordnare_id) REFERENCES utbildningsanordnare(anordnare_id)
);

-- Lagg in ansokningar fran originaltabellen
INSERT INTO ansokan (
    diarienummer, sun5_kod, seqf_kod, anordnare_id,
    utbildningsnamn, beslut, yh_poang, studieform,
    studietakt_procent, smalt_yrkesomrade,
    sokta_utbildningsomgangar, beviljade_utbildningsomgangar,
    sokta_platser_totalt, beviljade_platser_totalt
)
SELECT
    m.diarienummer, m.sun5_inriktning, s.seqf_kod, u.anordnare_id,
    m.utbildningsnamn, m.beslut, m.yh_poang, m.studieform,
    m.studietakt_procent, m.smalt_yrkesomrade,
    m.sokta_utbildningsomgangar, m.beviljade_utbildningsomgangar,
    m.sokta_platser_totalt, m.beviljade_platser_totalt
FROM myh_2025 m
JOIN utbildningsanordnare u
ON m.utbildningsanordnare = u.namn
LEFT JOIN seqf s
ON m.seqf_niva = s.seqf_kod;


-- Tabell for koppling mellan ansokningar och kommuner
CREATE TABLE ansokan_kommun (
    diarienummer VARCHAR2(100),
    kommun_id NUMBER,
    PRIMARY KEY (diarienummer, kommun_id),
    FOREIGN KEY (diarienummer) REFERENCES ansokan(diarienummer),
    FOREIGN KEY (kommun_id) REFERENCES kommun(kommun_id)
);

-- Koppla ansokning till ratt kommun
INSERT INTO ansokan_kommun (diarienummer, kommun_id)
SELECT m.diarienummer, k.kommun_id
FROM myh_2025 m
JOIN kommun k ON m.kommun = k.kommun_name
JOIN lan l ON k.lan_id = l.lan_id
AND m.lan = l.lan_name;

COMMIT;
