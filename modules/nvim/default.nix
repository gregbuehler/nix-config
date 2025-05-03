{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.nvim;

in {
    options.modules.nvim = { enable = mkEnableOption "nvim"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            # for adding plugs later
        ];

        programs.neovim = {
            enable = true;
        };
    };
}