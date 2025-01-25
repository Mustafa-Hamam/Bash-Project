#! /bin/bash
LC_COLLATE=C
shopt -s extglob
echo "Available Tables:"
ls $PWD
read -r -p "Enter Table Name to Drop: " drptab
drptab=$(echo $drptab | tr ' ' '_')
if [[ $drptab = [0-9]* ]];then
    echo "Invalid Input: Table name can't start with numbers"
    source table.sh
else    
    case $drptab in
    +([a-z_A-Z0-9]))
        if [[ -f $drptab ]];then
            rm $PWD/$drptab
            echo "Table Dropped Successfully"
        else 
            echo "Invalid Table Name"    
        fi    
    ;;
    *)
    echo "Invalid Input: Table name can't contain special characters"
    source table.sh
    esac
fi