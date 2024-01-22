# SetUp projet

## Prérequis
1. JDK 21
2. NodeJS pour avoir NPM et ainsi facilement installer TailwindCSS.
3. Gradle pour builder le projet.
4. Docker

## Déploiement
### Installation de la base de données et docker
Dans un premier temps, il faut lancer la base de données PostgreSQL. Pour cela, il faut se placer dans le dossier `photoz` et lancer le docker-compose.

Ensuite, il faut lancer le schéma de la base de données qui se trouve dans le dossier `photoz/app/src/main/database`. Pour cela, il faut se placer dans le dossier `photoz` et lancer le script `./app/src/main/database/project_schema`. Les autres scripts pour les requêtes, triggers, vues et les insert se trouve dans le dossier `photoz/app/src/main/scripts`.


### Build du projet
D'abord, il faut faire un build optimisé pour la production des styles CSS. Le fichier produit est toujours le même : `./app/src/main/static/out.css`
```bash
npm run prod
```

### Mise en place

1. Cloner le repos
```bash
   git clone https://github.com/CamilleKoestli/BDR_Project
```
2. Pour installer tailwindcss
```bash
   npm install -D tailwindcss
```
3. Pour charger le style une première fois et pour installer les dépendances
```bash
   npm i
   npm run prod
```

4. Pour lancer notre base de données PostgreSQL
```bash
   docker compose up -d
```
5. Pour lancer l'application directement (build + run)
```bash
   .\gradlew.bat run
```
6. Ouvrir son navigateur en `localhost:7000`