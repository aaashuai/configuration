#!/bin/bash


karabinerConfigPath=/Users/lin/.config/karabiner/assets/complex_modifications
if [[ ! -d  "$karabinerConfigPath" ]]
then
    echo 'path not exist, exit'
    exit 1
fi

for i in $(ls |grep .json)
do 
    echo ln -s $(pwd)/${i} ${karabinerConfigPath}/${i}

    ln -s $(pwd)/${i} ${karabinerConfigPath}/${i}
done

echo done
exit 0
