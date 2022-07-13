{ modulesPath, config, lib, pkgs, ... }:

{
  imports =
    [ "${modulesPath}/installer/scan/not-detected.nix"
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "mitigations=off" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/14b5b22f-6cd2-4da5-a9a5-6ee74b76509d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7D69-81E5";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/257c5761-567e-4a13-8d83-2988bc27321b"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  # This can be removed when the default kernel is at least version 5.6
  # https://github.com/NixOS/nixpkgs/pull/86168
  # boot.kernelPackages = lib.mkIf
  #  (lib.versionOlder pkgs.linux.version "5.6")
  #  (lib.mkDefault pkgs.linuxPackages_5_6);

  # This can be removed when PulseAudio is at least version 14
  # https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_7)#Audio
  hardware.pulseaudio.extraConfig = ''
    load-module module-alsa-sink   device=hw:0,0 channels=4
    load-module module-alsa-source device=hw:0,6 channels=4
  '';
}
