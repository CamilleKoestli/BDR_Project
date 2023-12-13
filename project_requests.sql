SET search_path=projet_schema;

--
-- Requests
--

--
-- Utilisateur
--

-- Consulter tous les utilisateurs
SELECT *
FROM "Utilisateur";
--

-- Consulter, créer et modifier un utilisateur
-- Consulter un utilisateur
SELECT *
FROM "Utilisateur"
WHERE pseudo = :pseudo;

-- Créer un nouvel utilisateur
INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail)
VALUES (:pseudo, :motdepasse, :adressemail);

-- Mise à jour d'un utilisateur
UPDATE "Utilisateur"
SET motdepasse  = :motdepasse,
    adressemail = :adressemail
WHERE pseudo = :pseudo;

-- Supprimer un utilisateur
DELETE
FROM "Utilisateur"
WHERE pseudo = :pseudo;
--

-- Suivre ou ne plus suivre à un artiste
-- Suivre un artiste
INSERT INTO "Statut" (typedemande, accepte_refus, pseudo, "pseudoArt")
VALUES (TRUE, TRUE, :pseudo, :pseudo);

-- Ne plus suivre un artiste
UPDATE "Statut"
SET accepte_refus = FALSE
WHERE pseudo = :pseudo
  AND "pseudoArt" = :pseudo;
--

-- S'abonner ou se désabonner à un artiste
-- S'abonner à un artiste
INSERT INTO "Statut" (typedemande, accepte_refus, pseudo, "pseudoArt")
VALUES (FALSE, NULL, :pseudo, :pseudo);

-- Se désabonner un artiste
UPDATE "Statut"
SET accepte_refus = FALSE
WHERE pseudo = :pseudo
  AND "pseudoArt" = :pseudo;
--

-- Créer, modifier et supprimer un dossier
-- Créer dossier
INSERT INTO "Dossier" (nom, pseudo)
VALUES (:nom, :pseudo);

-- Mise à jour dossier
UPDATE "Dossier"
SET nom = :nom
WHERE pseudo = :pseudo
  AND id_dossier = true;

-- Supprimer dossier
DELETE
FROM "Dossier"
WHERE pseudo = :pseudo
  AND id_dossier = :nom;
--

-- Mettre ou enlever une photo d’un dossier
-- Mettre une photo dans un dossier
INSERT INTO "DossierPhoto" (id_dossier, id_photo)
VALUES (:dossier,:photo);

-- Enlever une photo dans un dossier
DELETE
FROM "DossierPhoto"
WHERE id_dossier = :dossier
  AND id_photo = :photo;
--

-- Ajouter ou modifier un commentaire
-- Ajouter un commentaire
INSERT INTO "Commentaire" (texte, pseudo, id_photo)
VALUES (:text, :pseudo, :photo);

-- Modifier un commentaire
UPDATE "Commentaire"
SET texte = :texte
WHERE id_comm = :id_comm;
--

-- Ajouter ou modifier une réaction
-- Ajouter une réaction
INSERT INTO "Reaction" (plus_moins, id_photo, pseudo)
VALUES (:plus_moins, :photo, :pseudo);

-- Modifier une réaction
UPDATE "Reaction"
SET plus_moins = :plus_moins
WHERE id_photo = :id_photo
  AND pseudo = :pseudo;
--


--
-- Artiste
--

-- Consulter tous les artistes
SELECT *
FROM "Artiste";
--

-- Consulter les photos publiques et privées d’un artiste
SELECT *
FROM "Photo"
         INNER JOIN "PhotoPublic" PP ON "Photo".id_photo = PP.id_photo
         INNER JOIN "PhotoPrive" PPr ON "Photo".id_photo = PPr.id_photo
WHERE "Photo".pseudo = :pseudo ;
--

-- Accepter ou refuser une demande d’abonnement
UPDATE "Statut"
SET accepte_refus = :reponse
WHERE typedemande = FALSE
  AND pseudo = :pseudo
  AND "pseudoArt" = :pseudo;

-- Ajouter ou supprimer une photo
-- Ajouter une photo
INSERT INTO "Photo"(titre, datepubliee, legende, extension, pseudo)
VALUES (:titre, :datepubliee, :legende, :extension, :pseudo);

-- Supprimer une photo
DELETE
FROM "Photo"
WHERE id_photo = :photo
  AND pseudo = :pseudo;
--

-- Spécifier les attributs de sa photo et spécifier le statut d’une photo (public ou privé)
--

-- Ajouter, modifier ou supprimer des tags

--
