#!/bin/bash

username="velobs"
pwd="velobs"
db="velobs"

prefs_file=/var/www/velobs/resources/prefs/velobs.prefs
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
cmd_ter_3="(3, '$ter_2_lib', $ter_3_type, '$ter_3_ids')"

echo "$cmd_ter_base$cmd_ter_0" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_1" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_2" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_3" | mysql -v -u $username -p$pwd $db

cmd_usertype_base="INSERT INTO usertype (id_usertype, lib_usertype) VALUES "



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
echo "# PRIORITE #"
echo "############"
cmd_prio_base="INSERT INTO priorite (id_priorite, lib_priorite) VALUES "

# ${!array[@]} is the list of all the indexes set in the array
for i in ${!prio_list[@]}; do
	cmd_prio="($i, '${prio_list[$i]}')"
	# echo "$cmd_prio_base$cmd_prio"
	echo "$cmd_prio_base$cmd_prio" | mysql -v -u $username -p$pwd $db
done







