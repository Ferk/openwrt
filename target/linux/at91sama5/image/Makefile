# 
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/Clean
	$(MAKE) -C u-boot clean
endef

define Build/Compile
	if [ $(CONFIG_AT91_UBOOT) ]; then \
		$(MAKE) -C u-boot compile; \
	fi
endef

define Image/Prepare
	cp $(LINUX_DIR)/arch/arm/boot/zImage $(KDIR)/zImage
endef

define MkuImageDtb
	cat $(KDIR)/zImage $(LINUX_DIR)/arch/arm/boot/$(2).dtb > $(KDIR)/zImage-$(1)
	mkimage -A arm -T kernel -C none -a 0x20008000 -e 0x20008000 \
		-n "OpenWrt ARM $(LINUX_VERSION)" \
		-d $(KDIR)/zImage-$(1) $(BIN_DIR)/$(IMG_PREFIX)-$(1)-uImage
endef

# Atmel
Image/Build/Kernel/AT91SAMA5D31EK=$(call MkuImageDtb,sama5d31ek,sama5d31ek)

define Image/Build/Kernel/Default
	$(call Image/Build/Kernel/AT91SAMA5D31EK)
endef

define Image/BuildKernel
	mkimage -A arm -T kernel -C none -a 0x20008000 -e 0x20008000 -n linux-2.6 \
		-d $(LINUX_DIR)/arch/arm/boot/Image $(BIN_DIR)/uImage
	cp $(KDIR)/zImage* $(BIN_DIR)/
	if [ $(CONFIG_FLEXIBITY_ROOT) ]; then \
		$(INSTALL_BIN) $(BIN_DIR)/uImage $(TARGET_DIR)/uImage ; \
	fi
	$(call Image/Build/Kernel/$(PROFILE))
endef

define Image/Build
	$(call Image/Build/$(1))
	cp $(KDIR)/root.$(1) $(BIN_DIR)/$(IMG_PREFIX)-root.$(1)
endef

$(eval $(call BuildImage))
