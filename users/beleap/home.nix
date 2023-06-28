{ lib, pkgs, dotfiles, ... }:

{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        neovim-nightly

        nodejs
        go
        cargo
        deno

        mtr
        tshark

        azure-cli

        kubernetes-helm
        kubectl

        yq
        lsd
        fd
        ripgrep
        bat
        difftastic;

      inherit (pkgs.gitAndTools) gh;
    };

    stateVersion = "22.05";
    sessionVariables = {
      SHELL = "fish";
    };
  };

  programs = {
    git = {
      enable = true;

      userName = "BeLeap";
      userEmail = "beleap@beleap.dev";

      extraConfig = {
        push.autoSetupRemote = true;
      };

      difftastic = {
        enable = true;
      };

      ignores = [
        "*.null_ls*"
        "root.md"
      ];
    };

    home-manager.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      withNodeJs = true;
      withRuby = true;
      withPython3 = true;
    };

    fish = {
      enable = true;

      shellAliases = {
        sofish = "source ~/.config/fish/config.fish";

        v = "nvim";
      };

      shellAbbrs = {
        gst = "git status";
        gsw = "git switch";
        gd = "git diff";
        ga = "git add";
        gc = "git commit -v";
        gp = "git push";
        gf = "git fetch --prune --all";
        gl = "git pull";

        k = "kubectl";
      };
    };

    zoxide = {
      enable = true;

      enableFishIntegration = true;
    };

    lsd = {
      enable = true;

      enableAliases = true;
    };

    starship = {
      enable = true;

      settings = import ./config/starship.nix;
    };

    direnv = {
      enable = true;

      nix-direnv = {
        enable = true;
      };
    };

    tmux = {
      enable = true;
      clock24 = true;
      shortcut = "a";
      keyMode = "vi";

      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        sensible
      ];
    };
  };

  xdg.configFile = {
    nvim.source = "${dotfiles}/nvim/.config/nvim";
  };
}
