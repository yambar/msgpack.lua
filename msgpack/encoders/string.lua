---Compacts a string value into a single byte or more.
---
---If the input string is a valid UTF-8 string, it will be packed as a `fixstr`,
---otherwise, it will be packed as a `bin`.
---@param value string The string value to compact.
---@return string packed A string containing the packed string value.
return function(value)
  local length = #value

  if utf8.len(value) then
    if length < 32 then
      return string.pack('B', 0xA0 + length) .. value
    elseif length < 256 then
      return string.pack('>Bs1', 0xD9, value)
    elseif length < 65536 then
      return string.pack('>Bs2', 0xDA, value)
    else
      return string.pack('>Bs4', 0xDB, value)
    end
  else
    if length < 256 then
      return string.pack('>Bs1', 0xC4, value)
    elseif length < 65536 then
      return string.pack('>Bs2', 0xC5, value)
    else
      return string.pack('>Bs4', 0xC6, value)
    end
  end
end
