{ pkgs, lib, config, home-manager, nix-darwin, inputs, ...}: {
  programs = {
    bat = {
      enable = true;
      config.theme = "Nord";
    };

    exa.enable = true;

    fish = {
      enable = true;
      shellInit = ''
      cat /Users/stevensherry/.nix-profile/etc/profile.d/nix.sh | /Users/stevensherry/.nix-profile/bin/babelfish | source
      '';
      shellAliases = {
        ls = "exa -G --color auto --icons -a -s type";
        ll = "exa -l --color always --icons -a -s type";
      };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    git = {
      enable = true;
      userName = "Steven Sherry";
      userEmail = "steven.sherry@affinityforapps.com";

      delta = {
        enable = true;
        options = {
          syntax-theme = "Nord";
          line-numbers = true;
        };
      };

      ignores = [".DS_Store"];

      signing = {
        key = "5BE85414B74F99B1";
        signByDefault = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home-manager.enable = true;

    jq.enable = true;

    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        command_timeout = 5000;

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[✗](bold red)";
        };
         
        directory = { 
          read_only = " ";
        };

        git_branch = {
          only_attached = true;
        };

        git_commit = {
          tag_disabled = false;
          tag_symbol = "  "; 
          format = "[on](fg:white) [ $hash](bold fg:purple)[$tag](fg:blue) ";
        };

        git_status = {
          format = "([$conflicted$stashed$deleted$modified$staged$untracked$ahead_behind]($style))"; 
          conflicted = "[ $count](bold fg:red)]";
          staged = "[ $count ](fg:green)";
          modified = "[ $count ](fg:yellow)";
          deleted = "[ $count ](fg:red)";
          untracked = "[ $count ](fg:#D08770)";
          stashed = "[  $count ](fg:blue)";
          ahead = "[ $count ](fg:white)";
          behind = "[ $count ](fg:white)";
        };

        elixir = {
          symbol = " ";
          style = "bold purple";
        };

        elm = {
          symbol = " ";
          style = "bold blue";
        };

        erlang = {
          symbol = " ";
          style = "bold red";
        };

        gcloud = {
          disabled = true;
        };

        golang = {
          symbol = "ﳑ ";
        }; 

        java = {
          symbol = " ";
          style = "bold red";
        };

        python = {
          symbol = " ";
          style = "bold yellow";
        };

        ruby = {
          symbol = " ";
          style = "bold red";
        };

        rust = {
          symbol = " ";
          style = "bold red";
        };

        swift = {
          symbol = " ";
          style = "bold #D08770";
        };
      };
    };
  };

  home.packages = with pkgs; [
    _1password
    ansible
    argocd
    babelfish
    bpytop
    drone-cli
    exercism
    ffmpeg
    glow
    go-task
    kubernetes-helm
    imagemagick
    kubectl
    (lunarvim.override { homeDir = "/Users/stevensherry"; })
    lynx
    minikube
    nerdfonts
    # Useful for getting sha256 hashes for github repos
    nix-prefetch-github
    neovim
    # podman # -- Currently doesn't work due to being unable to find gvproxy
    # quickemu
    qemu 
    ripgrep
    tanka
    youtube-dl
  ];
}

