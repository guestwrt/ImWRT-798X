#!/bin/bash
# diy-part1.sh

cd $OPENWRT_DIR  # /workdir/openwrt

# 方案：从 mtwifi-cfg 的安装函数中移除 l1dat 和 l1util
# 这些文件由 l1util 包提供

if [ -f package/mtwifi-cfg/Makefile ]; then
  # 方法1：直接注释掉相关行
  sed -i '/INSTALL_BIN.*l1dat/s/^/# /' package/mtwifi-cfg/Makefile
  sed -i '/INSTALL_BIN.*l1util/s/^/# /' package/mtwifi-cfg/Makefile
  
  # 方法2：如果需要删除整行
  # sed -i '/l1dat\|l1util/d' package/mtwifi-cfg/Makefile
fi
