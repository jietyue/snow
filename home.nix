{ config, pkgs, ...}:

{
  home.username = "jietyue";
  home.homeDirectory = "/home/jietyue";
  home.stateVersion = "26.05";
	
  programs.bash = {
	enable = true;
	shellAliases = {
	nrs = "sudo nixos-rebuild switch --impure --flake ~/snow";
	nrdc = "sudo nixos-rebuild dry-clean --impure --flake ~/snow";
        nixconfig = "sudo vim ~/snow/configuration.nix";
	homeconfig = "vim ~/snow/home.nix";
	};
	};

  home.packages = with pkgs; [
	git
	bat
	hyfetch
	neovim
	vlc
	yazi
	imv
	rofi
	alacritty
	vim
	];

} 
