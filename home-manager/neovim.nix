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
        luafile /home/jasshank/core/src/neovim/treesitter.lua
        luafile /home/jasshank/core/src/neovim/remap.lua
        luafile /home/jasshank/core/src/neovim/colours.lua
        luafile /home/jasshank/core/src/neovim/lsp.lua
        luafile /home/jasshank/core/src/neovim/autocmp.lua
        luafile /home/jasshank/core/src/neovim/telescope.lua
        luafile /home/jasshank/core/src/neovim/harpoon.lua
        luafile /home/jasshank/core/src/neovim/undotree.lua
        luafile /home/jasshank/core/src/neovim/conjure.lua
    '';

    plugins = with allPlugins; [
      # lsp
      nvim-lspconfig # help with lspconfig

      nvim-cmp # autocomplete functionality 
      cmp-nvim-lsp # sources and runs the completions from the language servers
      cmp-buffer # buffer word completions 
      cmp-path # path completions 

      luasnip # snippets
      cmp_luasnip # snippet completion

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

      # QoL
      telescope-ui-select-nvim

      # REPL-like
      #conjure
      #cmp-conjure
    ];

    # lsp installation 
    extraPackages = with pkgs; [
      nixd
      lua-language-server
      marksman
    ];
  };
}

