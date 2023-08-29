-- change project config
return {
  {
    "ahmedkhalf/project.nvim",
    -- opts will be merged with the parent spec
    opts = { manual_mode = false },
    keys = {
      { "<leader>fp", false },
      { "<leader>pp", "<Cmd>Telescope projects<CR>", desc = "resent projects" },
    },
  },
}
