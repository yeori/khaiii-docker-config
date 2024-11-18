#!/bin/bash

if [ -f ".var" ]; then
    echo ".var exists"
else
    cat << EOF > .var
# name of docker image of khaiii
# (optional) default "kai-img"
kai_img_name=kai-img
# name of docker container created from ${kai_img_name}
# (optional) default "kai"
kai_con_name=kai
EOF
fi


