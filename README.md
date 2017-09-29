VelObs
========

Application web permettant aux cyclistes de signaler les problèmes sur les aménagements cyclables ; puis aux collectivités territoriales compétentes de les traiter.

C'est en production à Toulouse pour 2 pieds 2 roues sur : http://velobs.2p2r.org/

# Quelques commentaires sur l'application :

* le répertoire lib/js contient tous les scripts nécessaires à l'utilisation :
    * key.js.template configuration des variables spécifiques à votre instance (pour l'instant uniquement l'API KEY de thunderforest
    * translation_fr.js et translation_en.js les deux fichiers de traduction de tous les textes affichés à l'écran (il est possible de modifier les préférences pour chaque utilisateur via base de données et le champ language_id_language de la table users)
    * tous les scripts JavaScript décomposés en trois répertoires :
        * admin : les scripts pour les différents rôles d'usage de l'interface d'administration (1 => admin général 2p2r ; 2 => admin comcom ; 3 => pole technique ; 4 => admin pole 2p2r)
        * public : les scripts pour la carte publique
        * framework : bibliothèques ExtJS 3.4, GeoExt, OpenLayers 2.11 et 4 extensions de classes ExtJS

 * le répertoire lib/php contient tous les scripts serveurs PHP :
    * key.php (configuration générale pour l'accès à la base de données)
    * commonfunction.php pour une fonction commune aux parties publiques et admin
    * tous les scripts sont décomposés en trois répertoires :
        * public :
            * les fichiers get*.php pour les scripts de menu déroulant
            * uploadPhoto.php si une photo éventuelle
        * admin :
            * tous les fichiers get*.php servent principalement à la construction des différents menus déroulants
            * tous les fichiers update*.php servent à la modification des enregistrements par les poles via la carto et pour modifier la construction de l'arbre des couches
            * tous les fichiers upload*.php servent pour le transfert d'images ou d'icones
            * database.php et adminfunction.php sont les deux scripts principaux
            * login.php et disconnect.php pour la gestion des sessions utilisateurs
        * mobile :
            * les scripts pour l'affichage des menus déroulants pour les applications mobile et les scripts pour les nouveaux enregistrements ainsi que pour l'ajout de photos et commentaires éventuels

 * le répertoire resources contient les fichiers plats :
    * répertoire css pour les différentes feuilles de style
    * répertoire csv de stockage d'export des fichiers csv
    * répertoire favicon
    * répertoire html qui contient les pages html des modes d'emploi
    * répertoire icon contient les sets d'icones utilisés + les icônes uploadés pour l'arbre des couches
    * répertoire images les images logo et autres
    * répertoire kml des fichiers de géométries (utile au début)
    * répertoire pictures contient toutes les images relatives aux enregistrements
    * répertoire prefs contient tous les fichiers de configuration
    * répertoire sql contient toutes les tables de la base de données à la date du 10 janvier 2016
   
#   Notice d'installation pour l'application VelObs :

 * décompresser l'archive dans le répertoire voulu sur le serveur de production
 * copier le fichier lib/js/key.js.template vers lib/js/key.js
 * éditer lib/js/key.js en ajoutant votre clé d'API thunderforest
 * copier le ficher lib/php/key.php.template vers lib/php/key.php
 * copier le fichier resources/prefs/velobs.prefs.template vers resources/prefs/velobs.prefs

#   éditer resources/prefs/velobs.prefs :

 * Configurer velobs pour un autre territoire :
 	* CONFIGMAP : coordonnées GPS du centre de la carte et niveau de zoom.
 	* TERRITOIRES : remplir le libellé, type et les ids (codes INSEE des communes du territoire).
 	* COMMUNE : [non configurable] liste des communes caractérisées par leur code INSEE et leur contour géographique.
    * QUARTIER: liste des noms de quartiers d'une commune. Un fichier de configuration par ville.
    	* 1. Copier le fichier resources/prefs/quartiers.prefs.template vers resources/prefs/quartiers.ABCD.prefs
    	* 2. Indiquer l'id de la commune dans quartier_id_commune (TODO : indiquer comment).
    	* 3. Remplir les quartiers de cette ville (TODO : indiquer comment).
    	* 4. Répéter pour configurer une autre ville.
 	* USER - Admin : administrateur par défaut, modifier le login & mot de passe. D'autres utilisateurs pourront être ajoutés via l'espace d'administration.
    * POLE: [non configurable] liste des poles caractérisés par leur nom et leur contour géographique.
 
 * 	Paramètres avancés, à adapter au besoin : 	
 	* DATABASE : login, password et nom de la base de données MySQL VelObs.
 	* CATEGORY : libellés, icone, rang et affichage (TODO : ?) des catégories d'observations.
 		* SUB-CATEGORY : libellés, icone, rang et affichage (TODO : ?) des sous-catégories d'observations.
 	* PRIORITE : libellés des priorités des observations.
 	* STATUS :  libellés des statuts des observations.
 	* USERTYPE : types d'utilisateurs. Par défaut : Administrateur, Comcom (TODO : ?), Pole technique, Responsable pole association.
    * LANGUAGE : Langues disponibles. Par défaut : fr, en.
 * créer une base de données MySQL (ex. velobs) :
    * interclassement : utf8_general_ci
 * Editer le fichier lib/php/key.php :
    * définir la constante HOST : url du serveur MySQL
    * définir la constante PORT : port du serveur MySQL
    * définir la constante DB_USER : login du serveur MySQL
    * définir la constante DB_PASS : password du serveur MySQL
    * définir la constante DB_NAME : nom de la base de données VelObs
    * définir la constante URL : url de l'application
    * définir les constantes  MAIL_* pour l'envoi des mails de VélObs
    * définir les constantes VELOBS_* en fonction des institutions avec lesquelles vous travaillez
 * modifier les droits en écriture pour les répertoires :
    * resources/pictures
    * resources/icon/marker
    * resources/icon/marker/16x18
    * resources/csv
 * modifier les droits en écriture pour le fichier resources/css/icon.css
 * pour importer les 19 scripts SQL du répertoire resources/sql, utiliser le script dédié
 	* chmod +x ./import_script.sh
 	* import_script.sh
 * pour remplir la base de données, utiliser le script dédié
 	* chmod +x ./fill_db_from_prefs.sh
 	* ./fill_db_from_prefs.sh 
 
#   Notice d'adaptation à d'autres territoires pour l'application VelObs :

  * éditer le fichier lib/php/key.php :  
     * définir les variables propres à l'association vélo et les collectivités concernées
  * éditer les fichiers  lib/js/translate_fr.js et lib/js/translate_en.js pour adapter à votre contexte les variables
     * T_header_main : contenu du panneau supérieur de la page principale
     * T_textEmergencyContact : contenu du pop up "comment participer", indiquer le numéro de téléphone du service technique de la collectivité.
  * adapter les logos dans resources/images en respectant les dimensions    
  * éditer les fichiers de préférences
     * le dossier resources/prefs/ contient les différents fichiers de configuration de l'application
        * velobs.prefs : donées principales
        * quartiers_*.prefs : liste des quartiers pour une zone donnée
