{ lib, ... }@arguments:

{
  # Import system programs
  imports =
    let
      utils = import ./../utils.nix arguments;
      files = utils.listVisibleFilesRecursive ./programs;
    in
    lib.filter (_path: lib.strings.hasSuffix ".nix" _path) files;

  networking = {
    useNetworkd = true;
    useDHCP = false;
    wireless.iwd = {
      enable = true;
      settings.Settings.AutoConnect = true;
    };
    nameservers = lib.mkForce [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];
    firewall.allowedUDPPorts = [ 5353 ];
  };

  systemd.network.networks."99-wireless" = {
    matchConfig.WLANInterfaceType = "station";
    dhcpV4Config = {
      UseDNS = false;
      UseNTP = false;
    };
    dhcpV6Config = {
      UseDNS = false;
      UseNTP = false;
    };
    networkConfig = {
      DHCP = true;
      MulticastDNS = true;
      IPv6PrivacyExtensions = "kernel";
    };
  };

  boot = {
  	loader.grub = {
   		enable = true;
   		device = "/dev/nvme0n1";
     	useOSProber = true;
    };
    tmp.useTmpfs = true;
  };

  time.timeZone = "America/New_York";

  i18n = {defaultLocale = "en_US.UTF-8";
  extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };};

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo-rs.enable = true;
  };

  services = {
    resolved = {
      enable = true;
      extraConfig = ''
        	MulticastDNS=yes
        	LLMNR=no
      '';
    };

    udisks2.enable = true;
    dbus.implementation = "broker";
   	printing.enable = true;
  };

  programs.appimage.binfmt = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];
    };
    channel.enable = false;
  };

  system.stateVersion = "25.11";
}
