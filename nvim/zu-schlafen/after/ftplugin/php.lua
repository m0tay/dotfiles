local snippets = {
  debug = [[define('DEBUG', true);

if (DEBUG) {
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);
}

require_once './core.php';
]],
  ht = [[<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>${1:PAW}</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta name="description" content="" />
  <link href="https://cdn.jsdelivr.net/npm/modern-normalize@v3.0.1/modern-normalize.min.css" rel="stylesheet">
  <link rel="icon" href="favicon.png">
</head>
<body>
	$2
</body>
</html>]],
}

for key, body in pairs(snippets) do
  vim.keymap.set('i', ';' .. key, function()
    vim.snippet.expand(body)
  end, { buffer = true })
end

-- vim.lsp.enable 'intelephense'
-- vim.lsp.enable 'phpactor'

local job

vim.api.nvim_buf_create_user_command(0, 'Serve', function(opts)
  if job then
    vim.fn.jobstop(job)
    print("Server stopped")
    job = nil
    return
  end

  local port = opts.args ~= "" and opts.args or "8000"
  local dir = vim.fn.expand('%:p:h')
  job = vim.fn.jobstart({ "php", "-S", "localhost:" .. port, "-t", dir }, { detach = true })
  print("Serving PHP server on http://localhost:" .. port)
end, { nargs = '?' })
