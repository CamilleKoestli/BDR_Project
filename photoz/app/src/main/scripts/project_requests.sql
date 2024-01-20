SET search_path = project_schema;

--
-- Requests
--

--
-- utilisateur
--

-- Consulter tous les utilisateurs
SELECT *
FROM utilisateur;
--

-- Consulter, créer et modifier un utilisateur
-- Consulter un utilisateur
SELECT *
FROM utilisateur
WHERE pseudo = :pseudo;

-- Créer un nouvel utilisateur
INSERT INTO utilisateur (pseudo, motdepasse, adressemail)
VALUES (:pseudo, :motdepasse, :adressemail);

-- Mise à jour d'un utilisateur
UPDATE utilisateur
SET motdepasse  = :motdepasse,
    adressemail = :adressemail
WHERE pseudo = :pseudo;

-- Supprimer un utilisateur
DELETE
FROM utilisateur
WHERE pseudo = :pseudo;
--

-- Suivre ou ne plus suivre à un artiste
-- Suivre un artiste TRUE
INSERT INTO statut (typedemande, accepte_refus, pseudo, pseudoart)
VALUES (TRUE, TRUE, :pseudo, :pseudo);

-- Ne plus suivre un artiste
UPDATE statut
SET accepte_refus = FALSE
WHERE pseudo = :pseudo
  AND pseudoart = :pseudo;
--

-- S'abonner ou se désabonner à un artiste
-- S'abonner à un artiste FALSE
INSERT INTO statut (typedemande, accepte_refus, pseudo, pseudoart)
VALUES (FALSE, NULL, :pseudo, :pseudo);

-- Se désabonner un artiste
UPDATE statut
SET accepte_refus = FALSE
WHERE pseudo = :pseudo
  AND pseudoart = :pseudo;
--

-- Créer, modifier et supprimer un dossier
-- Créer dossier
INSERT INTO dossier (nom, pseudo)
VALUES (:nom, :pseudo);

-- Mise à jour dossier
UPDATE dossier
SET nom = :nom
WHERE pseudo = :pseudo
  AND id_dossier = true;

-- Supprimer dossier
DELETE
FROM dossier
WHERE pseudo = :pseudo
  AND id_dossier = :nom;
--

-- Mettre ou enlever une photo d’un dossier
-- Mettre une photo dans un dossier
INSERT INTO dossierphoto (id_dossier, id_photo)
VALUES (:dossier, :photo);

-- Enlever une photo dans un dossier
DELETE
FROM dossierphoto
WHERE id_dossier = :dossier
  AND id_photo = :photo;
--

-- Ajouter ou modifier un commentaire
-- Ajouter un commentaire
INSERT INTO commentaire (texte, pseudo, id_photo)
VALUES (:text, :pseudo, :photo);

-- Modifier un commentaire
UPDATE commentaire
SET texte = :texte
WHERE id_comm = :id_comm;
--

-- Ajouter ou modifier une réaction
-- Ajouter une réaction
INSERT INTO reaction (plus_moins, id_photo, pseudo)
VALUES (:plus_moins, :photo, :pseudo);

-- Modifier une réaction
UPDATE reaction
SET plus_moins = :plus_moins
WHERE id_photo = :id_photo
  AND pseudo = :pseudo;
--


--
-- Artiste
--

-- Consulter tous les artistes
SELECT *
FROM utilisateur U
INNER JOIN photo P ON U.pseudo = P.pseudo;
--

-- Consulter les photos publiques et privées de tout le monde
SELECT *
FROM photo;
--

-- Consulter les photos publiques de tout le monde
SELECT *
FROM photo
WHERE visible = true;
--

-- Consulter les photos publiques et privées d’un artiste selon le statut de l’utilisateur
SELECT *
FROM photo
WHERE (visible = true AND pseudo = :pseudo)
   OR (visible = false AND pseudo = :pseudo AND artistepseudo = :pseudo)
--

-- Consulter les photos publiques d'un artiste
SELECT *
FROM photo
WHERE visible = true
    AND photo.pseudo = :pseudo;
--

-- Consulter une photo
SELECT *
FROM photo
WHERE id_photo = :id_photo;
--

-- Accepter ou refuser une demande d’abonnement
UPDATE statut
SET accepte_refus = :reponse
WHERE typedemande = FALSE
  AND pseudo = :pseudo
  AND pseudoart = :pseudo;

-- Ajouter ou supprimer une photo
-- Ajouter une photo
INSERT INTO photo(titre, datepubliee, legende, chemin, visible, pseudo)
VALUES (:titre, :datepubliee, :legende, :extension, :visible, :pseudo);

-- Supprimer une photo
UPDATE photo
SET titre   = :titre,
    datepubliee = :datepubliee,
    legende = :legende,
    chemin = :chemin,
    visible   = :visible
WHERE id_photo = :photo
  AND pseudo = :pseudo;
--

-- Spécifier les attributs de sa photo et spécifier le statut d’une photo (public ou privé)
-- Attributs photos
DELETE
FROM photo
WHERE id_photo = :photo
  AND pseudo = :pseudo;


-- Ajouter, modifier ou supprimer des tags
-- Ajouter un nouveau tag
INSERT INTO Tagphoto (mot, id_photo)
VALUES (:mot, :photo);

-- Modifier le tag
UPDATE tagphoto
SET mot = :mot
WHERE id_photo = :mot AND mot = :mot;

-- Supprimer le tag de la photo
DELETE FROM Tagphoto
WHERE id_photo = :photo AND mot = :mot;
--

--
-- badges
--

-- Voir tous les badges d'un utilisateur
SELECT B.*
FROM badge B
JOIN badgeutilisateur BU ON B.id_badge = BU.id_badge
WHERE BU.pseudo = :pseudo;

-- Voir tous les badges d'un utilisateur
SELECT b.id_badge, b.nom
FROM badge b
INNER JOIN badgeutilisateur bu ON b.id_badge = bu.id_badge
WHERE bu.pseudo = pseudo;

SELECT DISTINCT p.id_photo,
       p.titre,
       p.datepubliee,
       p.legende,
       p.chemin,
       p.visible,
       p.pseudo AS artistepseudo,
       s.pseudo  AS utilisateurpseudo
FROM photo p
         INNER JOIN
     statut s ON p.pseudo = s.pseudoart
         INNER JOIN
     utilisateur u ON s.pseudo = u.pseudo
WHERE s.accepte_refus = TRUE;