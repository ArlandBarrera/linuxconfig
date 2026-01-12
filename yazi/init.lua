function Linemode:custom_mtime()
  local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
    time = ""
  elseif os.date("%Y", time) == os.date("%Y") then
    time = os.date("%d/%m/%y %H:%M", time)
  else
    time = os.date("%d/%m/%Y", time)
  end
  return string.format("%s", time)
end
