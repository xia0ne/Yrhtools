#!/bin/sh
#Program:
# This is a free, convenient to just use Linux host novice integration shell script .
# Script integration within the script, are from the search engine and major BBS, blog .
# I do not assume any responsibility. Use this script on your behalf to be responsible for your own host .
#��һ����ѵģ������ڶԸո�ʹ��Linux���������ֵģ�����shell�ű���
#���ű������ϵ����нű�������Դ��������͸�����̳�����͡����˲����е��κ����Ρ�ʹ�ñ��ű������Լ������Լ������������Ρ�
#���Ǳ��˵ĵ�һ���ű���BUG��������¡�QQ:1223605525
#History:
#2019/4/29    Yrh      ��ʼ����     V0.1
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#������
mainGNU() {
clear
echo -e "\033[32m===============\033[0m\033[36m Yrh'sV0.1 \033[32m===============\033[0m"
echo -e "���ű�����޸���2019/4/29"
echo -e "����Yrh | www.my-cup.cn.cn \n QQ:1223605525\n\n"
echo -e "${startblue}1${endblue}.VPS���ýű�����"
echo -e "${startblue}2${endblue}.Liunx��һЩ����"
echo -e "${startblue}3${endblue}.��ǿ����һ������"
echo -e "${startblue}4${endblue}.LiunxһЩ�����װ"
echo -e "${startblue}5${endblue}.�˳��ű�"
echo -e "${startblue}6${endblue}.���ű�����\n"
read -p "����������ʹ��:" mainchoice
}
########################################################################�ű�����
script-collection() {
echo -e "\n\033[31m VPS���ýű����� \033[0m\n"
echo -e "\033[47;34m "����"�ű� \033[0m" #���׺���
echo -e "-------------------------------------------"
echo -e "${startblue}1${endblue}.��װħ��BBR�ĺ�һ�ű�(Loc��cx9208����)"
echo -e "${startblue}2${endblue}.һ����װBBR(��ˮ�ݱ����)"
echo -e "-------------------------------------------\n"
echo -e "\033[43;34m "VPS���Խű�" \033[0m" #�Ƶ�����
echo -e "-------------------------------------------"
echo -e "${startblue}3${endblue}.Superbench�ۺ�VPS����(oooldking����)"
echo -e "${startblue}4${endblue}.SpeedTest���ٽű�(Github��sivel����)"
echo -e "${startblue}5${endblue}.UnixBenchһ�������ܷ�(��ˮ�ݱ����)\n"
echo -e "-------------------------------------------\n"
echo -e "${startblue}6${endblue}.������һҳ\n"
read -p "����������ʹ��:" onechoice
}
#L###################################################################Linux��������
lxcommand() {
echo "����"
}
#####################################################################��ǿ��������
richweb() {
echo -e "\n#############\n\033[31m ��ǿ�������� \033\n[0m#############\n"
echo -e "\033[42;34m ����ʹ���� \033[0m"
echo -e "-------------------------------------------"
echo -e "${startblue}1${endblue}.Shadowsocks�ĺ�һ�ű�(��ˮ���)"
echo -e "${startblue}2${endblue}.ShaddowsocksRһ����װ�ű�[���](���ȴ���)"
echo -e "${startblue}3${endblue}.һ����װBrook(���ȴ���)"
echo -e "-------------------------------------------\n"
echo -e "\033[42;34m ���� \033[0m"
echo -e "-------------------------------------------"
echo -e "${startblue}4${endblue}.SSPANEL-V3-ħ��MOD��˶Խ�(�߲�Blog)"
echo -e "${startblue}5${endblue}.Dockerһ���Խ�(�ٷ�)[��˿ڣ���ȷ�����Ѿ���װ��Docker]"
echo -e "-------------------------------------------\n"
echo -e "${startblue}6${endblue}.������һҳ\n"
read -p "����������ʹ��:" twochoice
}
######################################################################Linux���
lxapp() {
echo "����"
}
######################################################����JB����
#####################################���º���
script-update() {
cd $workfile;
wget -N --no-check-certificate http://www.my-cup.cn/tools.sh
}
########################################################################################################��ʼִ������
#############��ɫ����
startblue="\033[36m"
endblue="\033[0m"
#���Ȩ��
[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }
#��ȡ��ǰ�ű�Ŀ¼
workfile=$(pwd)
#�жϲ���������cd���ű�����Ŀ¼
test -d /root/Yrhtools
if [ $? == "1" ]; then {
     mkdir /root/Yrhtools && cd /root/Yrhtools
   }
 else
   {
echo -e "�ű��ļ���λ��/home/Yrhtools"; cd /root/Yrhtools
   }
fi
####################################
#����������
mainGNU
case ${mainchoice} in
  "1")
script-collection
  ;;
  "2")
lxcommand
  ;;
  "3")
richweb
  ;;
  "4")
lxapp
  ;;
  "5")
exit 1
  ;;
  "6")
script-update
  ;;
  *)
  echo -e "\n\033[31m ������1-6�м��һ������ \033[0m\n"
  mainGNU
  ;;
esac
#����VPS���ýű�����
case ${onechoice} in
  "1")#��װħ��BBR�ĺ�һ�ű�
wget "https://github.com/cx9208/Linux-NetSpeed/raw/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
  ;;
  "2")#��ˮbbr
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
  ;;
  "3")#Superbench�ۺ�VPS����
wget https://raw.githubusercontent.com/oooldking/script/master/superbench.sh && chmod +x superbench.sh &&./superbench.sh
  ;;
  "4")#SpeedTest���ٽű�
wget https://raw.github.com/sivel/speedtest-cli/master/speedtest.py && chmod a+rx speedtest.py && python speedtest.py
  ;;
  "5")
wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh
  ;;
  "6")
mainGNU
  ;;
esac
#��ǿ��������
case ${twochoice} in
  "1")#Shadowsocks�ĺ�һ�ű�
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh && chmod +x shadowsocks-all.sh &&./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
  ;;
  "2")#ShaddowsocksRһ����װ�ű�[���](���ȴ���)
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh
  ;;
  "3")#һ����װBrook(���ȴ���)
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/brook.sh && chmod +x brook.sh && bash brook.sh
  ;;
  "4")#SSPANEL-V3ħ��MOD(7COLOR)
wget -N --no-check-certificate https://raw.githubusercontent.com/lizhongnian/ss-panel-v3-mod-node-connect/master/ss-panel-v3-mod-node-connect.sh && chmod +x ss-panel-v3-mod-node-connect.sh && bash ss-panel-v3-mod-node-connect.sh
  ;;
  "5")
  echo -e "����"
  ;;
  "6")
mainGNU
  ;;
esac