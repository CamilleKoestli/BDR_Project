--
-- Views
--

-- Accès aux photos en fonction des abonnements et des suiveurs
CREATE OR REPLACE VIEW view_photo_follow_subscription AS
SELECT p.id_photo,
       p.titre,
       p.datepubliee,
       p.legende,
       p.pseudo AS artiste_pseudo,
       s.pseudo  AS utilisateur_pseudo
FROM "Photo" p
         INNER JOIN
     "Statut" s ON p.pseudo = s."pseudoArt"
         INNER JOIN
     "Utilisateur" u ON s.pseudo = u.pseudo
WHERE s.accepte_refus = TRUE;
--

-- Les tags
CREATE OR REPLACE VIEW view_photo_tag AS
SELECT p.id_photo,
       p.titre,
       p.datepubliee,
       p.legende,
       p.chemin,
       p.pseudo AS artiste_pseudo,
       tp.mot   AS tag
FROM "Photo" p
         INNER JOIN
     "TagPhoto" tp ON p.id_photo = tp.id_photo
         INNER JOIN
     "Tag" t ON tp.mot = t.mot;
--
