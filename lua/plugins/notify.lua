-- notify package
return {
  'rcarriga/nvim-notify',
  enable = false,
  config = function()
    local notify = require('notify')
    notify.setup({
      stages = 'fade_in_slide_out',
      timeout = 5000,
      background_colour = '#1e222a',
      text_colour = '#abb2bf',
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '✎',
      },
    })
    vim.notify = notify
  end
}
