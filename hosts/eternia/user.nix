{ config, lib, inputs, ...}:

{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        # gui
        firefox.enable = true;
        steam.enable = true;
        discord.enable = true;

        # cli
        nvim.enable = true;
        git.enable = true;
        direnv.enable = true;

        # system
        packages.enable = true;
    };
}
