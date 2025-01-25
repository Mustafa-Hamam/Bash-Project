#! /bin/bash
LC_COLLATE=C
shopt -s extglob

typeset -i tables=0
for i in $(ls $PWD)
    do
    echo "$dbname/$i"
    ((tables++))
    done
echo "Number of tables: " $tables    