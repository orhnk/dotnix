-- Credits to original https://github.com/arcticicestudio/nord-vim
-- This is modified version of it

local M = {}

M.base_30 = {
  white = "#D8DEE9",
  darker_black = "#100C10",
  black = "#191C24", --  nvim bg
  black2 = "#2a303c",
  one_bg = "#2E3440",
  one_bg2 = "#3B4252",
  one_bg3 = "#434C5E",
  grey = "#4C566A",
  grey_fg = "#545a66",
  grey_fg2 = "#595f6b",
  light_grey = "#606672",
  red = "#BF616A",
  baby_pink = "#D06F79",
  pink = "#A54E56",
  line = "#414753", -- for lines like vertsplit
  green = "#8AA872",
  vibrant_green = "#B1D196",
  blue = "#69A7BA",
  nord_blue = "#81A1C1",
  yellow = "#D9B263",
  sun = "#F0D399",
  purple = "#C895BF",
  dark_purple = "#9D7495",
  teal = "#8FBCBB",
  orange = "#D89079",
  cyan = "#93CCDC",
  statusline_bg = "#333945",
  lightbg = "#3f4551",
  pmenu_bg = "#A3BE8C",
  folder_bg = "#7797b7",
}

M.base_16 = {
  base00 = "#2a303c",
  base01 = "#2E3440",
  base02 = "#3B4252",
  base03 = "#434C5E",
  base04 = "#4C566A",
  base05 = "#B1D196",
  base06 = "#c7cdd8",
  base07 = "#ced4df",
  base08 = "#EBCB8B",
  base09 = "#81A1C1",
  base0A = "#D06F79", --#d57780
  base0B = "#F0D399",
  base0C = "#97b7d7",
  base0D = "#B48EAD",
  base0E = "#D89079",
  base0F = "#D06F79",
}

M.type = "dark"

M = require("base46").override_theme(M, "nordic")

return M
