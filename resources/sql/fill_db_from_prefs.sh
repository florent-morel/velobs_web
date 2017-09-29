#!/bin/bash

velobs_root="/var/www/velobs"
resources_path="$velobs_root/resources"
prefs_file="$resources_path/prefs/velobs.prefs"
quartier_files="$resources_path/prefs/quartiers/quartiers.*.prefs"

echo "Filling database $db from preferences file $prefs_file"
source $prefs_file


echo "#############"
echo "# CONFIGMAP #"
echo "#############"
echo "INSERT INTO configmap (lat_configmap, lon_configmap, zoom_configmap) VALUES ('$lat', '$lon', '$zoom')" | mysql -v -u $username -p$pwd $db



echo "###############"
echo "# TERRITORIES #"
echo "###############"
cmd_ter_base="INSERT INTO territoire (id_territoire, lib_territoire, type_territoire, ids_territoire) VALUES "
cmd_ter_0="(0, '$ter_0_lib', $ter_0_type, '$ter_0_ids')"
cmd_ter_1="(1, '$ter_1_lib', $ter_1_type, '$ter_1_ids')"
cmd_ter_2="(2, '$ter_2_lib', $ter_2_type, '$ter_2_ids')"
cmd_ter_3="(3, '$ter_3_lib', $ter_3_type, '$ter_3_ids')"

echo "$cmd_ter_base$cmd_ter_0" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_1" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_2" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_3" | mysql -v -u $username -p$pwd $db


echo "############"
echo "# COMMUNES #"
echo "############"
# See dedicated files communes_*.prefs
#source $commune_file.prefs
#
#cmd_commune_base="INSERT INTO commune (id_commune, lib_commune, geom_commune) VALUES "
#
## ${!array[@]} is the list of all the indexes set in the array
#for i in ${!commune_list[@]}; do
#	cmd_commune="($i, '${commune_list[$i]}')"
#	echo "$cmd_commune_base$cmd_commune" | mysql -v -u $username -p$pwd $db
#done

echo "############"
echo "# QUARTIER #"
echo "############"
# See dedicated files quartiers_*.prefs
#source $quartier_file.prefs
#
#cmd_quartier_base="INSERT INTO quartier (id_quartier, lib_quartier) VALUES "
#
## ${!array[@]} is the list of all the indexes set in the array
#for i in ${!quartierlist[@]}; do
#	cmd_quartier="($i, '${quartierlist[$i]}')"
#	echo "$cmd_quartier_base$cmd_quartier" | mysql -v -u $username -p$pwd $db
#done

cmd_quartier_base="INSERT INTO quartier (id_quartier, id_commune, lib_quartier) VALUES "
if [ -z "$(ls -A $quartier_files)" ]; then
	echo "No file found, please create a file for at least one city: prefs/quartiers/quartiers.ABC.prefs"
else
	echo "Not Empty"
	for file in $quartier_files
	do
	        echo Processing $file...
			source $file
			# ${!array[@]} is the list of all the indexes set in the array
			for i in ${!quartierlist[@]}; do
				cmd_quartier="($quartier_id_commune$i, $quartier_id_commune, '${quartierlist[$i]}')"
				echo "$cmd_quartier_base$cmd_quartier" | mysql -v -u $username -p$pwd $db
			done
	        echo Finished processing $file...
	done
	echo Processing default...
	cmd_quartier_zero="(0, 0, '${quartierlist_default[0]}')"
	echo "$cmd_quartier_base$cmd_quartier_zero" | mysql -v -u $username -p$pwd $db
	cmd_quartier_99999="(99999, 0, '${quartierlist_default[99999]}')"
	echo "$cmd_quartier_base$cmd_quartier_99999" | mysql -v -u $username -p$pwd $db
fi


echo "############"
echo "# USERTYPE #"
echo "############"
cmd_usertype_base="INSERT INTO usertype (id_usertype, lib_usertype) VALUES "

# ${!array[@]} is the list of all the indexes set in the array
for i in ${!usertype[@]}; do
	cmd_usertype="($i, '${usertype[$i]}')"
	echo "$cmd_usertype_base$cmd_usertype" | mysql -v -u $username -p$pwd $db
done

echo "############"
echo "# CATEGORY #"
echo "############"
cmd_category_base="INSERT INTO category (id_category, lib_category, icon_category, treerank_category, display_category) VALUES "

for i in ${!category[@]}; do
	cmd_category="(${category[$i]})"
	echo "$cmd_category_base$cmd_category" | mysql -v -u $username -p$pwd $db
done



echo "################"
echo "# SUB-CATEGORY #"
echo "################"
cmd_subcategory_base="INSERT INTO subcategory (id_subcategory, lib_subcategory, icon_subcategory, treerank_subcategory, display_subcategory, proppublic_subcategory, category_id_category) VALUES "

for i in ${!subcategory[@]}; do
	cmd_subcategory="(${subcategory[$i]})"
	echo "$cmd_subcategory_base$cmd_subcategory" | mysql -v -u $username -p$pwd $db
done


echo "############"
echo "# PRIORITE #"
echo "############"
cmd_prio_base="INSERT INTO priorite (id_priorite, lib_priorite) VALUES "

# ${!array[@]} is the list of all the indexes set in the array
for i in ${!prio_list[@]}; do
	cmd_prio="($i, '${prio_list[$i]}')"
	# echo "$cmd_prio_base$cmd_prio"
	echo "$cmd_prio_base$cmd_prio" | mysql -v -u $username -p$pwd $db
done

echo "##########"
echo "# STATUS #"
echo "##########"
cmd_status_base="INSERT INTO status (id_status, lib_status) VALUES "

# ${!array[@]} is the list of all the indexes set in the array
for i in ${!status_list[@]}; do
	cmd_status="($i, '${status_list[$i]}')"
	echo "$cmd_status_base$cmd_status" | mysql -v -u $username -p$pwd $db
done


echo "############"
echo "# LANGUAGE #"
echo "############"
cmd_language_base="INSERT INTO language (id_language, lib_language, extension_language) VALUES "
cmd_language="($lang_1)"
echo "$cmd_language_base$cmd_language" | mysql -v -u $username -p$pwd $db
	
cmd_language="($lang_2)"
echo "$cmd_language_base$cmd_language" | mysql -v -u $username -p$pwd $db



echo "##############"
echo "# ICONMARKER #"
echo "##############"
cmd_iconmarker_base="INSERT INTO iconmarker (id_iconmarker, name_iconmarker, urlname_iconmarker, color_iconmarker) VALUES "

for i in ${!iconmarker[@]}; do
	cmd_iconmarker="(${iconmarker[$i]})"
	echo "$cmd_iconmarker_base$cmd_iconmarker" | mysql -v -u $username -p$pwd $db
done






echo "###############"
echo "# TRANSLATION #"
echo "###############"
cmd_l10n="INSERT INTO translation (id_translation, code_translation, lib_translation, language_id_language) VALUES
(1, 'DISCONNECT', 'Déconnexion', 1),
(2, 'DISCONNECT', 'Disconnect', 2),
(3, 'OPENPUBLICMAP', 'Prévisualiser la carte publique', 1),
(4, 'OPENPUBLICMAP', 'Display public map', 2),
(5, 'HELLO', 'Bonjour', 1),
(6, 'HELLO', 'Hello', 2),
(7, 'CLICKOPENUSERPREFERENCE', 'Cliquez pour ouvrir vos préférences', 1),
(8, 'CLICKOPENUSERPREFERENCE', 'Click to open your preferences', 2),
(9, 'ICONPNG', 'Seule l''extension png est autorisée.', 1),
(10, 'ICONPNG', 'Only the png extension is allowed.', 2),
(11, 'ICONSIZE', 'La taille de l''image ne doit pas dépasser 50 Ko !', 1),
(12, 'ICONSIZE', 'The image size should not exceed 50 KB!', 2),
(13, 'ERROR', 'Erreur', 1),
(14, 'ERROR', 'Error', 2),
(15, 'ICONSIZEPIXEL', 'La taille de l''icône doit être de 32 pixels en largeur et 37 pixels en hauteur.', 1),
(16, 'ICONSIZEPIXEL', 'The icon size should be 32 pixels wide by 37 pixels high.', 2),
(17, 'ICONTRANSFERTDONE', 'Le transfert de l''image a réussi.', 1),
(18, 'ICONTRANSFERTDONE', 'The image transfer was successful.', 2),
(19, 'ICONTRANSFERTFALSE', 'Le transfert a échoué. Veuillez contacter l''administrateur.', 1),
(20, 'ICONTRANSFERTFALSE', 'The transfer failed. Please contact the administrator.', 2),
(21, 'PICTUREPNGGIFJPGJPEG', 'Seules les extensions png, gif, jpg et jpeg sont autorisées.', 1),
(22, 'PICTUREPNGGIFJPGJPEG', 'Only extensions png, gif, jpg and jpeg are allowed.', 2),
(23, 'PICTURESIZE', 'La taille de la photo ne doit pas dépasser 1 Mo !', 1),
(24, 'PICTURESIZE', 'The image size should not exceed 1 MB!', 2),
(25, 'PHOTOTRANSFERTDONE', 'Le transfert de la photo a réussi.', 1),
(26, 'PHOTOTRANSFERTDONE', 'The transfer of the photo was successful.', 2),
(27, 'MADEBYMOOVEATIS', 'Mooveatis', 1),
(28, 'MADEBYMOOVEATIS', 'Mooveatis', 2)"


echo "$cmd_l10n" | mysql -v -u $username -p$pwd $db


echo "################"
echo "# USER - Admin #"
echo "################"
cmd_usertype_base="INSERT INTO users (lib_users, pass_users, num_pole, usertype_id_usertype, language_id_language, territoire_id_territoire, mail_users, nom_users) VALUES "

cmd_usertype="('$admin_login', '$admin_pwd', $admin_num_pole, $admin_usertype, $admin_language, $admin_territoire_id, '$admin_email', '$admin_name')"
echo "$cmd_usertype_base$cmd_usertype" | mysql -v -u $username -p$pwd $db

