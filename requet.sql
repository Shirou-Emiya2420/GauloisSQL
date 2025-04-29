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
INNER JOIN specialite s ON p.id_specialite = s.id_specialite
GROUP BY ns
ORDER BY nb_pers DESC;

/* 5 */
SELECT nom_bataille bn, DATE_FORMAT(date_bataille, '%d/%m/%Y') bd, nom_lieu ln
FROM bataille b
INNER JOIN lieu l ON b.id_lieu = l.id_lieu
ORDER BY date_bataille DESC;

/* 6 */
SELECT nom_potion pn, SUM(cout_ingredient * qte) AS cout_tt
FROM potion p
INNER JOIN composer c ON p.id_potion = c.id_potion
INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
GROUP BY nom_potion
ORDER BY cout_tt DESC;
/* Resultat plus cohérant sans qte dans le doute je met les deux */

/* 7 */
SELECT nom_ingredient ni, cout_ingredient ic, qte q
FROM potion p
INNER JOIN composer c ON p.id_potion = c.id_potion
INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE nom_potion = "Santé";

/* 8 */
SELECT per.nom_personnage, SUM(pc.qte) AS total_casques
FROM prendre_casque pc
INNER JOIN personnage per ON pc.id_personnage = per.id_personnage
INNER JOIN bataille b ON pc.id_bataille = b.id_bataille
WHERE b.nom_bataille = 'Bataille du village gaulois'
GROUP BY per.id_personnage, per.nom_personnage
HAVING total_casques = (
  SELECT MAX(sous.total)
  FROM (
    SELECT SUM(pc2.qte) AS total
    FROM prendre_casque pc2
    INNER JOIN bataille b2 ON pc2.id_bataille = b2.id_bataille
    WHERE b2.nom_bataille = 'Bataille du village gaulois'
    GROUP BY pc2.id_personnage
  ) sous
);

/* 9 */
SELECT nom_personnage np, COUNT(b.id_personnage) AS p_bu 
FROM personnage p
INNER JOIN boire b ON b.id_personnage = p.id_personnage
GROUP BY np
ORDER BY p_bu ASC;

/* 10 */
SELECT b.nom_bataille AS bn, SUM(pc.qte) AS total_qte
FROM bataille b
INNER JOIN prendre_casque pc ON b.id_bataille = pc.id_bataille
GROUP BY b.nom_bataille
HAVING total_qte = (
    SELECT MAX(sous.total)
    FROM(
        SELECT SUM(pc2.qte) AS total
        FROM prendre_casque pc2
        INNER JOIN bataille b2 ON pc2.id_bataille = b2.id_bataille
        GROUP BY b2.nom_bataille
    )sous
)

/* 11 */
SELECT nom_type_casque ctn, COUNT(id_casque) AS total_cas, SUM(cout_casque) AS total_prix
FROM casque c 
INNER JOIN type_casque ct ON c.id_type_casque = ct.id_type_casque
GROUP BY nom_type_casque
ORDER BY total_prix ASC;