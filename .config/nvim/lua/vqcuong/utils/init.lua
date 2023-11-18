local M = {}

function M.contains(list, element)
  for _, e in pairs(list) do
    if e == element then
      return true
    end
  end
  return false
end

return M
