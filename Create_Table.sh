#! /bin/bash
LC_COLLATE=C
shopt -s extglob

read -r -p "Enter Table Name: " tabname
tabname=$(echo $tabname | tr ' ' '_')
if [[ $tabname = [0-9]* ]];then
    echo "Table name can't start with numbers"
    source table.sh
else    
    case $tabname in
    +([a-z_A-Z0-9]))
        if [[ -f $tabname ]];then
            echo "Table already exists"
        else    
            touch $PWD/$tabname 
            chmod u+x $PWD/$tabname
            sleep 1
            echo "Table $tabname Created Successfully"
        fi    
    ;;
    *)
    echo "Table name can't contain special characters"
    source table.sh
    esac
fi
row1=()
row2=()
echo "Enter Column Names and Data Types, First Column is Primary Key (type 'done' when finished): "
input='y'
while [ $input = 'y' ]
    do
    read -r -p "Enter Column Name: " colname
    colname=$(echo $colname | tr ' ' '_')
    if [[ $colname == "done" ]]; then
        break
    else
    case $colname in
    +([a-z_A-Z]))
    row1+=("$colname")
    esac
    fi
    read -r -p "Enter Data Type: " dtype
    dtype=$(echo $dtype | tr ' ' '_')
    if [[ $dtype == "done" ]]; then
        break
    else
    case $dtype in
    +([a-z_A-Z]))
    row2+=("$dtype")
    esac
    fi
    read -r -p "Press y yo Insert another Column: " input
    done
row1_str=$(IFS=:; echo "${row1[*]}")
row2_str=$(IFS=:; echo "${row2[*]}")
echo "$row1_str" >> $PWD/$tabname
echo "$row2_str" >> $PWD/$tabname


