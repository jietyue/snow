# cf-sv1 | yuriclears

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # graphics / drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  boot.initrd.kernelModules = [ "i915" ];

  # network
  networking.hostName = "cf-sv1";
  networking.networkmanager.enable = true;

  # timezone
  time.timeZone = "Europe/Brussels";

  # greetd

  services.greetd = {
   enable = true;

   settings = {
     default_session = {
       command = "start-hyprland";
       user = "yuriclears";
     };
   };
 };

  security.rtkit.enable = true;

  # user
   users.users.yuriclears = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  # system packages
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     neovim
     alacritty
     hyfetch
     vlc
     btop
     brightnessctl
     hyprland
     hyprpaper
     hyprlock
     quickshell
     rofi
     yazi
     imv
   ];

  # programs (with options)
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  # ssh
  services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
