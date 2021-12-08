TARGET_DISABLE_IPACM := false

ifneq ($(TARGET_BOARD_SUFFIX),_au)
#IPACM_DATA
IPACM_DATA += IPACM_cfg.xml
IPACM_DATA += ipacm
IPACM_DATA += ipacm.rc
endif

ifeq ($(TARGET_USES_QMAA),true)
ifneq ($(TARGET_USES_QMAA_OVERRIDE_DATA),true)
	TARGET_DISABLE_IPACM := true
endif #TARGET_USES_QMAA_OVERRIDE_DATA
endif #TARGET_USES_QMAA

BOARD_IPA_LOW_RAM_EXCP_LIST := bengal
BOARD_IPA_LOW_RAM_EXCP_LIST += monaco

ifeq ($(TARGET_HAS_LOW_RAM),true)
ifneq ($(call is-board-platform-in-list,$(BOARD_IPA_LOW_RAM_EXCP_LIST)),true)
	TARGET_DISABLE_IPACM := true
endif
endif

ifneq ($(TARGET_DISABLE_IPACM),true)
BOARD_PLATFORM_LIST := msm8909
BOARD_PLATFORM_LIST += msm8916
BOARD_PLATFORM_LIST += msm8917
BOARD_PLATFORM_LIST += qm215
BOARD_PLATFORM_LIST += msm8937
ifeq ($(TARGET_BOARD_SUFFIX),_au)
BOARD_PLATFORM_LIST += msmnile
endif
BOARD_IPAv3_LIST := msm8998
BOARD_IPAv3_LIST += sdm845
BOARD_IPAv3_LIST += sdm710
BOARD_IPAv3_LIST += $(MSMNILE)
BOARD_IPAv3_LIST += $(KONA)
BOARD_IPAv3_LIST += $(MSMSTEPPE)
BOARD_IPAv3_LIST += $(TRINKET)
BOARD_IPAv3_LIST += $(LITO)
BOARD_IPAv3_LIST += atoll
BOARD_IPAv3_LIST += bengal
BOARD_ETH_BRIDGE_LIST := $(MSMNILE)
BOARD_ETH_BRIDGE_LIST += $(KONA)

ifneq ($(call is-board-platform-in-list,$(BOARD_PLATFORM_LIST)),true)
ifneq (,$(filter $(QCOM_BOARD_PLATFORMS),$(TARGET_BOARD_PLATFORM)))
ifneq (, $(filter aarch64 arm arm64, $(TARGET_ARCH)))

PRODUCT_PACKAGES += $(IPACM_DATA)

endif # $(TARGET_ARCH)
endif
endif
endif
