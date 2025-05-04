{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
    	home.packages = with pkgs; [
            bat
            ffmpeg 
            htop 
            python3 
            ripgrep 
            screen 
            spotify
            unzip 
            zig 
            godot
            unityhub
            slack
        ];
    };
}
