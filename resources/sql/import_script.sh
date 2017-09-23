#!/bin/bash

username="velobs"
pwd="velobs"
db="velobs"

mysql -u $username -p$pwd -e 'show databases;'

mysql -u $username -p$pwd $db -sNe 'show tables'

FILES=*.sql
for file in $FILES
do
        echo Processing $file...
        mysql -u $username -p$pwd $db -sNe "source $file"
        echo Finished processing $file...
done
     
 mysql -u $username -p$pwd $db -sNe 'show tables'