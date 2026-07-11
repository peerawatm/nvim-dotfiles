require("neo-tree").setup({
  renderers = {
    directory = {
      { "indent" },
      { "icon" },
      { "current_filter" },
      {
        "container",
        right_padding = 0,
        content = {
          { "name", zindex = 10 },
          { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
          { "clipboard", zindex = 10 },
          { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
          { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
          { "file_size", zindex = 10, align = "right" },
          { "type", zindex = 10, align = "right" },
          { "last_modified", zindex = 10, align = "right" },
          { "created", zindex = 10, align = "right" },
        },
      },
    },
    file = {
      { "indent" },
      { "icon" },
      {
        "container",
        right_padding = 0,
        content = {
          { "name", zindex = 10 },
          { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
          { "clipboard", zindex = 10 },
          { "bufnr", zindex = 10 },
          { "modified", zindex = 20, align = "right" },
          { "diagnostics", zindex = 20, align = "right" },
          { "git_status", zindex = 10, align = "right" },
          { "file_size", zindex = 10, align = "right" },
          { "type", zindex = 10, align = "right" },
          { "last_modified", zindex = 10, align = "right" },
          { "created", zindex = 10, align = "right" },
        },
      },
    },
  },
  filesystem = {
    use_libuv_file_watcher = true,
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      never_show = { ".DS_Store" },
    },
  },
  default_component_configs = {
    icon = {
      folder_closed = "▶",
      folder_open = "▼",
      folder_empty = "▷",
      default = " ",
    },
    indent = {
      indent_marker = "│",
      last_indent_marker = "└",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = false,
      highlight = "NeoTreeFileName",
      width = 30,
    },
    modified = { symbol = "●" },
    file_size = { enabled = true, required_width = 30 },
    last_modified = { enabled = true, required_width = 45, format = "%b %d %Y %H:%M" },
  },
  window = {
    title = false,
    width = 58,
    mappings = {
      ["<tab>"] = "none",
      ["<space>"] = "none",
    },
  },
})
