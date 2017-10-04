#!/bin/sh
#kysdm(gxk7231@gmail.com)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
export ADBYBY=/usr/share/adbyby
judgment=$(sed -n '1p' $ADBYBY/create_jd.txt)
sh_ver="1.0.4"
rules="https://raw.githubusercontent.com/adbyby/xwhyc-rules/master"

#创建判断文件
if [ ! -e "$ADBYBY/create_jd.txt" ]; then
   touch $ADBYBY/create_jd.txt
   echo "NO" > $ADBYBY/create_jd.txt
fi

#下载规则文件
 echo_date -----------------------------------------------
 echo_date 脚本开始运行
 echo_date 下载规则文件中...

 wget -t3 -T10 --no-check-certificate -O /tmp/lazy.txt $rules/lazy.txt
  if [ "$?" == "0" ]; then
     echo_date 下载lazy文件成功
  else
     echo_date 下载lazy文件失败，连接失败，尝试挂代理后重试
     rm -rf /tmp/lazy.txt
  	 echo_date 脚本结束运行
     exit 0
  fi

 wget -t3 -T10 --no-check-certificate -O /tmp/video.txt $rules/video.txt
  if [ "$?" == "0" ]; then
     echo_date 下载video文件成功
  else
     echo_date 下载lazy文件失败，连接失败，尝试挂代理后重试
     rm -rf /tmp/video.txt
  	 echo_date 脚本结束运行
     exit 0
  fi

#判断是否有更新
 version_lazy_up=$(sed -n '1p' /tmp/lazy.txt | awk -F' ' '{print $3 $4}' | sed 's/-//g' | sed 's/://g')
 version_lazy=$(sed -n '1p' $ADBYBY/data/lazy.txt | awk -F' ' '{print $3 $4}' | sed 's/-//g' | sed 's/://g')
 version_video_up=$(sed -n '1p' /tmp/video.txt | awk -F' ' '{print $3 $4}' | sed 's/-//g' | sed 's/://g')
 version_video=$(sed -n '1p' $ADBYBY/data/video.txt | awk -F' ' '{print $3 $4}' | sed 's/-//g' | sed 's/://g')

 if [ "$version_lazy_up" -le "$version_lazy" ];then
   echo_date 本地lazy规则已经最新，无需更新
    if [ "$version_video_up" -le "$version_video" ];then
       echo_date 本地video规则已经最新，无需更新
       rm -f /tmp/lazy.txt /tmp/video.txt
	     echo_date 脚本结束运行
       exit 0
       else
        if [ "$judgment" == "YES" ]; then
          echo_date 检测到video规则更新，应用规则中...
          chattr -i $ADBYBY/data/video.txt
          cp -f /tmp/video.txt $ADBYBY/data/video.txt
          chattr +i $ADBYBY/data/video.txt
          /etc/init.d/adbyby restart
          rm -f /tmp/lazy.txt /tmp/video.txt
    	  	echo_date 脚本结束运行
          exit 0
        else
          echo_date 检测到video规则更新，应用规则中...
          cp -f /tmp/video.txt $ADBYBY/data/video.txt
          /etc/init.d/adbyby restart
          rm -f /tmp/lazy.txt /tmp/video.txt
    	  	echo_date 脚本结束运行
          exit 0
        fi  
    fi
 else
   if [ "$judgment" == "YES" ]; then
     echo_date 检测到lazy规则更新，应用规则中...
     chattr -i $ADBYBY/data/lazy.txt
     cp -f /tmp/lazy.txt $ADBYBY/data/lazy.txt
     chattr +i $ADBYBY/data/lazy.txt
     if [ "$version_video_up" -le "$version_video" ];then
      echo_date 本地video规则已经最新，无需更新
      rm -f /tmp/lazy.txt /tmp/video.txt
      /etc/init.d/adbyby restart
	    echo_date 脚本结束运行
      exit 0
     else
      echo_date 检测到video规则更新，应用规则中...
      chattr -i $ADBYBY/data/video.txt
      cp -f /tmp/video.txt $ADBYBY/data/video.txt
      chattr +i $ADBYBY/data/video.txt
      /etc/init.d/adbyby restart
      rm -f /tmp/lazy.txt /tmp/video.txt
	    echo_date 脚本结束运行
      exit 0
     fi 
   else
    echo_date 检测到lazy规则更新，应用规则中...
    cp -f /tmp/lazy.txt $ADBYBY/data/lazy.txt
     if [ "$version_video_up" -le "$version_video" ];then
       echo_date 本地video规则已经最新，无需更新
       rm -f /tmp/lazy.txt /tmp/video.txt
       /etc/init.d/adbyby restart
	     echo_date 脚本结束运行
       exit 0
     else
      echo_date 检测到video规则更新，应用规则中...
      cp -f /tmp/video.txt $ADBYBY/data/video.txt
      /etc/init.d/adbyby restart
      rm -f /tmp/lazy.txt /tmp/video.txt
	    echo_date 脚本结束运行
     fi 
   fi 
  fi