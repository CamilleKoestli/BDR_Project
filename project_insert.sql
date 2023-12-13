-- UTILISATEURS
-- Insérer le premier utilisateur
INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail) VALUES ('john_doe', 'motdepasse1', 'john.doe@example.com');
INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail) VALUES ('jane_smith', 'motdepasse2', 'jane.smith@example.com');
-- END

-- Artistes
-- Insérer le premier artiste
INSERT INTO "Artiste" (pseudo, description) VALUES ('john_doe', 'john_doe');
INSERT INTO "Artiste" (pseudo, description) VALUES ('jane_smith', 'Je suis amateur de photo');
-- END

-- Dossier
INSERT INTO "Dossier" (id_dossier, nom, pseudo) VALUES (1, 'chien','john_doe');
INSERT INTO "Dossier" (id_dossier, nom, pseudo) VALUES (2,'chat', 'jane_smith');
-- END



