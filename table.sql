CREATE TABLE autoriser_boire (
  id_potion INT(11) NOT NULL,
  id_personnage INT(11) NOT NULL,
  PRIMARY KEY (id_potion, id_personnage),
  FOREIGN KEY (id_personnage) REFERENCES personnage(id_personnage),
  FOREIGN KEY (id_potion) REFERENCES potion(id_potion)
);

CREATE TABLE bataille (
  id_bataille INT(11) NOT NULL AUTO_INCREMENT,
  nom_bataille VARCHAR(50) COLLATE utf8_bin NOT NULL,
  date_bataille DATE NOT NULL,
  id_lieu INT(11) NOT NULL,
  PRIMARY KEY (id_bataille),
  FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu)
);

CREATE TABLE boire (
  id_potion INT(11) NOT NULL,
  id_personnage INT(11) NOT NULL,
  date_boire DATE NOT NULL,
  dose_boire INT(5) NOT NULL,
  PRIMARY KEY (id_potion, id_personnage),
  FOREIGN KEY (id_personnage) REFERENCES personnage(id_personnage),
  FOREIGN KEY (id_potion) REFERENCES potion(id_potion)
);

CREATE TABLE casque (
  id_casque INT(11) NOT NULL AUTO_INCREMENT,
  nom_casque VARCHAR(50) COLLATE utf8_bin NOT NULL,
  cout_casque FLOAT NOT NULL,
  id_type_casque INT(11) NOT NULL,
  PRIMARY KEY (id_casque),
  FOREIGN KEY (id_type_casque) REFERENCES type_casque(id_type_casque)
);

CREATE TABLE composer (
  id_potion INT(11) NOT NULL,
  id_ingredient INT(11) NOT NULL,
  qte INT(5) NOT NULL,
  PRIMARY KEY (id_potion, id_ingredient),
  FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient),
  FOREIGN KEY (id_potion) REFERENCES potion(id_potion)
);

CREATE TABLE ingredient (
  id_ingredient INT(11) NOT NULL AUTO_INCREMENT,
  nom_ingredient VARCHAR(50) COLLATE utf8_bin NOT NULL,
  cout_ingredient FLOAT NOT NULL,
  PRIMARY KEY (id_ingredient)
);

CREATE TABLE lieu (
  id_lieu INT(11) NOT NULL AUTO_INCREMENT,
  nom_lieu VARCHAR(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (id_lieu)
);

CREATE TABLE personnage (
  id_personnage INT(11) NOT NULL AUTO_INCREMENT,
  nom_personnage VARCHAR(80) COLLATE utf8_bin NOT NULL,
  adresse_personnage VARCHAR(255) COLLATE utf8_bin DEFAULT NULL,
  image_personnage VARCHAR(50) COLLATE utf8_bin NOT NULL DEFAULT 'indisponible.jpg',
  id_lieu INT(11) NOT NULL,
  id_specialite INT(11) NOT NULL,
  PRIMARY KEY (id_personnage),
  FOREIGN KEY (id_lieu) REFERENCES lieu(id_lieu),
  FOREIGN KEY (id_specialite) REFERENCES specialite(id_specialite)
);

CREATE TABLE potion (
  id_potion INT(11) NOT NULL AUTO_INCREMENT,
  nom_potion VARCHAR(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (id_potion)
);

CREATE TABLE prendre_casque (
  id_casque INT(11) NOT NULL,
  id_personnage INT(11) NOT NULL,
  id_bataille INT(11) NOT NULL,
  qte INT(5) NOT NULL,
  PRIMARY KEY (id_casque, id_personnage, id_bataille),
  FOREIGN KEY (id_bataille) REFERENCES bataille(id_bataille),
  FOREIGN KEY (id_casque) REFERENCES casque(id_casque),
  FOREIGN KEY (id_personnage) REFERENCES personnage(id_personnage)
);

CREATE TABLE specialite (
  id_specialite INT(11) NOT NULL AUTO_INCREMENT,
  nom_specialite VARCHAR(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (id_specialite)
);

CREATE TABLE type_casque (
  id_type_casque INT(11) NOT NULL AUTO_INCREMENT,
  nom_type_casque VARCHAR(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (id_type_casque)
);