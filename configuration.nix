{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  networking.hostName = "tunkki";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # networking.firewall.allowedTCPPortRanges = [
  #   { from = 3389; to = 3390; }
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

  # services.openssh = {
  #   enable = true;
  #   passwordAuthentication = false;
  #   kbdInteractiveAuthentication = false;
  #   ports = [ 20022 ];
  # };

  # services.printing.enable = true;
  # services.printing.drivers = [ pkgs.gutenprint ];
  
  users.users.tom = {
    isNormalUser = true;
    home = "/home/tom";
    extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" ];
    # openssh.authorizedKeys.keys = [
    #   "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDP7ayrJK6zml2w7g5Xenk/BvrrjrcouNMeX+I2bbICrNqlN8znry5o/aesn0l2shAk0fibe85HPF+WPur+SSf1BauLDPo3rchTADi3vO/ZZUt3NSsdaE3D2x66jucv+aD9lkp+mrzvikREC0zRB6aSErGCUJ7qJU03T8Ckt7C5a3yhWMlu8znJWBS+X6UijmVGYniWtdriBtastEy4mYYv+Rc8ChasxWckVm1JQCjqnh6uqd9NiLoSh7PJe0X62jHbqCUcrfR+8AQsdDUm9kcl65193QC1HkoDGVwL8vqlDUZbevzgvezVE2tVs+hIj3765YmC2A7/1wSIL+tavw3lMVKnqulBLwdrC+meKEYxTYdLvIHDafkWpv6Oyp8jMfwm2sUgoviNwYEWhRoGaSTVp22jyT6UKBbSoYP2x22mThVh96Icj1qmCws5a4ZZ7jxiCoFxv+x27zuQGVQ1AlsdBzuwrWQ++tIa62jPwfXndTVmk4uHGhc2EDVkS9OHW/s="
    # ];
  };

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  system.stateVersion = "20.09";

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {}).customize {
      name = "vim";
      vimrcConfig.packages.myplugins = { start = [ vimPlugins.vim-nix ]; };
      vimrcConfig.customRC = ''
        set nocompatible
        set hlsearch
        set backspace=indent,eol,start
        syntax on
        filetype plugin indent on
        set tabstop=4
        set shiftwidth=4
        set expandtab
        set ai
      '';
    })
    wget
    bash
    gnupg
    ripgrep
    htop
    gnumake
    xclip
    git
    tmux
    dropbox-cli
    google-chrome
    tree
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
    wxmaxima
    geogebra
    speedcrunch
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
