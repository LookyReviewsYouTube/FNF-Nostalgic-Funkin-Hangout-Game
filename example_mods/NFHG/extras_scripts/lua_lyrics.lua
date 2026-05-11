--script by Dave 27
local textNum = 0
local iconNum = 0
local lyricsFont = 'vcr.ttf'
local lyricsSize = 35
local lyricsY = 600
local lyricsColor = 'FF0000'
local iconX = 300
local IconY = 530
local lyricsTexts = {}
local lyricsIcon = {}
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
function lyrics(text, icon, leftORright)
IconPath = 'images/icons/icon-'..icon..'-lyrics.txt'
if checkFileExists('data/'..songPath..'/lyricalsettings.txt') == true then
lyricsFont = getTXTFileByLines('data/'..songPath..'/lyricalsettings', 1)
lyricsSize = getTXTFileByLines('data/'..songPath..'/lyricalsettings', 2)
lyricsY = getTXTFileByLines('data/'..songPath..'/lyricalsettings', 3)
else
debugPrint("ERROR: The TXT file for the song lyrics settings could not be found.", 'FF0000')
end
if checkFileExists(IconPath) == true then
lyricsColor = getTXTFileByLines('images/icons/icon-'..icon..'-lyrics', 1)
iconX = getTXTFileByLines('images/icons/icon-'..icon..'-lyrics', 2)
IconY = getTXTFileByLines('images/icons/icon-'..icon..'-lyrics', 3)
else
debugPrint("ERROR: Could not find icon settings TXT file.", 'FF0000')
end
textNum = textNum + 1
local ID = textNum
local newY = lyricsY - (textNum * 1)    
iconNum = iconNum + 1
local IDIicon = iconNum
local newYIcon = 600 - (iconNum * 1)

makeLuaText('lyrics_'..ID, text, 0, 0, newY)
setTextColor('lyrics_'..ID, ''..lyricsColor)
setTextSize('lyrics_'..ID, lyricsSize)
setTextFont('lyrics_'..ID, ''..lyricsFont)
setProperty('lyrics_'..ID..'.alpha', 1)
screenCenter('lyrics_'..ID, 'x')
setObjectCamera('lyrics_'..ID, 'camOther')
addLuaText('lyrics_'..ID)

makeLuaSprite('lyrics_icon_'..IDIicon, nil, 0, 530)
loadGraphic('lyrics_icon_'..IDIicon, 'icons/icon-'..icon, 150, 150)
setObjectCamera('lyrics_icon_'..IDIicon, 'camOther')
setProperty('lyrics_icon_'..IDIicon..'.alpha', 1)
addLuaSprite('lyrics_icon_'..IDIicon, false)

table.insert(lyricsTexts, 'lyrics_'..ID)
table.insert(lyricsIcon, 'lyrics_icon_'..IDIicon)
if leftORright == 'dad' then
setProperty('lyrics_icon_'..IDIicon..'.x', getProperty('lyrics_'..ID..'.width') * iconX + 500)
elseif leftORright == 'boyfriend' then
setProperty('lyrics_icon_'..IDIicon..'.flipX', true)
setProperty('lyrics_icon_'..IDIicon..'.x', getProperty('lyrics_'..ID..'.x') + getProperty('lyrics_'..ID..'.width') + iconX)
end
for i, textID in ipairs(lyricsTexts) do
if i < textNum then
local alpha = getProperty(textID .. '.alpha') - 0.4
if alpha < 0 then alpha = 0 end
setProperty(textID .. '.alpha', alpha)
end
doTweenY('Y_'..textID, textID, getProperty(textID..'.y') - 55, 0.5, 'QuadOut')
end
for i, IconID in ipairs(lyricsIcon) do
if i < iconNum then
local alpha = getProperty(IconID .. '.alpha') - 0.4
if alpha < 0 then alpha = 0 end
setProperty(IconID..'.alpha', alpha)
end
doTweenY('Yicon_'..IconID, IconID, getProperty(IconID..'.y') - 55, 0.5, 'QuadOut')
end
end
function lyricsHide()
for i, textID in ipairs(lyricsTexts) do
doTweenAlpha(textID..'_alpha', textID, 0, 0.5, 'linear')
end
for i, IconID in ipairs(lyricsIcon) do
doTweenAlpha(IconID..'_alpha', IconID, 0, 0.5, 'linear')
end
end