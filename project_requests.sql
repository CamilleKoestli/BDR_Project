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

-- Consulter les photos que peut voir un utilisateur
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
--

-- Ajouter ou modifier un commentaire
--

-- Ajouter ou modifier une réaction
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
--

-- Spécifier les attributs de sa photo et spécifier le statut d’une photo (public ou privé)
--

-- Ajouter, modifier ou supprimer des tags
--
