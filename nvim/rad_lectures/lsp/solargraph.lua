return {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir = vim.fs.dirname(vim.fs.find({ "Gemfile", ".git", ".solargraph.yml" }, { upward = true })[1]),
  init_options = {
    formatting = true,
  },
  capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
    textDocument = {
      codeAction = {
        dynamicRegistration = false,
      },
    },
  }),
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
      autoformat = true,
      completion = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true,
    }
  }
}
