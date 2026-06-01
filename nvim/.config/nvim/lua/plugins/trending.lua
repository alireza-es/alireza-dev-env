-- Curated trending plugins (2026) that LazyVim does NOT ship by default.
return {
  -- Edit the filesystem like a buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      view_options = { show_hidden = true },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
    },
  },

  -- Project-wide find & replace with live preview
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    cmd = "GrugFar",
    keys = {
      { "<leader>sr", function() require("grug-far").open() end, desc = "Search & Replace (project)" },
    },
  },

  -- Pin & jump between your hot files
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>H", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
      { "<leader>h", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- Clipboard / yank history
  {
    "gbprod/yanky.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {},
    keys = {
      { "<leader>p", function() require("yanky.picker").pick() end, desc = "Yank history" },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
      { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Next yank entry" },
      { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Prev yank entry" },
    },
  },

  -- Language-aware refactoring (extract/inline) for Python/JS/TS and more
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      { "<leader>rr", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Refactor menu" },
    },
  },
}
