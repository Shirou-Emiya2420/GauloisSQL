# Projet SQL : Base de Données des Gaulois

Bienvenue dans ce projet de base de données SQL modélisant un univers inspiré de la Gaule antique. Ce projet comprend la création des tables, l'insertion des données, ainsi qu'une série de requêtes permettant l'exploration des relations entre les entités.

---

## 📂 Contenu du projet

- `table.sql` : Création des tables de la base de données.
- `script_gaulois 2 1 1.sql` : Script d'insertion de données.
- `requet.sql` : Requêtes d'extraction et d'analyse des données.
- `model.loo` : Fichier de modélisation (probablement issu d'un outil de modélisation comme Looping).

---

## 🔧 Installation

1. **Prérequis** :
   - Serveur SQL (MySQL, PostgreSQL ou SQLite selon ton environnement)
   - Outil de gestion de base (DBeaver, phpMyAdmin, etc.)

2. **Initialisation** :
   - Exécute `table.sql` pour créer la structure de la base.
   - Lance `script_gaulois 2 1 1.sql` pour insérer les données.
   - Utilise `requet.sql` pour interroger et tester la base.

---

## 📄 Modélisation

La base repose sur plusieurs entités essentielles :

- **Village** : Rassemble les lieux où vivent les personnages.
- **Personnage** : Chaque Gaulois est identifié par son nom, son village et ses caractéristiques.
- **Potion** : Ingrédients et effets utilisés par les druides.
- **Druide** : Personnage spécialisé dans la création de potions.
- **Rôle** : Définit les fonctions des personnages (chef, druide, simple gaulois, etc.)

L'organisation suit un modèle relationnel clair avec clés étrangères et contraintes d'intégrité.

---

## 🧰 Exemple de requêtes

Voici quelques requêtes illustratives issues de `requet.sql` :

```sql
-- Liste des personnages d'un village donné
SELECT nom FROM personnage WHERE village_id = 1;

-- Nombre de potions par druide
SELECT druide.nom, COUNT(potion.id) FROM druide
JOIN potion ON potion.druide_id = druide.id
GROUP BY druide.nom;

-- Villages ayant plus de 3 personnages
SELECT village.nom FROM village
JOIN personnage ON personnage.village_id = village.id
GROUP BY village.nom
HAVING COUNT(personnage.id) > 3;
```

---

## 📖 Objectifs pédagogiques

Ce projet permet de pratiquer :
- La modélisation de données complexes
- L'utilisation de clés primaires/étrangères
- Les jointures (INNER JOIN, LEFT JOIN...)
- Les agrégats et GROUP BY
- Les contraintes d'intégrité référentielle

---

## 🎓 Pour aller plus loin

Tu peux étendre ce projet en ajoutant :
- Un système de quêtes entre personnages
- Des combats ou compétences
- Des interactions entre villages
- Une interface graphique ou une API REST

---

## 🚀 Auteur
Ce projet a été réalisé avec soin pour illustrer les concepts de base de données relationnelles à travers un thème ludique et historique.

---

## 🌟 Licence
Ce projet est libre d'utilisation à des fins pédagogiques.

