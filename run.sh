red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
purple(){
    echo -e "\033[35m\033[01m$1\033[0m"
}

# cài đặt aapanel quốc tế
function aapanelgoc(){
yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh aapanel
red "Đã cài đặt thành công aaPanel"
}

# cài đặt bản aapanel bản tàu khựa
function aapanelTQ(){  
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh
red "Đã cài đặt aaPanel bản Trung thành công"
}

# bẻ khoá aapanel bản hiện tại
function panelcrack(){  
bash <(curl -Ls https://raw.githubusercontent.com/zeronxdev/tool/main/crack.sh)
red "Đã crack aaPanel xong, vui lòng login lại aaPanel"
}
# mở chặn speedtest
function unspeedtest(){
systemctl stop netfilter-persistent    
systemctl disable netfilter-persistent    
iptables -F && clear && echo "Đã mở khoá speedtest !"
cd /etc/iptables
rm rules.v4 rules.v6
}



# gỡ cài đặt aapanel
function uninstall(){
service bt stop && chkconfig --del bt && rm -f /etc/init.d/bt && rm -rf /www/server/panel
red "Gỡ cài đặt hoàn tất"
}

# giới hạn tốc độ băng thông
function limit(){
sudo apt-get update
sudo apt-get install iproute2
sudo tc qdisc add dev eth0 root tbf rate 100mbit burst 128kbit latency 200ms
green "Thiết lập giới hạn tốc độ băng thông (100Mbps) thành công!"
}
# xóa giới hạn tốc độ băng thông
function unlimit(){
sudo tc qdisc del dev eth0 root
green "Xóa giới hạn tốc độ băng thông thành công!"
}
# chặn speedtest
function blockspeshowspeed   
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "Vui lòng nhập đúng số"
            start_menu
        ;;
    esac
}
start_menu "first"
