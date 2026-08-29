{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];
	
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
  	package = config.boot.kernelPackages.nvidiaPackages.stable;
	modesetting.enable = true;
	open = false;
	powerManagement.enable = false;
	};

  hardware.graphics = {
  	enable = true;
	enable32Bit = true;
	};

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "b360m-d2v"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Brussels";


 users.users.jietyue = {
   isNormalUser = true;
   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     tree
   ];
 };

 environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   neovim
   git
   alacritty
   hyfetch
   kitty
   hyprland
   hyprlock
   hyprpaper
   rofi
   quickshell
   vlc
   yazi
   imv
   bat
 ];

 fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
];

  services.greetd = {
	enable = true;
	settings = {
		default_session = {
		command = "start-hyprland";
		user = "jietyue";
		};
	};
	};	

  programs.bash = {
  	enable = true;
	shellAliases = {
	nixconfig = "sudo nvim /etc/nixos/configuration.nix";
	nrs = "sudo nixos-rebuild switch";
	nrb = "sudo nixos-rebuild boot";
	shutd = "sudo shutdown 0";
	reboot = "sudo reboot";
	};
        };
  
  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
	};

  services.openssh.enable = true;
  programs.firefox.enable = true;
  system.stateVersion = "26.05"; # Did you read the comment

}

