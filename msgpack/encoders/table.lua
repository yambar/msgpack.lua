local is_sequential_array = require('msgpack.helpers.is-sequential-array')

---Compacts a table value into a single byte or more.
---
---If the table is a sequential array, it will be packed as a `fixarray`,
---otherwise, it will be packed as a `map`.
---@param value table The table value to compact.
---@return string packed A string containing the packed table value.
return function(value)
  local encode = function(value)
    return require('msgpack.encoders.' .. type(value))(value)
  end

  if is_sequential_array(value) then
    local elements = {}

    for index, object in pairs(value) do
      elements[index] = encode(object)
    end

    local length = #elements

    if length < 16 then
      return string.pack('B', 0x90 + length) .. table.concat(elements)
    elseif length < 65536 then
      return string.pack('>BI2', 0xDC, length) .. table.concat(elements)
    else
      return string.pack('>BI4', 0xDD, length) .. table.concat(elements)
    end
  else
    local elements = {}

    for key, object in pairs(value) do
      elements[#elements + 1] = encode(key)
      elements[#elements + 1] = encode(object)
    end

    local length = #elements // 2

    if length < 16 then
      return string.pack('>B', 0x80 + length) .. table.concat(elements)
    elseif length < 65536 then
      return string.pack('>BI2', 0xDE, length) .. table.concat(elements)
    else
      return string.pack('>BI4', 0xDF, length) .. table.concat(elements)
    end
  end
end
