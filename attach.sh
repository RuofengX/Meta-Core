#!/bin/bash
caution="警告：使用 Ctrl+P 之后 Ctrl+Q 来 退出!"
echo "#================================================="
echo -e "\033[41;37m ${caution} \033[0m"
echo "Attaching to meta_core container..."
echo "#================================================="
sudo docker attach --sig-proxy=false meta_core
