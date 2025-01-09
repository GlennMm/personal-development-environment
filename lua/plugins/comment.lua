return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  lazy = false,
  ---@module 'comment'
  ---@type comment.config.CommentConfig
  opts = {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
      line = "<leader>/",
      block = "<leader>/",
    },
  },
  keys = {
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", mode = "n",                                desc = "comment toggle current line" },
    { "gcc",       mode = "n",                                desc = "comment toggle current line" },
    { "gc",        mode = { "n", "o" },                       desc = "comment toggle linewise" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)",  mode = { "x", "v" },                       desc = "comment toggle linewise (visual)" },
    { "gc",        mode = "x",                                desc = "comment toggle linewise (visual)" },
    { "gbc",       mode = "n",                                desc = "comment toggle current block" },
    { "gb",        mode = { "n", "o" },                       desc = "comment toggle blockwise" },
    { "gb",        mode = "x",                                desc = "comment toggle blockwise (visual)" },
  },
  config = function(_, opts)
    require("Comment").setup({
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = '<leader>/',
        ---Block-comment toggle keymap
        block = '<leader>//',
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = '<leader>/',
        ---Block-comment keymap
        block = '<leader>//',
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = nil,
      ---Function to call after (un)comment
      post_hook = nil,
    })
  end,
}
