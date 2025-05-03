{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.vscode;

in {
    options.modules.vscode = { enable = mkEnableOption "vscode"; };
    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        vscode
      ];
    };
}
