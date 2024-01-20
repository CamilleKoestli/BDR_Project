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



CREATE OR REPLACE VIEW vue_utilisateur_sur_artiste AS
SELECT DISTINCT p.*,
                s.pseudo    AS utilisateurpseudo,
                s.pseudoart AS artistepseudo
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



/*-- Savoir le statut d'un utilisateur par rapport à un artiste
CREATE OR REPLACE VIEW vue_statut_accepte AS
SELECT
    pseudo,
    pseudoart,
    CASE
        WHEN typedemande = FALSE AND accepte_refus = TRUE THEN TRUE
        WHEN typedemande = FALSE AND accepte_refus = FALSE THEN FALSE
        WHEN typedemande = TRUE AND accepte_refus = TRUE THEN FALSE
        WHEN typedemande = NULL THEN NULL
        END AS a_acces
FROM
    statut;*/

/*-- Accès aux photos en fonction des abonnements et des suiveurs
CREATE OR REPLACE VIEW view_photo_follow_subscription AS
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
WHERE s.accepte_refus = TRUE;*/

--
-- Accès aux photos en fonction des abonnements et des suiveurs
/*CREATE OR REPLACE VIEW vue_photos_acces AS
SELECT DISTINCT
    p.id_photo,
    p.titre,
    p.datepubliee,
    p.legende,
    p.chemin,
    p.visible,
    p.pseudo AS artistepseudo,
    s.typedemande,
    s.accepte_refus,
    CASE
        WHEN s.typedemande = FALSE AND s.accepte_refus = TRUE THEN TRUE
        WHEN s.typedemande = TRUE THEN TRUE
        ELSE FALSE
    END AS a_acces
FROM
    photo p
LEFT JOIN
    statut s ON p.pseudo = s.pseudoart AND s.pseudo = :pseudo;

SELECT * FROM vue_photos_acces WHERE a_acces = TRUE;*/
--




