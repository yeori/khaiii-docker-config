#!/bin/bash

set -e

if [[ -f .var ]]; then
    . <(grep -v '^#' .var)
fi
: "${kai_img_name:=kai-img}"
: "${kai_con_name:=kai}"

readonly working_dir=$(pwd)
readonly volume_kai=$working_dir/runtime
readonly log_base_fname="base_$(date +%Y%m%d_%H%M%S).log"
readonly log_base_path=$working_dir/log/$log_base_fname

echo "kai_img_name  : $kai_img_name"
echo "kai_con_name  : $kai_con_name"
echo "volume_kai    : $volume_kai"
echo "log_base_fname: $log_base_fname"
echo "log_base_path : $log_base_path"


ok() {
    local msg=$1
    echo -e "[\e[32mOK  \e[0m] $msg"
}
step() {
    echo -e "\n[\e[35mSTEP\e[0m] $1"
}
scaffolding() {
    mkdir -p "$working_dir/log"
    touch $log_base_path
}
reset_volume() {
    local tmp_dir=$(mktemp -d)
    if [[ -d $volume_kai ]]; then
        cp runtime/run.py $tmp_dir
        rm -rf $volume_kai
        mkdir -p $volume_kai
        cp -r $tmp_dir/* $volume_kai
    fi
}
remove_container() {
    step "checking existing container... $kai_con_name"
    local container_id=$(docker ps -a -q -f name="^${kai_con_name}$")
    if [[ -n "$container_id" ]]; then
        echo "Container '$kai_con_name' found. Removing it..."
        reset_volume
        docker rm -f $kai_con_name
        echo "Container [$kai_con_name] has been removed."
    fi
}

download_repo() {
    step "downloading khaii repo..."
    if [[ -d khaiii ]]; then
        ok "khaiii repo already exists. skipping..."
    else
        git clone https://github.com/kakao/khaiii.git
        ok "repo downloaded"
    fi
    
}
build_khaii() {
    step "building image $kai_img_name...(it takes several minutes)"
    docker build -t $kai_img_name .
    ok "docker image [\033[0;32m$kai_img_name\033[0m] created"    
}
run_khaii() {
    step "running container $kai_con_name..."
    remove_container
    docker run \
        -itd --name $kai_con_name \
        --mount type=bind,source=$volume_kai,target=/ws \
        $kai_img_name
    ok "container created and running [\033[0;32m$kai_con_name\033[0m]"
    docker exec $kai_con_name cat install.log >> $log_base_path
}
scaffolding
download_repo
build_khaii
run_khaii