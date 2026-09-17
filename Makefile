TARGET := iphone:clang:latest:17.0
ARCHS := arm64
INSTALL_TARGET_PROCESSES = Facebook
THEOS_PACKAGE_SCHEME ?= rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FBAudioFix
FBAudioFix_FILES = Tweak.xm
FBAudioFix_FRAMEWORKS = Foundation AVFoundation UIKit
FBAudioFix_CFLAGS = -fobjc-arc -Wall -Wextra -Werror

include $(THEOS_MAKE_PATH)/tweak.mk
