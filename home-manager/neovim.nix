{ config, pkgs, ... }:

let customPlugins = {
  moonfly-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "moonfly.nvim";
    version = "2023-05-20";
    src = pkgs.fetchFromGitHub {
      owner = "bluz71";
      repo = "vim-moonfly-colors";
      rev = "1e81cbb88a34c41572fde43cd633bd6d60727274";
      sha256 = "omIrRr9zXC5K45TgInGoQmA4EIEGWvWIuJWRfcMfh2k=";
    };
    meta.homepage = "https://github.com/bluz71/vim-moonfly-colors";
  };
};

allPlugins = pkgs.vimPlugins // customPlugins;

in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
        luafile /home/jasshank/core/src/neovim/settings.lua
        luafile /home/jasshank/core/src/neovim/remap.lua
        luafile /home/jasshank/core/src/neovim/colours.lua
        luafile /home/jasshank/core/src/neovim/lsp.lua
        luafile /home/jasshank/core/src/neovim/telescope.lua
        luafile /home/jasshank/core/src/neovim/harpoon.lua
        luafile /home/jasshank/core/src/neovim/undotree.lua
    '';

    plugins = with allPlugins; [
      # lsp
      vim-nix
      nvim-lspconfig
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-nvim-lua
      cmp-nvim-lsp
      cmp_luasnip

      # syntax highlighting
      nvim-treesitter.withAllGrammars

      # code navigation 
      telescope-nvim
      harpoon
      undotree

      # git
      vim-fugitive

      # colours
      moonfly-nvim
    ];

    # lsp installation 
    extraPackages = with pkgs; [
      rnix-lsp
    ];
  };
}

