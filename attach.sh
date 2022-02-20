#!/bin/bash
caution="警告Caution: 使用Using Ctrl+P 之后then Ctrl+Q 来to 退出quit!"
echo "#================================================="
echo -e "\033[41;37m ${caution} \033[0m"
echo "Attaching to meta_core container..."
echo "#================================================="
sudo docker attach --sig-proxy=false meta_core
