--
-- Views
--

-- Accès aux photos en fonction des abonnements et des suiveurs
CREATE OR REPLACE VIEW view_photo_follow_subscription AS
SELECT pp.id_photo,
       pp.titre,
       pp.datepubliee,
       pp.legende,
       pp.extension,
       pp.pseudo AS artiste_pseudo,
       s.pseudo  AS utilisateur_pseudo
FROM "PhotoPrive" pp
         INNER JOIN
     "Status" s ON pp.pseudo = s."pseudoArt"
         INNER JOIN
     "Utilisateur" u ON s.pseudo = u.pseudo
WHERE s.accepte_refus = TRUE;
--

-- Les tags
CREATE OR REPLACE VIEW view_photo_tag AS
SELECT
    p.id_photo,
    p.titre,
    p.datepubliee,
    p.legende,
    p.extension,
    p.pseudo AS artiste_pseudo,
    tp.mot AS tag
FROM
    "Photo" p
JOIN
    "TagPhoto" tp ON p.id_photo = tp.id_photo
JOIN
    "Tag" t ON tp.mot = t.mot;
--
