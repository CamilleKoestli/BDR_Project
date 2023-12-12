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
        constraint "Artiste___fk"
            references "Utilisateur",
    description varchar(255)
)INHERITS ("Utilisateur");

--
-- Table `status`
--
create table "Status"
(
    typedemande   BOOLEAN not null,
    accepte_refus BOOLEAN,
    pseudo        varchar(255) not null
        constraint "Status___fk"
            references "Utilisateur",
    "pseudoArt"   varchar(255) not null
        constraint "Status__pseudo_fk"
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
        constraint "Photo___fk"
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
        constraint "Commentaire___fk2"
            references "Utilisateur",
    id_photo integer
        constraint "Commentaire___fk"
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
        constraint "PhotoPrive_PhotoPrive__fk"
            references "Photo"
)INHERITS ("Photo");

--
-- Table `tag`
--
create table "Tag"
(
    pseudo varchar(255) not null
        constraint "Tag___fk"
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
        constraint "Reaction_Reaction__fk"
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
        constraint "TagUtilisateur_TagUtilisateur__fk"
            references "Utilisateur",
    mot    varchar(255) not null
        constraint "TagUtilisateur___fk"
            references "Tag",
    primary key (pseudo, mot)
);

--
-- Table `tag photo`
--
create table "TagPhoto"
(
    mot      varchar(255) not null
        constraint "TagPhoto_TagPhoto__fk2"
            references "Tag",
    id_photo integer      not null
        constraint "TagPhoto_pk"
            unique
        constraint "TagPhoto_TagPhoto__fk"
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
        constraint "DossierPhoto_fk"
            unique
        constraint "DossierPhoto___fk"
            references "Dossier",
    id_photo   integer not null
        constraint "DossierPhoto___fk2"
            references "Photo",
    primary key (id_photo, id_dossier)
);
