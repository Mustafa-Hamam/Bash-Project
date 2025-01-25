#! /usr/bin/bash

LC_COLLATE=C #To make the Terminal Case Senstive
shopt -s extglob #Enable Sub Pattern
echo "Available Tables:"
ls $PWD
read -r -p "Enter Table name to Insert Into: "  table #To make / not to be a Escape char
table=$(echo $table | tr ' ' '_')
if [[ $table = [0-9]* ]];then
    echo "Table name can't start with numbers"
    source table.sh
else    
    case $table in
    +([a-z_A-Z0-9]))
    if [ -f $PWD/$table ]; then
    col_=()
    row=()
        
        col_name=($(awk -F : '{for(i=1;i<=NF;i++){if (NR==1){print $i}}}' $PWD/$table))
        dtype=($(awk -F : '{for(i=1;i<=NF;i++){if (NR==2){print $i}}}' $PWD/$table))
        for((i=0;i<${#col_name[@]};i++))
        do
        head -1 $PWD/$table
            read -r -p "Enter column name : " col
            col=$(echo $col | tr ' ' '_')
            if [[ $col = ${col_name[i]} ]]; then
                read -r -p "Insert value : " data
                data=$(echo $data | tr ' ' '_')
                f=$(awk -F : -v val="$data" '{if(val==$1){print 0 }}' $PWD/$table)         
                if [[ $f = 0 ]]; then
                    echo "PK can not be duplicated"
                    break
                fi
                if [[ ${dtype[i]} = 'int' ]]; then
                    case $data in
                        +([0-9]))
                            row+=($data)
                        ;;
                        *)
                            echo "Data Type Error"
                            source table.sh
                    esac
                else
                    case $data in
                        +([a-zA-Z_0-9]))
                            row+=($data)
                        ;;
                        *)
                            echo "Data Type Error"
                            source table.sh
                    esac
                fi
            else
                echo "There is no such Column"
                source table.sh
            fi
        done
    else 
        echo "Table Name Invalid"
    fi
    esac    
           
fi
I_row=$(IFS=:; echo "${row[*]}")
echo "$I_row" >> $PWD/$table

