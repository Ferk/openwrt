
include $(TOPDIR)/rules.mk

PKG_NAME:=nodejs
PKG_VERSION:=0.8.22
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/node-v$(PKG_VERSION)
PKG_SOURCE:=node-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://nodejs.org/dist/v$(PKG_VERSION)/
PKG_MD5SUM:=9f0e37afdc1e1005363940ada58c5f3d
PKG_CAT:=zcat

PKG_LICENSE:=MIT (core code); MIT, Apache and BSD family licenses (Bundled components)
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
#include $(INCLUDE_DIR)/host-build.mk

define Package/nodejs
  SECTION:=lang
  CATEGORY:=Languages
  DEFAULT:=y
  TITLE:=Javascript environment
  URL:=http://nodejs.org/
  DEPENDS:=+libpthread +librt +libstdcpp
# HOST_NODEJS_DEPENDENCIES = host-python
endef

define Package/nodejs/description
 Event-driven I/O server-side JavaScript environment based on V8.
endef

define Package/npm
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Nodejs Package Manager
  URL:=http://nodejs.org/
  DEPENDS:=nodejs
endef

define Package/npm/description
 Nodejs Package Manager
endef

PKG_INSTALL=1

ifeq ($(ARCH),i386)
  NODEJS_CPU=ia32
else ifeq ($(ARCH),x86_64)
  NODEJS_CPU=x64
else ifeq ($(ARCH),arm)
  NODEJS_CPU=arm
  # V8 needs to know what floating point ABI the target is using.  There's also
  # a 'hard' option which we're not exposing here at the moment, because
  # buildroot itself doesn't really support it at present.
  ifeq ($(HAS_FPU),y)
    NODEJS_ARM_FP=soft
  else
    NODEJS_ARM_FP=softfp
  endif
endif

# need to override the whole CONFIGURE_ARGS, since it's not autotools, but a custom python script
CONFIGURE_ARGS = \
	--prefix=/usr \
	--without-snapshot \
	--without-dtrace  \
	--without-etw \
	--dest-cpu=$(ARCH) \
	$(if $(CONFIG_PACKAGE_libopenssl),--shared-openssl,--without-ssl) \
	$(if $(CONFIG_PACKAGE_npm),,--without-npm) \
	$(if $(NODEJS_ARM_FP),--with-arm-float-abi=$(NODEJS_ARM_FP)) \
	--dest-os=linux

# for some reason this newer ld for arm does not have -rpath option (or at least they aren't taking) so go to g++
TARGET_CONFIGURE_OPTS += \
	LD=$(TARGET_CROSS)g++

define Build/Configure
	$(call Build/Configure/Default,$(CONFIGURE_ARGS))
endef

define Build/Compile
	$(call Build/Compile/Default)
endef

define Package/nodejs/install
	#$(call Build/Install/Default)
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/node $(1)/usr/bin/
endef


define Package/npm/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/npm $(1)/usr/bin/
endef

#
# Build the list of modules to install based on the booleans for
# popular modules, as well as the "additional modules" list.
#
NODEJS_MODULES_LIST= $(call qstrip,\
	$(if $(CONFIG_PACKAGE_nodejs_modules_express),express) \
	$(if $(CONFIG_PACKAGE_nodejs_modules_semaphore),semaphore) \
	$(if $(CONFIG_PACKAGE_nodejs_modules_sqlite3),sqlite3) \
	$(if $(CONFIG_PACKAGE_nodejs_modules_imagemagick),imagemagick) \
	$(if $(CONFIG_PACKAGE_nodejs_modules_locale),locale) \
	$(if $(CONFIG_PACKAGE_nodejs_modules_request),request) \
	$(if $(CONFIG_PACKAGE_nodejs_modules_forever),forever) \
	$(if $(CONFIG_PACKAGE_nodejs_modules_coffeescript),coffee-script) \
	$(CONFIG_PACKAGE_NODEJS_MODULES_ADDITIONAL))

# #
# # We can only call NPM if there's something to install.
# #
# ifneq ($(NODEJS_MODULES_LIST),)
# define NODEJS_INSTALL_MODULES
# 	# If you're having trouble with module installation, adding -d to the
# 	# npm install call below and setting npm_config_rollback=false can both
# 	# help in diagnosing the problem.
# 	(cd $(TARGET_DIR)/usr/lib && mkdir -p node_modules && \
# 		$(TARGET_CONFIGURE_OPTS) \
# 		LD="$(TARGET_CXX)" \
# 		npm_config_arch=$(NODEJS_CPU) \
# 		npm_config_nodedir=$(BUILD_DIR)/nodejs-$(NODEJS_VERSION) \
# 		$(HOST_DIR)/usr/bin/npm install \
# 		$(NODEJS_MODULES_LIST) \
# 	)
# endef
# endif


$(eval $(call BuildPackage,nodejs))

