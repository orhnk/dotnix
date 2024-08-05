-- Author: ema2159 <https://github.com/ema2159>
-- "A vibrant, neon colored theme inspired by VS Code Outrun Electric."

-- Credits to original https://github.com/morhetz/gruvbox
-- Customised to swamp.nvim by masroof-maindak.

local M = {}

M.base_30 = {
  white = "#f2f3f7",
  darker_black = "#090819",
  black = "#0c0a20", --  nvim bg
  black2 = "#110d26",
  one_bg = "#3b4167",
  one_bg2 = "#2d2844",
  one_bg3 = "#BA45A3",
  grey = "#546A90",
  grey_fg = "#6A6EA3",
  grey_fg2 = "#6A6EA3",
  light_grey = "#7984D1",

  statusline_bg = "#3a3124",
  lightbg = "#4d3f32",

  red = "#e61f44", --
  baby_pink = "#ce8196",
  pink = "#ff75a0",
  line = "#323536", -- for lines like vertsplit
  green = "#a7da1e", --
  vibrant_green = "#a7da1e",
  nord_blue = "#1ea8fc",
  blue = "#1ea8fc",
  yellow = "#ffd400",
  sun = "#ffd400",
  purple = "#ff2afc",
  dark_purple = "#df85ff",
  teal = "#A875FF",
  orange = "#cf433e",
  cyan = "#42c6ff",
  pmenu_bg = "#ff9b50",
  folder_bg = "#3b4167",
}

M.base_16 = {
  base00 = "#0C0A20",
  base01 = "#090819",
  base02 = "#110D26",
  base03 = "#3B4167",
  base04 = "#6A6EA3",
  base05 = "#6564D1",
  base06 = "#BA45A3",
  base07 = "#F2F3F7",
  base08 = "#919AD9",
  base09 = "#CF433E",
  base0A = "#FFD400",
  base0B = "#A7DA1E",
  base0C = "#3F88AD",
  base0D = "#1EA8FC",
  base0E = "#FF2AFC",
  base0F = "#DF85FF",
}

M.type = "dark"

M = require("base46").override_theme(M, "swamp")

return M
