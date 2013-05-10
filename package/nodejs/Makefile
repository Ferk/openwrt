
include $(TOPDIR)/rules.mk

PKG_NAME:=nodejs
PKG_VERSION:=0.8.22
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/node-v$(PKG_VERSION)
PKG_SOURCE:=node-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://nodejs.org/dist/v$(PKG_VERSION)
PKG_MD5SUM:=9f0e37afdc1e1005363940ada58c5f3d
PKG_CAT:=zcat

PKG_LICENSE:=MIT

PKG_INSTALL=1

include $(INCLUDE_DIR)/package.mk
#include $(INCLUDE_DIR)/host-build.mk


define Package/nodejs
  SECTION:=lang
  CATEGORY:=Languages
  DEFAULT:=y
  TITLE:=Javascript environment
  URL:=http://nodejs.org/
  MAINTAINER:=Fernando Carmona Varo <fernando.carmona.varo@incloud.de>
endef

define Package/nodejs/description
 Event-driven I/O server-side JavaScript environment based on V8.
endef

CONFIGURE_ARGS += --without-snapshot \
	--without-dtrace  \
	--without-etw \
	--dest-cpu=$(ARCH) \
	--dest-os=linux

define Build/Configure
  $(call Build/Configure/Default,$(CONFIGURE_ARGS))
endef

define Build/Compile
  $(MAKE) -C $(PKG_BUILD_DIR) DESTDIR="$(PKG_INSTALL_DIR)" install
endef

$(eval $(call BuildPackage,nodejs))



# #------------------------
# #####

# NODEJS_VERSION = 0.8.22
# NODEJS_SOURCE = node-v$(NODEJS_VERSION).tar.gz
# NODEJS_SITE = http://nodejs.org/dist/v$(NODEJS_VERSION)
# NODEJS_DEPENDENCIES = host-python host-nodejs \
#     $(call qstrip,$(BR2_PACKAGE_NODEJS_MODULES_ADDITIONAL_DEPS))
# HOST_NODEJS_DEPENDENCIES = host-python
# NODEJS_LICENSE = MIT (core code); MIT, Apache and BSD family licenses (Bundled components)
# NODEJS_LICENSE_FILES = LICENSE

# ifeq ($(BR2_PACKAGE_OPENSSL),y)
# 	NODEJS_DEPENDENCIES += openssl
# endif

# define HOST_NODEJS_CONFIGURE_CMDS
# 	# Build with the static, built-in OpenSSL which is supplied as part of
# 	# the nodejs source distribution.  This is needed on the host because
# 	# NPM is non-functional without it, and host-openssl isn't part of
# 	# buildroot.
# 	(cd $(@D); \
#                 ./configure \
# 		--prefix=$(HOST_DIR)/usr \
# 		--without-snapshot \
# 		--without-dtrace \
# 		--without-etw \
# 	)
# endef

# define HOST_NODEJS_BUILD_CMDS
# 	$(HOST_MAKE_ENV) $(MAKE) -C $(@D)
# endef

# define HOST_NODEJS_INSTALL_CMDS
# 	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) install
# endef

# ifeq ($(BR2_i386),y)
# NODEJS_CPU=ia32
# else ifeq ($(BR2_x86_64),y)
# NODEJS_CPU=x64
# else ifeq ($(BR2_arm),y)
# NODEJS_CPU=arm
# # V8 needs to know what floating point ABI the target is using.  There's also
# # a 'hard' option which we're not exposing here at the moment, because
# # buildroot itself doesn't really support it at present.
# ifeq ($(BR2_SOFT_FLOAT),y)
# NODEJS_ARM_FP=soft
# else
# NODEJS_ARM_FP=softfp
# endif
# endif

# define NODEJS_CONFIGURE_CMDS
# 	(cd $(@D); \
# 		$(TARGET_CONFIGURE_OPTS) \
# 		LD="$(TARGET_CXX)" \
# 		./configure \
# 		--prefix=/usr \
# 		--without-snapshot \
# 		$(if $(BR2_PACKAGE_OPENSSL),--shared-openssl,--without-ssl) \
# 		$(if $(BR2_PACKAGE_NODEJS_NPM),,--without-npm) \
# 		--without-dtrace \
# 		--without-etw \
# 		--dest-cpu=$(NODEJS_CPU) \
# 		$(if $(NODEJS_ARM_FP),--with-arm-float-abi=$(NODEJS_ARM_FP)) \
# 		--dest-os=linux \
# 	)
# endef

# define NODEJS_BUILD_CMDS
# 	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
# endef

# #
# # Build the list of modules to install based on the booleans for
# # popular modules, as well as the "additional modules" list.
# #
# NODEJS_MODULES_LIST= $(call qstrip,\
# 	$(if $(BR2_PACKAGE_NODEJS_MODULES_EXPRESS),express) \
# 	$(if $(BR2_PACKAGE_NODEJS_MODULES_COFFEESCRIPT),coffee-script) \
# 	$(BR2_PACKAGE_NODEJS_MODULES_ADDITIONAL))

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

# define NODEJS_INSTALL_TARGET_CMDS
# 	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) DESTDIR=$(TARGET_DIR) install
# 	$(NODEJS_INSTALL_MODULES)
# endef

# # node.js configure is a Python script and does not use autotools
# $(eval $(generic-package))
# $(eval $(host-generic-package))







