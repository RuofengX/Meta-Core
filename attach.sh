#!/bin/bash
caution="Caution: Using Ctrl+P then Ctrl+Q to quit!"
echo "#================================================="
echo -e "\033[41;37m ${caution} \033[0m"
echo "Attaching to meta_core container..."
echo "#================================================="
sudo docker attach --sig-proxy=false meta_core
