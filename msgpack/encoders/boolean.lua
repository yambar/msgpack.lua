---Compacts a boolean value into a single byte.
---@param value boolean The boolean value to compact.
---@return string packed A string containing the packed boolean value.
return function(value)
  return value and string.pack('B', 0xC3) or string.pack('B', 0xC2)
end
