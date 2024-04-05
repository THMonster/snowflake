{ lib, stdenv, buildLinux, ... } @ args:

let
  kernelConfig = with lib.kernel; {
    BCMDHD = no;
    PWM_GPIO = no;
    ROCKCHIP_MINIDUMP = no;
    DRM_PANEL_FRIENDLYELEC = no;
    MALI400 = no;
    MALI_MIDGARD = no;
    MALI_BIFROST = no;
    RK628_MISC = no;
    LT7911D_FB_NOTIFIER = no;
    DMABUF_HEAPS = no;
    INPUT_TOUCHSCREEN = no;
    VIDEO_NVP6158 = no;
    CAN_ROCKCHIP = no;
    CANFD_ROCKCHIP = no;
    STMMAC_ETH = no;
    VIDEO_TECHPOINT = no;
    VIDEO_DEV = no;
    NVMEM_RK628_EFUSE = no;
    NVMEM_ROCKCHIP_SEC_OTP = no;
    RK_FLASH = no;
    RK_NAND = no;
    COMPASS_DEVICE = no;
    # CM3232 = no;
    LIGHT_DEVICE = no;
    # DMARD10 = no;
    GSENSOR_DEVICE = no;
    # INPUT_KXTJ9 = no;
    # MC3230 = no;
    ROCKCHIP_IOMUX = no;
    ROCKCHIP_HW_DECOMPRESS_USER = no;
    ROCKCHIP_RGA = no;
    RK_CMA_PROCFS = no;
    RK_DMABUF_PROCFS = no;
    CPU_FREQ_GOV_INTERACTIVE = no;
    LEDS_RGB13H = no;
    PHY_ROCKCHIP_SAMSUNG_DCPHY = no;
  };
in
buildLinux (args // rec {
    src = fetchTree {
      shallow = true;
      type = "git";
      url = "https://github.com/friendlyarm/kernel-rockchip";
      ref = "nanopi6-v6.1.y";
      rev = "18fd1215fee01daef16b6ced1c0c3c3b83a4d8df";
    };
    structuredExtraConfig = kernelConfig;
    ignoreConfigErrors = true;
    defconfig = "nanopi5_linux_defconfig";
    version = "6.1.25";
    modDirVersion = "6.1.25";
    # autoModules = false;

} // (args.argsOverride or { }))
