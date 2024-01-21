--
-- Views
--
set search_path = project_schema;

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

-- Savoir le statut d'un utilisateur par rapport à un artiste
CREATE OR REPLACE VIEW vue_statut_utilisateur AS
SELECT DISTINCT p.*,
                p.pseudo AS artistepseudo,
                s.pseudo AS utilisateurpseudo

FROM photo p
         INNER JOIN (SELECT pseudo,
                            pseudoart,
                            CASE
                                WHEN typedemande = FALSE AND accepte_refus = TRUE THEN TRUE
                                WHEN typedemande = FALSE AND accepte_refus = FALSE THEN FALSE
                                WHEN typedemande = TRUE AND accepte_refus = TRUE THEN FALSE
                                WHEN typedemande = NULL THEN NULL
                                END AS a_acces

                     FROM statut) s ON p.pseudo = s.pseudoart
         INNER JOIN utilisateur u ON s.pseudo = u.pseudo
WHERE (s.a_acces = false AND p.visible = true)
   OR (s.a_acces = true AND p.visible = false);
--

-- Accès aux photos en fonction des abonnements et des suiveurs
CREATE OR REPLACE VIEW vue_utilisateur_sur_artiste AS
SELECT DISTINCT p.*,
                s.pseudoart AS artistepseudo,
                s.pseudo    AS utilisateurpseudo
FROM photo p
         INNER JOIN (SELECT pseudo,
                            pseudoart,
                            CASE
                                WHEN typedemande = FALSE AND accepte_refus = TRUE THEN TRUE
                                WHEN typedemande = FALSE AND accepte_refus = FALSE THEN FALSE
                                WHEN typedemande = TRUE AND accepte_refus = TRUE THEN FALSE
                                WHEN typedemande = NULL THEN NULL
                                END AS a_acces

                     FROM statut) s ON p.pseudo = s.pseudoart
         INNER JOIN utilisateur u ON s.pseudo = u.pseudo
WHERE (s.a_acces = false AND p.visible = true)
   OR (s.a_acces = true AND p.visible = false);
--