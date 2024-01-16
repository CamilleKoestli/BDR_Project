--
-- Views
--
set search_path=project_schema;
DROP view view_photo_follow_subscription;
DROP view view_photo_tag;

-- Accès aux photos en fonction des abonnements et des suiveurs
CREATE OR REPLACE VIEW view_photo_follow_subscription AS
SELECT p.id_photo,
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
--

-- Les tags
CREATE OR REPLACE VIEW view_photo_tag AS
SELECT p.id_photo,
       p.titre,
       p.datepubliee,
       p.legende,
       p.chemin,
       p.pseudo AS artistepseudo,
       tp.mot   AS tag
FROM photo p
         INNER JOIN
     tagphoto tp ON p.id_photo = tp.id_photo
         INNER JOIN
     tag t ON tp.mot = t.mot;
--
