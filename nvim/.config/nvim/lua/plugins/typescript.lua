-- TypeScript/JavaScript tuning on top of LazyVim `lang.typescript`,
-- `linting.eslint`, and `formatting.prettier` extras.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
              },
            },
          },
        },
      },
    },
  },

  -- Auto close/rename JSX/TSX/HTML tags
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    opts = {},
  },

  -- Inline npm package versions + actions in package.json
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = { "BufRead package.json" },
    opts = {},
  },
}
