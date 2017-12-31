# adbyby 路由版 一键安装管理脚本

适用于 PandoraBox OpenWrt LEDE 固件

请用 Xshell 连接你的路由

安装wget:

    opkg update && opkg install wget

创建相关文件夹（如已经安装adbyby可跳过）

    mkdir /usr/share/adbyby

下载脚本:

    wget --no-check-certificate -O /usr/share/adbyby/adbyby_all_install.sh https://raw.githubusercontent.com/kysdm/adbyby/master/adbyby_all_install.sh

运行脚本:

    sh /usr/share/adbyby/adbyby_all_install.sh