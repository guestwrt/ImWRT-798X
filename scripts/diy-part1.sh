#!/bin/bash
# diy-part1.sh 或 diy-part2.sh

cd $OPENWRT_DIR  # 假设 workflow 已 cd 到 openwrt，或用绝对路径 /workdir/openwrt

# Patch mtwifi-cfg Makefile：移除对 l1dat 和 l1util 的安装
sed -i '/l1dat/d' package/mtwifi-cfg/Makefile
sed -i '/l1util/d' package/mtwifi-cfg/Makefile

# 或者更精确，只注释或删除 INSTALL_BIN 行（如果 sed 不够准，可用 patch 文件）
# 推荐：用 patch 方式更可靠
cat > mtwifi-cfg-no-l1.patch << 'EOF'
--- a/package/mtwifi-cfg/Makefile
+++ b/package/mtwifi-cfg/Makefile
@@ -XX,8 +XX,6 @@ define Package/mtwifi-cfg/install
 	$(INSTALL_DIR) $(1)/sbin
 	# ... 其他行
-	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sbin/l1dat $(1)/sbin/l1dat
-	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sbin/l1util $(1)/sbin/l1util
 	# ... 其他行
 endef
EOF

# 应用 patch（忽略行号失败）
patch -p1 -N -r - --no-backup-if-mismatch < mtwifi-cfg-no-l1.patch || true
rm -f mtwifi-cfg-no-l1.patch
