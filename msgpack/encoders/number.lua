---Compacts a number value into a single byte or more.
---
---If the number is an integer, it will be packed as an `int8`, `uint8`,
---`int16`, `uint16`, `int32`, or `uint32`, depending on its value.
---
---If the number is a float, it will be packed as a `float32` or `float64`,
---depending on its value.
---@param value number The number value to compact.
---@return string packed A string containing the packed number value.
return function(value)
  if math.type(value) == 'integer' then
    if value >= 0 then
      if value < 128 then
        return string.pack('B', value)
      elseif value <= 0xFF then
        return string.pack('BB', 0xCC, value)
      elseif value <= 0xFFFF then
        return string.pack('>BI2', 0xCD, value)
      elseif value <= 0xFFFFFFFF then
        return string.pack('>BI4', 0xCE, value)
      else
        return string.pack('>BI8', 0xCF, value)
      end
    else
      if value >= -32 then
        return string.pack('B', 0xE0 + (value + 32))
      elseif value >= -128 then
        return string.pack('Bb', 0xD0, value)
      elseif value >= -32768 then
        return string.pack('>Bi2', 0xD1, value)
      elseif value >= -2147483648 then
        return string.pack('>Bi4', 0xD2, value)
      else
        return string.pack('>Bi8', 0xD3, value)
      end
    end
  else
    return string.pack(math.abs(value) < math.huge and '>Bf' or '>Bd', value >= 0 and 0xCA or 0xCB, value)
  end
end
