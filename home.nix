{ config, pkgs, ...}:

{
  home.username = "jietyue";
  home.homeDirectory = "/home/jietyue";
  home.stateVersion = "26.05";

  programs.bash = {
	enable = true;
	shellAliases = {
	test = "echo hello";
	};
	};
} 
