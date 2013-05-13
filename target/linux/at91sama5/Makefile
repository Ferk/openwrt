# 
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=at91sama5
MAINTAINER:=Fernando Carmona Varo <fernando.carmona.varo@incloud.de>
BOARDNAME:=Atmel AT91SAMA5
FEATURES:=squashfs jffs2 targz ext2 usb
CFLAGS:=-Os -pipe -march=armv5te -mtune=arm926ej-s -fno-caller-saves

LINUX_VERSION:=3.6.9

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += kmod-usb-ohci

define Kernel/CompileImage
	$(call Kernel/CompileImage/Default)
	+$(MAKE) $(KERNEL_MAKEOPTS) dtbs
endef

$(eval $(call BuildTarget))
