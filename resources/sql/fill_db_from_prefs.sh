#!/bin/bash

username="velobs"
pwd="velobs"
db="velobs"

mysql -u $username -p$pwd -e 'show databases;'

# mysql -u $username -p$pwd $db -sNe 'show tables'

prefs_file=/var/www/velobs/resources/prefs/velobs.prefs

source $prefs_file
echo $zoom

#sql_script=13_status_fill.sql


#############
# CONFIGMAP #
#############
echo "INSERT INTO configmap (lat_configmap, lon_configmap, zoom_configmap) VALUES ('$lat', '$lon', '$zoom')" | mysql -v -u $username -p$pwd $db



###############
# TERRITORIES #
###############
cmd_ter_base="INSERT INTO territoire (id_territoire, lib_territoire, type_territoire, ids_territoire) VALUES "
cmd_ter_0="(0, '$ter_0_lib', $ter_0_type, '$ter_0_ids')"
cmd_ter_1="(1, '$ter_1_lib', $ter_1_type, '$ter_1_ids')"
cmd_ter_2="(2, '$ter_2_lib', $ter_2_type, '$ter_2_ids')"
cmd_ter_3="(3, '$ter_2_lib', $ter_3_type, '$ter_3_ids')"

echo "$cmd_ter_base$cmd_ter_0" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_1" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_2" | mysql -v -u $username -p$pwd $db
echo "$cmd_ter_base$cmd_ter_3" | mysql -v -u $username -p$pwd $db




#############
# USERTYPE #
#############
cmd_usertype_base="INSERT INTO usertype (id_usertype, lib_usertype) VALUES "
cmd_usertype_1="('$usertype_1_id', '$usertype_1_lib')"
cmd_usertype_2="('$usertype_2_id', '$usertype_2_lib')"
cmd_usertype_3="('$usertype_3_id', '$usertype_3_lib')"
cmd_usertype_4="('$usertype_4_id', '$usertype_4_lib')"

echo "$cmd_usertype_base$cmd_usertype_1" | mysql -v -u $username -p$pwd $db
echo "$cmd_usertype_base$cmd_usertype_2" | mysql -v -u $username -p$pwd $db
echo "$cmd_usertype_base$cmd_usertype_3" | mysql -v -u $username -p$pwd $db
echo "$cmd_usertype_base$cmd_usertype_4" | mysql -v -u $username -p$pwd $db