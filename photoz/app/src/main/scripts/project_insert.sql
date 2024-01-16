set search_path=project_schema;

-- UTILISATEURS
-- Insérer le premier utilisateur
INSERT INTO utilisateur (pseudo, motdepasse, email) VALUES ('john_doe', '123', 'john.doe@example.com');
INSERT INTO utilisateur (pseudo, motdepasse, email) VALUES ('jane_smith', '321', 'jane.smith@example.com');
INSERT INTO utilisateur (pseudo, motdepasse, email) VALUES ('alfred10', '1234', 'alfred10@example.com');
INSERT INTO utilisateur (pseudo, motdepasse, email) VALUES ('tony24', '5678', 'tony24@example.com');
-- END

-- dossier
INSERT INTO dossier (id_dossier, nom, pseudo) VALUES (1, 'chien','john_doe');
INSERT INTO dossier (id_dossier, nom, pseudo) VALUES (2,'cheval', 'jane_smith');
INSERT INTO dossier (id_dossier, nom, pseudo) VALUES (3, 'animaux','john_doe');
INSERT INTO dossier (id_dossier, nom, pseudo) VALUES (4, 'animaux','jane_smith');

-- END

-- badge
INSERT INTO badge (id_badge, nom, description) VALUES (1, '100reaction','Vous avez réagi a 100 photos');
INSERT INTO badge (id_badge, nom, description) VALUES (2, '100photos','Vous avez publié 100 photos');
-- END

-- badgeutilisateur
INSERT INTO badgeutilisateur (id_badge, pseudo) VALUES (1, 'john_doe');
INSERT INTO badgeutilisateur (id_badge, pseudo) VALUES (2, 'jane_smith');
-- END

-- photo
INSERT INTO photo (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (1, 'chien', '12.01.2023', 'chien', 'DSC_0001.jpg', true, 'john_doe');
INSERT INTO photo (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (2, 'chat', '12.01.2023', 'chat', 'DSC_0002.jpg', false, 'john_doe');
INSERT INTO photo (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (3, 'cheval', '1.04.2023', 'cheval', 'DSC_0003.jpg', true, 'jane_smith');
INSERT INTO photo (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (4, 'chien', '1.04.2023', 'chien', 'DSC_0004.jpg', false, 'jane_smith');
INSERT INTO photo (id_photo, titre, datepubliee, legende, chemin, visible, pseudo) VALUES (5, 'chien et chat', '12.01.2023', 'chien et chat', 'DSC_0005.jpg', false, 'john_doe');

-- END

-- tag
INSERT INTO tag (mot, pseudo) VALUES ('chien', 'john_doe');
INSERT INTO tag (mot, pseudo) VALUES ('chat', 'john_doe');
INSERT INTO tag (mot, pseudo) VALUES ('cheval', 'jane_smith');
-- END

-- statut
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('tony24', 'john_doe', true, true);
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('tony24', 'jane_smith', false, true);
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('tony24', 'john_doe', false, false);
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('tony24', 'jane_smith', true, false);
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('alfred10', 'john_doe', false, true);
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('alfred10', 'jane_smith', true, true);
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('alfred10', 'john_doe', true, false);
INSERT INTO statut (pseudo, pseudoart, typedemande, accepte_refus) VALUES ('alfred10', 'jane_smith', false, false);
-- END

-- tagutilisateur
INSERT INTO tagutilisateur (mot, pseudo) VALUES ('chien', 'tony24');
INSERT INTO tagutilisateur (mot, pseudo) VALUES ('chien', 'alfred10');
INSERT INTO tagutilisateur (mot, pseudo) VALUES ('chat', 'alfred10');
INSERT INTO tagutilisateur (mot, pseudo) VALUES ('cheval', 'tony24');
-- END

-- tagphoto
INSERT INTO tagphoto (mot, id_photo) VALUES ('chien', 1);
INSERT INTO tagphoto (mot, id_photo) VALUES ('chien', 4);
INSERT INTO tagphoto (mot, id_photo) VALUES ('chat', 2);
INSERT INTO tagphoto (mot, id_photo) VALUES ('cheval', 3);
INSERT INTO tagphoto (mot, id_photo) VALUES ('chien', 5);
INSERT INTO tagphoto (mot, id_photo) VALUES ('chat', 5);
-- END


-- reaction
INSERT INTO reaction (plus_moins, id_photo, pseudo ) VALUES (true, 1, 'tony24');
INSERT INTO reaction (plus_moins, id_photo, pseudo ) VALUES (false, 3, 'tony24');
INSERT INTO reaction (plus_moins, id_photo, pseudo ) VALUES (true, 4, 'tony24');
INSERT INTO reaction (plus_moins, id_photo, pseudo ) VALUES (true, 3, 'alfred10');
INSERT INTO reaction (plus_moins, id_photo, pseudo ) VALUES (false, 2, 'alfred10');
INSERT INTO reaction (plus_moins, id_photo, pseudo ) VALUES (true, 5, 'alfred10');
-- END

-- commentaire
INSERT INTO commentaire (texte, pseudo, id_photo, id_comm) VALUES ('joli chien', 'tony24', 1, 1);
INSERT INTO commentaire (texte, pseudo, id_photo, id_comm) VALUES ('pas beau', 'tony24', 3, 2);
INSERT INTO commentaire (texte, pseudo, id_photo, id_comm) VALUES ('joli chien', 'tony24', 4, 3);
INSERT INTO commentaire (texte, pseudo, id_photo, id_comm) VALUES ('joli cheval', 'alfred10', 3, 4);
INSERT INTO commentaire (texte, pseudo, id_photo, id_comm) VALUES ('pas joli', 'alfred10', 2, 5);
INSERT INTO commentaire (texte, pseudo, id_photo, id_comm) VALUES ('joli chien', 'alfred10', 5, 6);
-- END

-- dossier photo
INSERT INTO dossierphoto (id_dossier, id_photo) VALUES (1, 1);
INSERT INTO dossierphoto (id_dossier, id_photo) VALUES (3, 2);
INSERT INTO dossierphoto (id_dossier, id_photo) VALUES (2, 3);
INSERT INTO dossierphoto (id_dossier, id_photo) VALUES (4, 4);
INSERT INTO dossierphoto (id_dossier, id_photo) VALUES (3, 5);
-- END