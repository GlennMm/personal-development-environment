local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local M = {}

-- TODO: to be continued

local live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job {}
	pickers.new(opts, {
		finder = finder
	}):find()
end

M.setup = function()
	live_multigrep()
end

return M
