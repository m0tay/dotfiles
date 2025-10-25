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

vim.lsp.enable 'intelephense'
