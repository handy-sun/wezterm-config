local M = {}

---@class TabTitleWidthOptions
---@field title string
---@field max_width number
---@field inset number
---@field min_width number
---@field column_width fun(text: string): number
---@field truncate_right fun(text: string, max_width: number): string

---@param value number
---@param lower number
---@param upper number
---@return number
local function clamp(value, lower, upper)
   return math.max(lower, math.min(value, upper))
end

---@param opts TabTitleWidthOptions
---@return string
M.fit_title = function(opts)
   local max_width = math.max(0, opts.max_width)
   local inset = clamp(opts.inset, 0, max_width)
   local min_width = clamp(opts.min_width, inset, max_width)

   local title = opts.title
   local title_width = opts.column_width(title)
   local target_width = clamp(title_width + inset, min_width, max_width)
   local title_max_width = target_width - inset

   if title_width > title_max_width then
      title = opts.truncate_right(title, title_max_width)
      title_width = opts.column_width(title)
   end

   return title .. string.rep(' ', title_max_width - title_width)
end

return M
