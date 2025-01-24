#! /bin/bash

LC_COLLATE=C #To make the Terminal Case Senstive
shopt -s extglob #Enable Sub Pattern
echo "Available Tables:"
ls $PWD
read -r -p "Enter Table name : "  table #To make / not to be a Escape char
if [ ! -f $table ]; then
    echo "Table doesn't exist.."
    source table.sh
else
    select choice in UpdateAll Update_Specific_row Exit
    do
        case $choice in 
            UpdateAll)
                
                read -r -p "Enter value to update: " val
                read -r -p "Enter the update: " up
                flag=$(awk -F : -v value="$val" 'BEGIN{f=1}{for(i=1;i<=NF;i++){if(value==$i){f=0}}}END{print f}' $PWD/$table)                
                if [[ $flag = 0 ]]; then
                    sed -i 's/'$val'/'$up'/g' $PWD/$table
                    echo "done"
                else
                    echo "the value you want to replace do not exist"
                fi
            ;;
            Update_Specific_row)
                read -r -p "Enter the PK of the row : " pk
                read -r -p "Enter value to update: " val
                read -r -p "Enter the update: " up
                row=$(awk -F : -v primaryk=$pk '{if($1==primaryk){print NR}}' $PWD/$table)
                flag=$(awk -F : -v value="$val" 'BEGIN{f=1}{for(i=1;i<=NF;i++){if(value==$i){f=0}}}END{print f}' $PWD/$table)
                if [[ -n $row  ]]; then
                    if [[ $flag = 0 ]]; then
                        sed -i ""$row"s/$val/$up/g" $PWD/$table
                    else
                        echo "There is no such value"
                    fi
                else
                    echo "Not valid PK"
                fi
            ;;
            Exit)
                break
            ;;
            *)
                echo "Not a valid choice"
                source table.sh
            ;;
        esac
    done
fi