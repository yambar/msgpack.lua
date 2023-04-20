---Compacts a null value into a single byte.
---@return string packed A string containing the packed null value.
return function()
  return string.pack('B', 0xC0)
end
