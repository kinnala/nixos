{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  networking.hostName = "tunkki";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # networking.firewall.allowedTCPPortRanges = [
  #   { from = 5000; to = 5003; }
  # ];
  # networking.firewall.allowedUDPPortRanges = [
  #   { from = 5000; to = 5003; }
  # ];

  i18n.defaultLocale = "fi_FI.UTF-8";
  time.timeZone = "Europe/Helsinki";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "fi";
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # services.printing.enable = true;
  # services.printing.drivers = [ pkgs.gutenprint ];
  
  users.users.tom = {
    isNormalUser = true;
    home = "/home/tom";
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" ];
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  system.stateVersion = "20.09";

  environment.systemPackages = with pkgs; [
    wget
    vim
    bash
    gnupg
    ripgrep
    htop
    gnumake
    xclip
    git
    tmux
    dropbox-cli
    # google-chrome
    tree
    pass
    pinentry
    docker-compose
    unzip
    zip
    vlc
    texlive.combined.scheme-full
    conda
    gimp
    inkscape
    paraview
    imagemagick
    ffmpeg
    gphoto2
    thunderbird
    emacs
    firefox
    keepassxc
    duplicity
  ];
  programs.gnupg.agent.enable = true;
  programs.geary.enable = false;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
