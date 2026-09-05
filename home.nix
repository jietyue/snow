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
	initExtra = ''
	export PS1='\[\e[38;5;26m\]\u\[\e[0m\] in \[\e[38;5;33m\]\w\[\e[0m\] \\$ '
	'';
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
	kitty
	vscode
	playerctl
	];

} 
