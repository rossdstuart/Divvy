for line in $(cat lat_long.csv ) 
    do 
        HOOD=$(curl --silent http://boundaries.tribapps.com/1.0/boundary/\?contains\=$(echo $line | awk -F, '{print $4","$3}')\&sets\=community-areas | jq '.objects[] | .name')
        echo "$line,$HOOD" >> hoods2.csv
        echo "$line,$HOOD"
        sleep 5
done 