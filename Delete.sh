#! /bin/bash
LC_COLLATE=C
shopt -s extglob
echo "Available Tables:"
ls $PWD
read -r -p "Enter Table Name to Delete From: " table
table=$(echo $table | tr ' ' '_')
if [[ $table = [0-9]* ]];then
    echo "Table name can't start with numbers"
else    
    case $table in
    +([a-z_A-Z0-9]))
        if [[ -f $PWD/$table ]];then
        select choice in DeleteAll DeleteByColumn Back
        do
        case $choice in
        DeleteAll)
            sed -i '3,$d' $PWD/$table
            echo "The table values have been deleted"
        ;;
        DeleteByColumn)
            head -1 $PWD/$table
            read -r -p "Enter column name : "  col
            col=$(echo $col | tr ' ' '_')
            head -1 $PWD/$table | grep $col > /dev/null
            if [ $? != 0 ]; then
                echo "Invalid Column Name"
                source table.sh
            fi
            read -r -p "Enter value to be deleted : "  val
            second_line=$(sed -n '2p' "$PWD/$table")
            if [[ $second_line == *"$val"* ]]; then
                echo "Cannot Delete Data Types"
                break
            fi              
            n=$(awk -F : -v column=$col '{for(i=1;i<=NF;i++){if($i==column) {print i}}}' $PWD/$table)
            cut -d : -f $n  $PWD/$table | grep $val > /dev/null
            if [ $? != 0 ]; then
                echo "Value Error"
                source table.sh
            fi  
            row=$(awk -F : -v value="$val" -v num=$n '{for(i=1;i<=NF;i++){if($i==value && i==num) {print $0}}}' $PWD/$table)
            if [ -n $row ]; then
                sed -i '/'$row'/d' $PWD/$table
                echo "The value: $val has been deleted"
                cat $PWD/$table
            else
                echo "Value Error"
            fi    
        ;;
        Back)
            source table.sh
        esac
        done
        fi    
    ;;
    *)
    echo "Invalid Choice"
    source table.sh
    esac
fi