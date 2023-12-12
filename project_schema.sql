DROP SCHEMA IF EXISTS projet_schema CASCADE;
CREATE SCHEMA projet_schema;
COMMENT ON SCHEMA projet_schema IS 'Projet de semestre BDR';

--
-- Table `utilisateur`
--
create table "Utilisateur"
(
    pseudo      varchar(255) not null
        primary key,
    motdepasse  varchar(255),
    adressemail varchar(255)
);

--
-- Table `artiste`
--
create table "Artiste"
(
    pseudo      varchar(255) not null
        constraint "Artiste_pk"
            primary key
        constraint "Pseudo_fk"
            references "Utilisateur",
    description varchar(255)
)INHERITS ("Utilisateur");

--
-- Table `Statut`
--
create table "Statut"
(
    --TRUE : suiveur    FALSE : abonnement
    typedemande   BOOLEAN not null,
    -- TRUE : accepté   FALSE : refusé     NULL : en attente
    accepte_refus BOOLEAN,
    pseudo        varchar(255) not null
        constraint "Pseudo_fk"
            references "Utilisateur",
    "pseudoArt"   varchar(255) not null
        constraint "PseudoArt_fk"
            references "Artiste"
);

--
-- Table `photo`
--
create table "Photo"
(
    id_photo SERIAL PRIMARY KEY,
    titre       varchar(255),
    datepubliee date,
    legende     text,
    extension   varchar(255),
    pseudo      varchar(255)
        constraint "PseudoArt_fk"
            references "Artiste"
);

--
-- Table `commentaire`
--
create table "Commentaire"
(
    id_comm SERIAL PRIMARY KEY,
    texte    text,
    pseudo   varchar(255)
        constraint "Pseudo_fk"
            references "Utilisateur",
    id_photo integer
        constraint "IDPhoto_fk"
            references "Photo"
);

--
-- Table `photo public`
--
create table "PhotoPublic"
(
    id_photo SERIAL PRIMARY KEY
        references "Photo"
)INHERITS ("Photo");

--
-- Table `photo privée`
--
create table "PhotoPrive"
(
    id_photo SERIAL PRIMARY KEY
        constraint "IDPhoto_fk"
            references "Photo"
)INHERITS ("Photo");

--
-- Table `tag`
--
create table "Tag"
(
    pseudo varchar(255) not null
        constraint "PseudoArt_fk"
            references "Artiste",
    mot    varchar      not null
        constraint "Tag_pk"
            primary key
);

--
-- Table `dossier`
--
create table "Dossier"
(
    nom        varchar(255) not null,
    pseudo     varchar(255) not null
        constraint "Dossier_pk"
            unique
        references "Utilisateur",
    id_dossier SERIAL PRIMARY KEY
);

--
-- Table `réaction`
--
create table "Reaction"
(
    plus_moins varchar(255) not null,
    id_photo   integer      not null
        constraint "Reaction_pk2"
            unique
        constraint "IDPhoto_fk"
            references "Photo",
    pseudo     varchar(255) not null
        constraint "Reaction_pk"
            unique
        references "Utilisateur",
    primary key (id_photo, pseudo)
);

--
-- Table `tag utilisateur`
--
create table "TagUtilisateur"
(
    pseudo varchar(255) not null
        constraint "Pseudo_fk"
            references "Utilisateur",
    mot    varchar(255) not null
        constraint "Mot_fk"
            references "Tag",
    primary key (pseudo, mot)
);

--
-- Table `tag photo`
--
create table "TagPhoto"
(
    mot      varchar(255) not null
        constraint "Mot_fk"
            references "Tag",
    id_photo integer      not null
        constraint "TagPhoto_pk"
            unique
        constraint "IDPhoto_fk"
            references "Photo",
    primary key (mot, id_photo)
);

--
-- Table `dossier photo`
--
create table "DossierPhoto"
(
    id_dossier integer not null
        constraint "DossierPhoto_pk"
            unique
        constraint "IDDossier_fk"
            unique
        constraint "DossierPhoto___fk"
            references "Dossier",
    id_photo   integer not null
        constraint "IDPhoto_fk"
            references "Photo",
    primary key (id_photo, id_dossier)
);
