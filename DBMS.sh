#! /bin/bash
LC_COLLATE=C
shopt -s extglob
export PS3="MMDBMS>>"
PATH=$PATH:$PWD
function check_db_name(){
    if [[ $1 = [0-9]* ]];then
    echo "DataBase name can't start with numbers"
    return 1 
    else    
    case $1 in
    +([a-z_A-Z0-9]))   
        return 0  
    ;;
    *)
     echo "DataBase name can't contain special characters"
        return 1
    esac
    fi    
}

if [[ -d $HOME/.MMDBMS ]];then
    echo "Welcome To MMDBMS..."
else
    mkdir $HOME/.MMDBMS
    echo "MMDBMS now running..."
    sleep 2
fi    

select choice in CreateDB ListDB ConnectDB RemoveDB Exit
    do
    case $REPLY in
    1) 
        read -r -p "Enter DB name: " dbname
        dbname=$(echo $dbname | tr ' ' '_')
        check_db_name $dbname
        if [[ $? == 0 ]];then
            if [[ -d $HOME/.MMDBMS/$dbname ]];then
                echo "DataBase Already Exists"
            else 
                mkdir $HOME/.MMDBMS/$dbname
                sleep 1
                echo "DB $dbname Created Successfully!"
            fi
        fi            
    ;;
    2)
        ls -F $HOME/.MMDBMS | grep '/' | tr '/' ' '
    ;;
    3)
        ls -F $HOME/.MMDBMS | grep '/' | tr '/' ' '
        read -r -p "Enter DB Name to Connect: " dbname
        dbname=$(echo $dbname | tr ' ' '_')
        check_db_name $dbname
        if [[ $? == 0 ]];then
            if [[ -d $HOME/.MMDBMS/$dbname ]];then
                cd $HOME/.MMDBMS/$dbname
                source table.sh $dbname
            else 
                sleep 2
                echo "DB $dbname Doesn't Exist, Please Enter a valid name"
            fi
        fi        
    ;;
    4)
        read -r -p "Enter DB Name to Remove: " dbname
        dbname=$(echo $dbname | tr ' ' '_')
        check_db_name $dbname
        if [[ $? == 0 ]];then
            if [[ -d $HOME/.MMDBMS/$dbname ]];then
                rm -r $HOME/.MMDBMS/$dbname
                sleep 2
                echo "DB $dbname Deleted Successfully"
            else 
                echo "DB $dbname Doesn't Exist, Please Enter a valid name"
            fi
        fi            
    ;;
    5)
        echo "Exiting MMDBMS.."
        sleep 1
        exit 1
    esac
done    







