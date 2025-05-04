{ inputs, pkgs, config, ...}:

{
    home.stateVersion = "24.11";
    imports = [
        ./direnv
        ./discord
        ./firefox
        ./git
        ./nvim
        ./obsidian
        ./wezterm
        ./steam
        ./vscode

        # system
        ./packages
    ];
}
