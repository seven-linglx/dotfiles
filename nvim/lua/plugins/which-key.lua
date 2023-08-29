return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      if require("lazyvim.util").has("project.nvim") then
        opts.defaults["<leader>p"] = { name = "+project" }
      end
    end,
  },
}
