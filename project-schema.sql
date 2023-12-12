create table "Utilisateur"
(
    pseudo      varchar(255) not null
        primary key,
    motdepasse  varchar(255),
    adressemail varchar(255)
);

alter table "Utilisateur"
    owner to postgres;

create table "Artiste"
(
    pseudo      varchar(255) not null
        constraint "Artiste_pk"
            primary key
        constraint "Artiste___fk"
            references "Utilisateur",
    description varchar(255)
);

alter table "Artiste"
    owner to postgres;

create table "Status"
(
    typedemande   varchar(255) not null,
    accepte_refus varchar(255),
    pseudo        varchar(255) not null
        constraint "Status___fk"
            references "Utilisateur"
);

alter table "Status"
    owner to postgres;

create table "Photo"
(
    id_photo    integer not null
        primary key,
    titre       varchar(255),
    datepubliee date,
    legende     text,
    extension   varchar(255),
    pseudo      varchar(255)
        constraint "Photo___fk"
            references "Artiste"
);

alter table "Photo"
    owner to postgres;

create table "Commentaire"
(
    id_comm  integer not null
        primary key,
    texte    text,
    pseudo   varchar(255)
        constraint "Commentaire___fk2"
            references "Utilisateur",
    id_photo integer
        constraint "Commentaire___fk"
            references "Photo"
);

alter table "Commentaire"
    owner to postgres;

create table "PhotoPublic"
(
    id_photo integer not null
        primary key
        references "Photo"
);

alter table "PhotoPublic"
    owner to postgres;

create table "PhotoPrive"
(
    id_photo integer not null
        primary key
        constraint "PhotoPrive_PhotoPrive__fk"
            references "Photo"
);

alter table "PhotoPrive"
    owner to postgres;

create table "Tag"
(
    pseudo varchar(255) not null
        constraint "Tag___fk"
            references "Artiste",
    mot    varchar      not null
        constraint "Tag_pk"
            primary key
);

alter table "Tag"
    owner to postgres;

create table "Dossier"
(
    nom        varchar(255) not null,
    pseudo     varchar(255) not null
        constraint "Dossier_pk"
            unique
        references "Utilisateur",
    id_dossier integer      not null
        primary key
);

alter table "Dossier"
    owner to postgres;

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

alter table "Reaction"
    owner to postgres;

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

alter table "TagUtilisateur"
    owner to postgres;

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

alter table "TagPhoto"
    owner to postgres;

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

alter table "DossierPhoto"
    owner to postgres;
