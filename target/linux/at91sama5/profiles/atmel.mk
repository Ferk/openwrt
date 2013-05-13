#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#


define Profile/AT91SAMA5D31EK
	NAME:=Atmel AT91SAMA5D31-EK
endef
define Profile/AT91SAMA5D31EK/Description
	Atmel AT91SAMA5D31-EK eval board
endef
$(eval $(call Profile,AT91SAMA5D31EK))

