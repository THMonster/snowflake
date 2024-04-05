{ pkgs, lib }:

let
  kernelConfig = with lib.kernel; {
    PWM_GPIO = no;
    ROCKCHIP_MINIDUMP = no;
    DRM_PANEL_FRIENDLYELEC = no;
    MALI400 = no;
    MALI_MIDGARD = no;
    MALI_BIFROST = no;
    RK628_MISC = no;
    LT7911D_FB_NOTIFIER = no;
    DMABUF_HEAPS = no;
    BCMDHD = no;
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
  };
in (
  pkgs.linuxKernel.kernels.linux_6_1.override {
    argsOverride = {
      src = fetchTree {
        shallow = true;
        type = "git";
        url = "https://github.com/friendlyarm/kernel-rockchip";
        ref = "nanopi6-v6.1.y";
        rev = "18fd1215fee01daef16b6ced1c0c3c3b83a4d8df";
      };
      defconfig = "nanopi5_linux_defconfig";
      version = "6.1.25";
      modDirVersion = "6.1.25";
      # autoModules = false;
    };
    structuredExtraConfig = kernelConfig;
  }
)
