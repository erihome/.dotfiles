return {
  "ibhagwan/fzf-lua",
  opts = {
    fzf_bin = "fzf-tmux",
    fzf_opts = { ["--border"] = "rounded" },
    fzf_tmux_opts = { ["-p"] = "80%,60%" },
    winopts = { preview = { default = "bat" } },
    manpages = { previewer = "man-native" },
    helptags = { previewer = "help_native" },
    lsp = { code_actions = { previewer = "codeaction_native" } },
    tags = { previewer = "bat" },
    btags = { previewer = "bat" },
    lines = { _treesitter = false },
    blines = { _treesitter = false },
    -- oldfiles = {
    --   -- In Telescope, when I used <leader>fr, it would load old buffers.
    --   -- fzf lua does the same, but by default buffers visited in the current
    --   -- session are not included. I use <leader>fr all the time to switch
    --   -- back to buffers I was just in. If you missed this from Telescope,
    --   -- give it a try.
    --   include_current_session = true,
    -- },
    -- previewers = {
    --   builtin = {
    --     -- fzf-lua is very fast, but it really struggled to preview a couple files
    --     -- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
    --     -- It turns out it was Treesitter having trouble parsing the files.
    --     -- With this change, the previewer will not add syntax highlighting to files larger than 100KB
    --     -- (Yes, I know you shouldn't have 100KB minified files in source control.)
    --     syntax_limit_b = 1024 * 100, -- 100KB
    --   },
    -- },
  },
}