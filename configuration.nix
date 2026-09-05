{ config, lib, pkgs, ... }:
let
    home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      (import "${home-manager}/nixos")
      /etc/nixos/cachix.nix
    ];
	
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.jietyue = import ./home.nix;

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
   wget
   hyprland
   hyprlock
   hyprpaper
   quickshell
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
  vista-fonts
  lilex
  iosevka
  material-symbols
];

  services.greetd = {
	enable = true;
	settings = {
		default_session = {
		command = "start-hyprland -- -c /home/jietyue/snow/dotfiles/hypr/hyprland.lua";
		user = "jietyue";
		};
	};
	};	

  
  programs.hyprland = {
  	enable = true;
	xwayland.enable = true;
	};


  services.mopidy = {
  enable = true;
  extensionPackages = [ pkgs.mopidy-soundcloud ];
  
  # Change 'configuration = '' ... '';' to 'settings = { ... };'
  settings = {
    soundcloud = {
      enabled = true;
      auth_token = ""; # Put your actual token here
    };
    
    # If you have other sections like [mpd] or [audio], add them like this:
    # mpd = {
    #   enabled = true;
    #   hostname = "::";
    # };
  };
};



  programs.thunar.enable = true;
  services.openssh.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;
  system.stateVersion = "26.05"; # Did you read the comment

}

