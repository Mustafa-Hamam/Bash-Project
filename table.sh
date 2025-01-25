#! /bin/bash
LC_COLLATE=C
shopt -s extglob
export PS3="$1 >>"

select choice in Create_Table List_Table Select_From_Table Drop_Table Delete_From_Table Update_Table Insert_Into_Table Back_to_MMDBMS
    do
    case $REPLY in
    1)
        source Create_Table.sh
    ;;
    2)
        source List_tables.sh

    ;;
    3)
        source Select_table.sh
    ;;
    4)
        source Drop_table.sh
    ;;
    5)
        source Delete.sh

    ;;
    6)
        source Update_Table.sh
    ;;
    7)
        source Insert_Into_Table.sh
    ;;
    8)
        echo "Exiting $dbname.."
        sleep 1
        PS3="MMDBMS>>"    
        source DBMS.sh
    esac

done