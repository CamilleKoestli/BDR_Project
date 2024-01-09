-- UTILISATEURS
-- Insérer le premier utilisateur
INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail) VALUES ('john_doe', 'motdepasse1', 'john.doe@example.com');
INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail) VALUES ('jane_smith', 'motdepasse2', 'jane.smith@example.com');
INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail) VALUES ('alfred10', '1234', 'alfred10@example.com');
INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail) VALUES ('tony24', '5678', 'tony24@example.com');
-- END

-- Dossier
INSERT INTO "Dossier" (id_dossier, nom, pseudo) VALUES (1, 'chien','john_doe');
INSERT INTO "Dossier" (id_dossier, nom, pseudo) VALUES (2,'cheval', 'jane_smith');
INSERT INTO "Dossier" (id_dossier, nom, pseudo) VALUES (3, 'animaux','john_doe');
INSERT INTO "Dossier" (id_dossier, nom, pseudo) VALUES (4, 'animaux','jane_smith');

-- END

-- Badge
INSERT INTO "Badge" (id_badge, nom, description) VALUES (1, '100reaction','Vous avez réagi a 100 photos');
INSERT INTO "Badge" (id_badge, nom, description) VALUES (2, '100photos','Vous avez publié 100 photos');
-- END

-- BadgeUtilisateur
INSERT INTO "BadgeUtilisateur" (id_badge, pseudo) VALUES (1, 'john_doe');
INSERT INTO "BadgeUtilisateur" (id_badge, pseudo) VALUES (2, 'jane_smith');
-- END

-- Photo
INSERT INTO "Photo" (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (1, 'chien', '12.01.2023', 'chien', 'DSC_0001.jpg', true, 'john_doe');
INSERT INTO "Photo" (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (2, 'chat', '12.01.2023', 'chat', 'DSC_0002.jpg', false, 'john_doe');
INSERT INTO "Photo" (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (3, 'cheval', '04.17.2023', 'cheval', 'DSC_0001.jpg', true, 'jane_smith');
INSERT INTO "Photo" (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (4, 'chien', '04.17.2023', 'chien', 'DSC_0002.jpg', false, 'jane_smith');
INSERT INTO "Photo" (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (5, 'chien et chat', '12.01.2023', 'chien et chat', 'DSC_0003.jpg', false, 'john_doe');

-- END

-- Tag
INSERT INTO "Tag" (mot, pseudo) VALUES ('chien', 'john_doe');
INSERT INTO "Tag" (mot, pseudo) VALUES ('chat', 'john_doe');
INSERT INTO "Tag" (mot, pseudo) VALUES ('cheval', 'jane_smith');
-- END

-- Statut
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('tony24', 'john_doe', true, true);
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('tony24', 'jane_smith', false, true);
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('tony24', 'john_doe', false, false);
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('tony24', 'jane_smith', true, false);
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('alfred10', 'john_doe', false, true);
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('alfred10', 'jane_smith', true, true);
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('alfred10', 'john_doe', true, false);
INSERT INTO "Statut" (pseudo, "pseudoArt", typedemande, accepte_refus) VALUES ('alfred10', 'jane_smith', false, false);
-- END

-- TagUtilisateur
INSERT INTO "TagUtilisateur" (mot, pseudo) VALUES ('chien', 'tony24');
INSERT INTO "TagUtilisateur" (mot, pseudo) VALUES ('chien', 'alfred10');
INSERT INTO "TagUtilisateur" (mot, pseudo) VALUES ('chat', 'alfred10');
INSERT INTO "TagUtilisateur" (mot, pseudo) VALUES ('cheval', 'tony24');
-- END

-- TagPhoto
INSERT INTO "TagPhoto" (mot, id_photo) VALUES ('chien', 1);
INSERT INTO "TagPhoto" (mot, id_photo) VALUES ('chien', 4);
INSERT INTO "TagPhoto" (mot, id_photo) VALUES ('chat', 2);
INSERT INTO "TagPhoto" (mot, id_photo) VALUES ('cheval', 3);
INSERT INTO "TagPhoto" (mot, id_photo) VALUES ('chien', 5);
INSERT INTO "TagPhoto" (mot, id_photo) VALUES ('chat', 5);
-- END


-- Reaction
INSERT INTO "Reaction" (plus_moins, id_photo, pseudo ) VALUES (true, 1, 'tony24');
INSERT INTO "Reaction" (plus_moins, id_photo, pseudo ) VALUES (false, 3, 'tony24');
INSERT INTO "Reaction" (plus_moins, id_photo, pseudo ) VALUES (true, 4, 'tony24');
INSERT INTO "Reaction" (plus_moins, id_photo, pseudo ) VALUES (true, 3, 'alfred10');
INSERT INTO "Reaction" (plus_moins, id_photo, pseudo ) VALUES (false, 2, 'alfred10');
INSERT INTO "Reaction" (plus_moins, id_photo, pseudo ) VALUES (true, 5, 'alfred10');
-- END

-- Commentaire
INSERT INTO "Commentaire" (texte, pseudo, id_photo, id_comm) VALUES ('joli chien', 'tony24', 1, 1);
INSERT INTO "Commentaire" (texte, pseudo, id_photo, id_comm) VALUES ('pas beau', 'tony24', 3, 2);
INSERT INTO "Commentaire" (texte, pseudo, id_photo, id_comm) VALUES ('joli chien', 'tony24', 4, 3);
INSERT INTO "Commentaire" (texte, pseudo, id_photo, id_comm) VALUES ('joli cheval', 'alfred10', 3, 4);
INSERT INTO "Commentaire" (texte, pseudo, id_photo, id_comm) VALUES ('pas joli', 'alfred10', 2, 5);
INSERT INTO "Commentaire" (texte, pseudo, id_photo, id_comm) VALUES ('joli chien', 'alfred10', 5, 6);
-- END

-- Dossier Photo
INSERT INTO "DossierPhoto" (id_dossier, id_photo) VALUES (1, 1);
INSERT INTO "DossierPhoto" (id_dossier, id_photo) VALUES (3, 2);
INSERT INTO "DossierPhoto" (id_dossier, id_photo) VALUES (2, 3);
INSERT INTO "DossierPhoto" (id_dossier, id_photo) VALUES (4, 4);
INSERT INTO "DossierPhoto" (id_dossier, id_photo) VALUES (3, 5);
-- END