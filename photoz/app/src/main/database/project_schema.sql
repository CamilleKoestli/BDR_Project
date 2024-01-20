DROP SCHEMA IF EXISTS project_schema CASCADE;
CREATE SCHEMA project_schema;
COMMENT ON SCHEMA project_schema IS 'Projet de semestre BDR';

SET search_path = project_schema;
--
-- Table `utilisateur`
--
create table utilisateur
(
    pseudo      varchar(255) not null
        unique primary key,
    motdepasse  varchar(255) not null,
    email varchar(255) not null
);


--
-- Table `statut`
--
create table statut
(
    --TRUE : suiveur    FALSE : abonnement
    typedemande   BOOLEAN,
    -- TRUE : accepté   FALSE : refusé     NULL : en attente
    accepte_refus BOOLEAN NOT NULL,
    pseudo        varchar(255) not null
        constraint "Pseudo_fk"
            references utilisateur,
    pseudoart   varchar(255) not null
        constraint "pseudoart_fk"
            references utilisateur
);

--
-- Table `photo`
--
create table photo
(
    id_photo SERIAL PRIMARY KEY,
    titre       varchar(255) not null,
    datepubliee date,
    legende     text,
    chemin   varchar(255) not null,
    -- TRUE : public        FALSE : private
    visible        BOOLEAN not null default true,
    pseudo      varchar(255) not null
        constraint "pseudoart_fk"
            references utilisateur
);


--
-- Table `commentaire`
--
create table commentaire
(
    id_comm SERIAL PRIMARY KEY,
    texte    text,
    pseudo   varchar(255) not null
        constraint "Pseudo_fk"
            references utilisateur,
    id_photo integer
        constraint "IDPhoto_fk"
            references photo
);


--
-- Table `tag`
--
create table tag
(
    mot    varchar      not null
        constraint "tag_pk"
            primary key
);

--
-- Table `dossier`
--
create table dossier
(
    nom        varchar(255) not null,
    pseudo     varchar(255) not null
        references utilisateur,
    id_dossier serial
        primary key
);

--
-- Table `réaction`
--
create table reaction
(
    plus_moins boolean      not null,
    id_photo   integer      not null
        constraint "IDPhoto_fk"
            references photo,
    pseudo     varchar(255) not null
        references utilisateur,
    primary key (id_photo, pseudo)
);

--
-- Table `tag utilisateur`
--
create table tagutilisateur
(
    pseudo varchar(255) not null
        constraint "Pseudo_fk"
            references utilisateur,
    mot    varchar(255) not null
        constraint "mot_fk"
            references tag,
    primary key (pseudo, mot)
);

--
-- Table `tag photo`
--
create table tagphoto
(
    mot      varchar(255) not null
        constraint "mot_fk"
            references tag,
    id_photo integer      not null
        constraint "IDPhoto_fk"
            references photo,
    primary key (mot, id_photo)
);

--
-- Table `dossier photo`
--
create table dossierphoto
(
    id_dossier integer not null
        constraint "dossierphoto___fk"
            references dossier,
    id_photo   integer not null
        constraint "IDPhoto_fk"
            references photo,
    primary key (id_photo, id_dossier)
);

--
-- Table `badge`
--
create table badge
(
    nom         varchar(255),
    description varchar(255),
    id_badge    serial not null
        constraint "badge_pk"
            primary key
);

--
-- Table `badgeutilisateur`
--
create table badgeutilisateur
(
    id_badge serial     not null
        constraint "badgeutilisateur_badge_id_badge_fk"
            references badge,
    pseudo   varchar(255) not null
        constraint "badgeutilisateur_utilisateur_pseudo_fk"
            references utilisateur,
    constraint "badgeutilisateur_pk"
        primary key (id_badge, pseudo)
);

