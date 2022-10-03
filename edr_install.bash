#!/bin/bash 

## Install EDR
PACK_CENT8="falcon-sensor-6.34.0-13108.el8.x86_64.rpm"
PACK_CENT7="falcon-sensor-6.34.0-13108.el7.x86_64.rpm"
OS=$(cat /etc/redhat-release |awk -F"release" '{print $2}'|awk '{print $1}'|cut -c1)
######
if [ "${OS}" == "7" ];then
  echo "Install edr on CentOS 7"
  yum install -y ${PACK_CENT7}
elif [ "${OS}" == "8" ];then 
 echo "install edr on CentOS 8"
  yum install -y ${PACK_CENT8}
else 
  echo "OS not support"
  exit 100 
fi
#####
echo "Configur CrowdStrike CID"
/opt/CrowdStrike/falconctl -s --cid=xxxxxxxxxxxxxxxxxxxxxxx && \
/opt/CrowdStrike/falconctl -s --tags=FalconGroupingTags/DevOps,MonitorMode 

echo "Start Service"
systemctl start falcon-sensor && \
systemctl enable falcon-sensor && \
systemctl status falcon-sensor

echo " All Done!!"

