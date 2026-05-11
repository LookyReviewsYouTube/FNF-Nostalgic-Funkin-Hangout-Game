--script by Dave 27
--This is not really important but I leave it anyway if you want to use it in a script
function getTXTFileByLines(filePath, lineNumber)
local file = io.open('mods/'..currentModDirectory..'/'..filePath..'.txt', "r")
if not file then
debugPrint("ERROR: TXT file could not be found.", 'FF0000')
return nil
end
local line
for i = 1, lineNumber do
line = file:read("*l")
if not line then
debugPrint("ERROR: The TXT file has no lines to obtain information.", 'FF0000')
file:close()
return nil
end
end
file:close()
return line
end