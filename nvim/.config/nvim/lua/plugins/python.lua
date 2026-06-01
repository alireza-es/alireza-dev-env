-- Python tuning on top of the LazyVim `lang.python` extra
-- (basedpyright for types, ruff for lint/format/import-sort, debugpy for DAP).
return {
  -- Enable inlay hints + tweak basedpyright analysis
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard", -- basic | standard | strict
                autoImportCompletions = true,
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                  callArgumentNames = true,
                },
              },
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
              -- ruff handles import organization + formatting
              organizeImports = true,
            },
          },
        },
      },
    },
  },

  -- Per-project virtualenv picker (.venv / pyenv / conda)
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap-python",
      { "nvim-telescope/telescope.nvim", optional = true },
    },
    ft = "python",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" },
    },
    opts = {},
  },
}
