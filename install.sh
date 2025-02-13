#!/bin/bash

# 一键网络重装系统脚本
# 支持主流Linux发行版和Windows系统
# 原始脚本来源：MollyLau和bin456789

# 安装依赖
install_dependencies() {
    if command -v yum &>/dev/null; then
        yum install -y wget curl
    elif command -v apt &>/dev/null; then
        apt update
        apt install -y wget curl
    fi
}

# 显示菜单
show_menu() {
    clear
    echo "------------------------"
    echo "请选择要安装的系统："
    echo "1. Debian 12"
    echo "2. Debian 11"
    echo "3. Debian 10"
    echo "4. Debian 9"
    echo "------------------------"
    echo "11. Ubuntu 24.04"
    echo "12. Ubuntu 22.04"
    echo "13. Ubuntu 20.04"
    echo "14. Ubuntu 18.04"
    echo "------------------------"
    echo "21. Rocky Linux 9"
    echo "22. Rocky Linux 8"
    echo "23. AlmaLinux 9"
    echo "24. AlmaLinux 8"
    echo "------------------------"
    echo "31. CentOS 7"
    echo "------------------------"
    echo "41. Windows 11"
    echo "42. Windows 10"
    echo "43. Windows Server 2022"
    echo "44. Windows Server 2019"
    echo "------------------------"
    echo "0. 退出脚本"
    echo "------------------------"
}

# 执行重装
reinstall_system() {
    case $1 in
        1)  # Debian 12
            bash InstallNET.sh -debian 12
            ;;
        2)  # Debian 11
            bash InstallNET.sh -debian 11
            ;;
        3)  # Debian 10
            bash InstallNET.sh -debian 10
            ;;
        4)  # Debian 9
            bash InstallNET.sh -debian 9
            ;;
        11) # Ubuntu 24.04
            bash InstallNET.sh -ubuntu 24.04
            ;;
        12) # Ubuntu 22.04
            bash InstallNET.sh -ubuntu 22.04
            ;;
        13) # Ubuntu 20.04
            bash InstallNET.sh -ubuntu 20.04
            ;;
        14) # Ubuntu 18.04
            bash InstallNET.sh -ubuntu 18.04
            ;;
        21) # Rocky Linux 9
            bash reinstall.sh rocky
            ;;
        22) # Rocky Linux 8
            bash reinstall.sh rocky 8
            ;;
        23) # AlmaLinux 9
            bash reinstall.sh almalinux
            ;;
        24) # AlmaLinux 8
            bash reinstall.sh almalinux 8
            ;;
        31) # CentOS 7
            bash InstallNET.sh -centos 7
            ;;
        41) # Windows 11
            bash InstallNET.sh -windows 11 -lang "cn"
            ;;
        42) # Windows 10
            bash InstallNET.sh -windows 10 -lang "cn"
            ;;
        43) # Windows Server 2022
            curl -O https://massgrave.dev/windows_links.txt
            iso_url=$(grep -oP 'https.*windows_server.*2022.*_x64\.iso' windows_links.txt)
            bash reinstall.sh windows --iso="$iso_url" --image-name='Windows Server 2022'
            ;;
        44) # Windows Server 2019
            bash InstallNET.sh -windows 2019 -lang "cn"
            ;;
        *)
            echo "无效的选择！"
            return 1
            ;;
    esac
}

# 主程序
main() {
    install_dependencies
    
    # 获取安装脚本
    if [ ! -f "InstallNET.sh" ]; then
        wget https://github.com/hostert/s/blob/s/installnet.sh
        chmod +x InstallNET.sh
    fi
    
    if [ ! -f "reinstall.sh" ]; then
        curl -O https://github.com/hostert/s/blob/s/reinstall.sh
        chmod +x reinstall.sh
    fi

    while true; do
        show_menu
        read -p "请输入选项编号: " choice
        case $choice in
            0)
                echo "已退出"
                exit 0
                ;;
            [1-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9])
                echo "------------------------------------------------"
                read -p "警告：本操作会清除所有数据！确认安装吗？(y/n): " confirm
                if [ "$confirm" == "y" ]; then
                    echo "开始重装系统..."
                    reinstall_system $choice
                    reboot
                    exit 0
                else
                    echo "已取消安装"
                fi
                ;;
            *)
                echo "无效的输入，请重新选择！"
                ;;
        esac
        sleep 2
    done
}

# 执行主程序
main
