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
    extraConfigLua = ''
      onAttach = function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return { desc = "nvim-tree: "..desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          
          vim.keymap.set('n', '<leader>E', api.tree.change_root_to_node, opts('CD'))
          vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
          vim.keymap.set('n', '<leader>R', function()
            vim.cmd("NvimTreeCollapse")
            vim.cmd("NvimTreeRefresh")
          end, opts('Refresh'))
      end

      vim.opt.expandtab = true   -- Use spaces instead of tabs
      vim.opt.tabstop = 2       -- A tab character will be displayed as 4 spaces
      vim.opt.shiftwidth = 2    -- Automatic indentation will use 4 spaces
      vim.opt.softtabstop = 2   -- Tab key inserts/deletes 4 spaces
      vim.opt.autoindent = true
      vim.opt.smartindent = true
      vim.opt.fileencodings = "ucs-bom,utf-8,cp936,default,latin1"
      vim.opt.encoding = "utf-8"
      vim.g.clipboard = {
          name = "wl-clipboard",
          copy = {
              ["+"] = { "wl-copy", "--type", "text/plain" },
              ["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
          },
          paste = {
              ["+"] = { "wl-paste", "--no-newline" },
              ["*"] = { "wl-paste", "--primary", "--no-newline" },
          },
          cache_enabled = true,
      }
      vim.opt.clipboard = "unnamedplus"
    '';
    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      rust-analyzer
      # Telescope
      ripgrep
    ];
    globals = {
      mapleader = " "; # 设置 <leader> 为空格
      maplocalleader = " "; # 可选：设置局部 leader
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
        options = {
          silent = true;
          desc = "Focus NvimTree";
        };
      }

      # SPC-s-g to telescope live grep (search word)
      {
        mode = "n";
        key = "<leader>sg";
        action = ":Telescope live_grep<CR>";
        options = {
          silent = true;
          desc = "Search words (live grep)";
        };
      }

      # SPC-SPC to telescope find_files (search file by name)
      {
        mode = "n";
        key = "<leader><leader>";
        action = ":Telescope find_files<CR>";
        options = {
          silent = true;
          desc = "Search files by name";
        };
      }
      {
        mode = "n";
        key = "<leader>p";
        action = ":Telescope project<CR>";
        options = {
          silent = true;
          desc = "Search project";
        };
      }

    ];

    plugins = {
      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          pyright = {
            enable = true;
            settings = {
            };
          };
        };
      };
      auto-save.enable = true;
      bufferline.enable = true;
      flash.enable = true;
      lazy.enable = true;
      lazydev.enable = true;
      mini = {
        enable = true;
      };
      noice.enable = true;
      ts-autotag.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<C-`>]]"; # 绑定到 Ctrl + `
          direction = "tab"; # 在当前标签页打开（而不是分屏）
          hide_numbers = true; # 隐藏终端行号
          insert_mappings = false; # 避免终端模式下的快捷键冲突
          terminal_mappings = false; # 同上
          persist_mode = false; # 不保持终端状态
          close_on_exit = true; # 终端退出时自动关闭
          auto_scroll = true; # 自动滚动
          start_in_insert = true; # 启动时进入插入模式
          # 只允许一个终端实例（自动关闭旧的）
          on_open = ''
            		function(term)
            		  if vim.g.last_term ~= nil then
            		    vim.cmd("hide")
            		  end
            		  vim.g.last_term = term
            		end
            	      '';
          on_close = ''
            		function(term)
            		  if vim.g.last_term == term then
            		    vim.g.last_term = nil
            		  end
            		end
            	      '';
        };
      };
      persistence.enable = true;
      snacks.enable = true;
      telescope = {
        enable = true;
        extensions.project = {
          enable = true;
          settings = {
            base_dirs = [
              "~/repos/ics2024"
              "~/repos/ysyx-workbench"
              "~/code/c"
            ];
          };
        };
      };
      nvim-tree = {
        enable = true;       
      };
      todo-comments.enable = true;
      trouble.enable = true;
      ts-comments.enable = true;
      which-key.enable = true;

      # Other plugins from your list
      conform-nvim.enable = true;
      friendly-snippets.enable = true;
      gitsigns.enable = true;
      grug-far.enable = true;
      lualine.enable = true;
      nui.enable = true;
      lint.enable = true;
      treesitter = {
        enable = true;
        folding = true;
      };
      web-devicons.enable = true;
      render-markdown.enable = true;
      molten.enable = true;

    };

  };
}
