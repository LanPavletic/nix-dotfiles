{config, pkgs, ...}:
{
  programs.neovim = 
  let
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
	config = toLuaFile ./nvim/lsp.lua;
      }

      nvim-cmp
      {
        plugin = nvim-cmp;
	config = toLuaFile ./nvim/cmp.lua;
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
	  p.tree-sitter-go
        ]));
        config = toLuaFile ./nvim/treesitter.lua;
      }

      {
        plugin = nightfox-nvim;
      }

      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
      lualine-nvim
      nvim-web-devicons

    ];
    
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';
  };
}
