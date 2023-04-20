---Checks if the given table is a sequential array, i.e, if it is a table with
---integer keys starting at 1 and ending at the length of the table.
---@param array integer[] The table to check if it is a sequential array.
---@return boolean result `true` if the given table is a sequential array, `false` otherwise.
return function(array)
  if type(array) ~= 'table' then
    return false
  end

  local length = #array
  if length == 0 then
    return true
  end

  for index = 1, length do
    if array[index] == nil then
      return false
    end
  end

  for key in pairs(array) do
    if type(key) ~= 'number' or key < 1 or key > length or math.floor(key) ~= key then
      return false
    end
  end

  return true
end
