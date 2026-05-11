--This is a very basic example, you can also use the functions in other scripts or put new functions in the lua_lyrics script to do something specific thing or change something that you see necessary
function onCreate()
addLuaScript('extras_scripts/lua_lyrics')
end
function onEvent(n, v1, v2)
if n == 'lyrics_bf' then
if v1 == '' and v2 == '' then
callScript('extras_scripts/lua_lyrics', 'lyricsHide')
else
callScript('extras_scripts/lua_lyrics', 'lyrics', {v1, v2, 'boyfriend'})
end
end
end