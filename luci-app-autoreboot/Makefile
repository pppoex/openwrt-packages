include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-autoreboot
PKG_VERSION=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-autoreboot
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=Auto REBOOT for LuCI
	PKGARCH:=all
endef

define Package/luci-app-autoreboot/description
	This package contains LuCI configuration pages for auto reboot.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-autoreboot/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	
	$(INSTALL_CONF) ./files/root/etc/config/autoreboot $(1)/etc/config/autoreboot
	$(INSTALL_BIN) ./files/root/etc/init.d/autoreboot $(1)/etc/init.d/autoreboot
	$(INSTALL_DATA) ./files/root/usr/lib/lua/luci/model/cbi/autoreboot.lua $(1)/usr/lib/lua/luci/model/cbi/autoreboot.lua
	$(INSTALL_DATA) ./files/root/usr/lib/lua/luci/controller/autoreboot.lua $(1)/usr/lib/lua/luci/controller/autoreboot.lua
endef

$(eval $(call BuildPackage,luci-app-autoreboot))
