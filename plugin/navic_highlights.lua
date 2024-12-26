local colors = {
  purple = "#C586C0",
  blue = "#569CD6",
  yellow = "#DCDCAA",
  green = "#4EC9B0",
  orange = "#CE9178",
  red = "#F44747",
  gray = "#808080",
  pink = "#D18AFF",
  lightBlue = "#9CDCFE",
  lightGreen = "#B5CEA8",
  lightRed = "#D16969",
  lightYellow = "#F9F1A5",
}

local highlights = {
  NavicIconsFile = colors.gray,
  NavicIconsModule = colors.blue,
  NavicIconsNamespace = colors.blue,
  NavicIconsPackage = colors.orange,
  NavicIconsClass = colors.yellow,
  NavicIconsMethod = colors.purple,
  NavicIconsProperty = colors.blue,
  NavicIconsField = colors.blue,
  NavicIconsConstructor = colors.green,
  NavicIconsEnum = colors.green,
  NavicIconsInterface = colors.green,
  NavicIconsFunction = colors.purple,
  NavicIconsVariable = colors.blue,
  NavicIconsConstant = colors.orange,
  NavicIconsString = colors.orange,
  NavicIconsNumber = colors.orange,
  NavicIconsBoolean = colors.orange,
  NavicIconsArray = colors.orange,
  NavicIconsObject = colors.orange,
  NavicIconsKey = colors.purple,
  NavicIconsNull = colors.red,
  NavicIconsEnumMember = colors.green,
  NavicIconsStruct = colors.yellow,
  NavicIconsEvent = colors.yellow,
  NavicIconsOperator = colors.gray,
  NavicIconsTypeParameter = colors.green,
  NavicText = colors.gray,
  NavicSeparator = colors.gray,
}

local function set_navic_highlights()
  for group, color in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, { default = true, fg = color })
  end
end

set_navic_highlights()
