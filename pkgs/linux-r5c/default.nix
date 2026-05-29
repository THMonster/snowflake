{ pkgs }:

pkgs.linuxPackages_6_18.extend (
	final: prev: {
		kernel = (prev.kernel.override {
			kernelPatches =	prev.kernel.kernelPatches ++ [
				{
					name = "phy-rockchip-snps-pcie3-rk3568-update-fw-when-init";
					patch = ./patches/700-phy-rockchip-snps-pcie3-rk3568-update-fw-when-init.patch;
				}
			];
		}).overrideAttrs (old: {
			postPatch = (old.postPatch or "") + ''
				cp ${./files/drivers/phy/rockchip/p3phy.fw} drivers/phy/rockchip/p3phy.fw
			'';
		});
	}
)

