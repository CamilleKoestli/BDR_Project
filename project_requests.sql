--
-- Requests
--

-- Insertion données
CREATE OR REPLACE PROCEDURE insert_data(
    p_table_name VARCHAR,
    p_values VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'INSERT INTO "' || p_table_name || '" VALUES ' || p_values || ';';
END;
$$;
--

--
-- Utilisateur
--

-- Consulter tous les utilisateurs
SELECT *
FROM "Utilisateur";

-- Consulter, créer et modifier un utilisateur
-- Consulter un utilisateur
CREATE OR REPLACE PROCEDURE see_user(
    u_pseudo VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT *
    FROM "Utilisateur"
    WHERE pseudo = u_pseudo;
END
$$;

-- Créer un nouvel utilisateur
CREATE OR REPLACE PROCEDURE create_user(
    u_pseudo VARCHAR,
    u_motdepasse VARCHAR,
    u_adressemail VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO "Utilisateur" (pseudo, motdepasse, adressemail)
    VALUES (u_pseudo, u_motdepasse, u_adressemail);
END
$$;

-- Mise à jour d'un utilisateur
CREATE OR REPLACE PROCEDURE update_user(
    u_pseudo VARCHAR,
    u_motdepasse VARCHAR,
    u_adressemail VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE "Utilisateur"
    SET motdepasse  = u_motdepasse,
        adressemail = u_adressemail
    WHERE pseudo = u_pseudo;
END
$$;

-- Supprimer un utilisateur
CREATE OR REPLACE PROCEDURE delete_user(
    u_pseudo VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    DELETE
    FROM "Utilisateur"
    WHERE pseudo = u_pseudo;
END
$$;
--

-- Suivre ou ne plus suivre à un artiste
-- Suivre un artiste
CREATE OR REPLACE PROCEDURE follow_artist(
    u_pseudo VARCHAR(255),
    a_pseudo VARCHAR(255)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO "Statut" (typedemande, accepte_refus, pseudo, "pseudoArt")
    VALUES (TRUE, TRUE, u_pseudo, a_pseudo);
END;
$$;

-- Ne plus suivre un artiste
CREATE OR REPLACE PROCEDURE unfollow_artist(
    u_pseudo VARCHAR(255),
    a_pseudo VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Statut"
    SET accepte_refus = FALSE
    WHERE pseudo = u_pseudo AND "pseudoArt" = a_pseudo;
END;
$$;
--

-- S'abonner ou se désabonner à un artiste
-- S'abonner à un artiste
    CREATE OR REPLACE PROCEDURE subscribe_artist(
    u_pseudo VARCHAR(255),
    a_pseudo VARCHAR(255)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO "Statut" (typedemande, accepte_refus, pseudo, "pseudoArt")
    VALUES (FALSE, NULL, u_pseudo, a_pseudo);
END;
$$;

-- Se désabonner un artiste
CREATE OR REPLACE PROCEDURE unsubscribe_artist(
    utilisateur_pseudo VARCHAR(255),
    artiste_pseudo VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Statut"
    SET accepte_refus = FALSE
    WHERE pseudo = utilisateur_pseudo AND "pseudoArt" = artiste_pseudo;
END;
$$;
--

-- Créer, modifier et supprimer un dossier
-- Créer dossier
CREATE OR REPLACE PROCEDURE create_file(
    f_nom VARCHAR,
    u_pseudo VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO "Dossier" (nom, pseudo)
    VALUES (f_nom, u_pseudo);
END
$$;

-- Mise à jour dossier
CREATE OR REPLACE PROCEDURE update_file(
    f_nom VARCHAR,
    u_pseudo VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE "Dossier"
    SET nom = f_nom
    WHERE pseudo = u_pseudo
      AND id_dossier = true;
END
$$;

-- Supprimer dossier
CREATE OR REPLACE PROCEDURE delete_file(
    f_nom VARCHAR,
    u_pseudo VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    DELETE
    FROM "Dossier"
    WHERE pseudo = u_pseudo
      AND id_dossier = f_nom;
END
$$;
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

-- Accepter ou refuser une demande d’abonnement
CREATE OR REPLACE PROCEDURE respond_subscription_request(
    u_pseudo VARCHAR(255),
    a_pseudo VARCHAR(255),
    accepted BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Statut"
    SET accepte_refus = accepted
    WHERE typedemande = FALSE
        AND pseudo = a_pseudo
        AND "pseudoArt" = u_pseudo;
END;
$$;
-- Ajouter ou supprimer une photo
--

-- Spécifier les attributs de sa photo et spécifier le statut d’une photo (public ou privé)
--

-- Ajouter, modifier ou supprimer des tags
--
