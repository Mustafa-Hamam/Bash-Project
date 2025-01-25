#! /bin/bash
LC_COLLATE=C
shopt -s extglob

echo "Available Tables:"
ls $PWD
read -r -p "Enter Table Name to Select From: " table
table=$(echo $table | tr ' ' '_')
if [[ $table = [0-9]* ]];then
    echo "Table name can't start with numbers"
    source table.sh
else    
    case $table in
    +([a-z_A-Z0-9]))
        if [[ -f $PWD/$table ]];then
        select choice in Select_all Select_column Back
        do
            case $REPLY in
            1)
            cat $PWD/$table
            ;;
            2)
            head -1 $PWD/$table
            read -r -p "Enter Column Name: " col
            col=$(echo $col | tr ' ' '_')
                case $col in
                +([a-z_A-Z]))
                awk -F: -v column="$col" '
                NR == 1 {
                    for (i = 1; i <= NF; i++) {
                    if ($i == column) {
                    col_index = i
                    break
                        }
                            }
                    if (!col_index) {
                        print "Error: Column not found." 
                        exit 1        
                                }
                            }
                NR > 1 {
                        print $col_index
                        }' "$PWD/$table"
                ;;
                *)
                    echo "Invalid Column Name."
                    source table.sh
                esac            
            ;;
            3)
                source table.sh        
            
            esac        
        done                
        fi    
    ;;
    *)
    echo "Table name can't contain special characters"
    esac
fi
