{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      rust-analyzer
      # Telescope
      ripgrep
    ];
    extraConfigLua = ''
      require("config.lazy")
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
          end
        }
      }
    '';
    plugins = {
      rustaceanvim.enable = true;
      lsp = {
        servers={
          clangd.enable = true;
          pyright.enable = true;

        };
      };
    };

  };
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths =
          (pkgs.vimPlugins.nvim-treesitter.withPlugins (
            plugins: with plugins; [
              c
              lua
            ]
          )).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
}
