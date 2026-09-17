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
	nf = "neowofetch --config  ~/snow/dotfiles/neofetch/config.conf";
	};
	initExtra = ''
	export PS1='\[\e[97m\]\u\[\e[37m\]@\[\e[0m\]\h \w \[\e[37m\]\\$\[\e[0m\] '
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
	cava
	cachix
	qutebrowser
	rmpc
	];

} 
