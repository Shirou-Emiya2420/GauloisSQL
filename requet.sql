/* 1 */
SELECT nom_lieu nl
FROM lieu l
WHERE nom_lieu LIKE "%um";

/* 2 */
SELECT COUNT(id_personnage) AS nb_pers, nom_lieu nl
FROM personnage p
INNER JOIN lieu l ON p.id_lieu = l.id_lieu
GROUP BY nl
ORDER BY nb_pers DESC;

/* 3 */
SELECT nom_personnage np, nom_specialite sn, adresse_personnage ap, nom_lieu nl
FROM personnage p
INNER JOIN specialite s ON p.id_specialite = s.id_specialite
INNER JOIN lieu l ON p.id_lieu = l.id_lieu
ORDER BY nl, np;

/* 4 */
SELECT COUNT(id_personnage) AS nb_pers, nom_specialite ns
FROM personnage p
LEFT JOIN specialite s ON p.id_specialite = s.id_specialite
GROUP BY ns
ORDER BY nb_pers DESC;

/* 5 */
SELECT nom_bataille bn, DATE_FORMAT(date_bataille, '%d/%m/%Y') bd, nom_lieu ln
FROM bataille b
INNER JOIN lieu l ON b.id_lieu = l.id_lieu
ORDER BY YEAR(b.date_bataille) ASC, MONTH(b.date_bataille) DESC, DAY(b.date_bataille) DESC;

/* 6 */
SELECT p.nom_potion, SUM(i.cout_ingredient * c.qte) AS cout_potion
FROM potion p
LEFT JOIN composer c ON c.id_potion = p.id_potion
LEFT JOIN ingredient i ON c.id_ingredient = i.id_ingredient
GROUP BY p.id_potion
ORDER BY cout_potion DESC;

/* 7 */
SELECT nom_ingredient ni, cout_ingredient ic, qte q
FROM potion p
INNER JOIN composer c ON p.id_potion = c.id_potion
INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE nom_potion = "Santé";

/* 8 */
SELECT p.nom_personnage, SUM(pc.qte) AS nb_casques
FROM personnage p, bataille b, prendre_casque pc
WHERE p.id_personnage = pc.id_personnage
AND pc.id_bataille = b.id_bataille
AND b.nom_bataille = 'Bataille du village gaulois'
GROUP BY p.id_personnage
HAVING nb_casques >= ALL (
    SELECT SUM(pc.qte)
    FROM prendre_casque pc, bataille b
    WHERE b.id_bataille = pc.id_bataille
    AND b.nom_bataille = 'Bataille du village gaulois'
    GROUP BY pc.id_personnage
);

/* 9 */
SELECT nom_personnage np, COUNT(b.id_personnage) AS p_bu 
FROM personnage p
INNER JOIN boire b ON b.id_personnage = p.id_personnage
GROUP BY np
ORDER BY p_bu ASC;

/* 10 */
SELECT b.nom_bataille, SUM(pc.qte) AS nb_casques
FROM bataille b, prendre_casque pc
WHERE b.id_bataille = pc.id_bataille
GROUP BY b.id_bataille
HAVING nb_casques >= ALL (
    SELECT SUM(pc.qte)
    FROM bataille b, prendre_casque pc
    WHERE b.id_bataille = pc.id_bataille
    GROUP BY b.id_bataille
)

/* 11 */
SELECT COUNT(c.id_casque) AS nb_casques, tc.nom_type_casque, SUM(c.cout_casque) AS total
FROM type_casque tc
LEFT JOIN casque c ON tc.id_type_casque = c.id_type_casque
GROUP BY tc.id_type_casque
ORDER BY nb_casques DESC

/* 12 */
SELECT nom_potion np
FROM potion p
INNER JOIN composer c ON c.id_potion = p.id_potion
INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom_ingredient = "Poisson frais";

/* 13 */
SELECT l.nom_lieu, COUNT(p.id_personnage) AS nb
FROM personnage p, lieu l
WHERE p.id_lieu = l.id_lieu
AND l.nom_lieu != 'Village gaulois'
GROUP BY l.id_lieu
HAVING nb >= ALL (
    SELECT COUNT(p.id_personnage)
    FROM personnage p, lieu l
    WHERE p.id_lieu = l.id_lieu
    AND l.nom_lieu != 'Village gaulois'
    GROUP BY l.id_lieu
);

/* 14 */
SELECT nom_personnage pn
FROM personnage p
LEFT JOIN boire b ON b.id_personnage = p.id_personnage
WHERE b.id_potion IS NULL;

/* 15 */
SELECT p.nom_personnage AS pn
FROM personnage p
WHERE p.id_personnage NOT IN (
  SELECT ab.id_personnage
  FROM autoriser_boire ab
  INNER JOIN potion po ON ab.id_potion = po.id_potion
  WHERE po.nom_potion = 'Magique'
);

/* A. */
INSERT INTO personnage (nom_personnage, adresse_personnage, id_lieu, id_specialite)
VALUES (
    'Champdeblix',
    'Ferme Hantassion',
    (SELECT id_lieu FROM lieu WHERE nom_lieu = 'Rotomagus'),
    (SELECT id_specialite FROM specialite WHERE nom_specialite = 'Agriculteur')
);

SELECT * FROM personnage WHERE nom_personnage = "Champdeblix";

/* B */
INSERT INTO autoriser_boire (id_potion, id_personnage)
VALUES (
    (SELECT id_potion FROM potion WHERE nom_potion = 'Magique'),
    (SELECT id_personnage FROM personnage WHERE nom_personnage = 'Bonemine')
);

SELECT * FROM autoriser_boire WHERE id_personnage = 12;

/* C */
DELETE FROM casque
WHERE id_type_casque = (
    SELECT id_type_casque FROM type_casque WHERE nom_type_casque = 'Grec'
)
AND id_casque NOT IN (
    SELECT id_casque FROM prendre_casque
);

SELECT *
FROM casque
WHERE id_type_casque = (
  SELECT id_type_casque FROM type_casque WHERE nom_type_casque = 'Grec'
)
AND id_casque NOT IN (
  SELECT DISTINCT id_casque FROM prendre_casque
);


/* D */
UPDATE personnage
SET adresse_personnage = 'Prison',
    id_lieu = (SELECT id_lieu FROM lieu WHERE nom_lieu = 'Condate')
WHERE nom_personnage = 'Zérozérosix';

/* E */
DELETE FROM composer
WHERE id_potion = (
  SELECT id_potion FROM potion WHERE nom_potion = 'Soupe'
)
AND id_ingredient = (
  SELECT id_ingredient FROM ingredient WHERE nom_ingredient = 'Persil'
);

/* F */
UPDATE prendre_casque
SET id_casque = (
  SELECT id_casque FROM casque WHERE nom_casque = 'Weisenau'
)
WHERE id_casque = (
  SELECT id_casque FROM casque WHERE nom_casque = 'Ostrogoth'
)
AND id_personnage = (
  SELECT id_personnage FROM personnage WHERE nom_personnage = 'Obélix'
)
AND id_bataille = (
  SELECT id_bataille FROM bataille WHERE nom_bataille = 'Attaque de la banque postale'
);