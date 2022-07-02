-- Available Font Styles
    FontStyles = {}
    FontStyles[1]  = 'FiraMono'
    FontStyles[2]  = 'FiraMono-Bold'
    FontStyles[3]  = 'Montserrat'
    FontStyles[4]  = 'Montserrat-Light'
    FontStyles[5]  = 'Montserrat-Bold'
    FontStyles[6]  = 'Play'
    FontStyles[7]  = 'Play-Bold'
    FontStyles[8]  = 'RefrigeratorDeluxe'
    FontStyles[9]  = 'RefrigeratorDeluxe-Light'
    FontStyles[10] = 'RobotoCondensed'
    FontStyles[11] = 'RobotoMono'
    FontStyles[12] = 'RobotoMono-Bold'

-- Getting the details
-- Screens don't typically change so just popualte the object on init
Screen = { }

function GetScreen(w,h) 
  Screen = {x = w, y = h, Half = {x = math.floor(w/2), y = math.floor(h/2)}, MaxLength = Ternary(w>h,w,h), HalfMaxLength = Ternary(w>h, w/2, h/2)} 
end

-- Getting the mouse object
-- This should be called once a frame
function GetMouse()
    local mx, my = getCursor()
    Mouse = {x = mx, y = my, Down = getCursorDown(), Release = getCursorReleased()}
end

-- Wrapper for builng a singel line of text
function DisplayText(layer, fnt, text, x, y, alignH, alignV, color)
    setNextFillColor(layer, color.r, color.g, color.b, color.o)
    setNextTextAlign(layer, alignH, alignV)
    addText(layer, fnt, text, x, y)
end

-- Wrapper for building a singel box
function DisplayBox(layer, x, y, w, h, fill, shadow, blur, round, stroke, strokeWidth)
    if stroke ~= nil then setNextStrokeColor(layer, stroke.r, stroke.g, stroke.b, stroke.o) end
    if strokeWidth ~= nil then setNextStrokeWidth(layer, strokeWidth) end
    if shadow ~= nil then setNextShadow(layer, blur, shadow.r, shadow.g, shadow.b, shadow.o) end
    if fill ~= nil then setNextFillColor(layer, fill.r, fill.g, fill.b, fill.o) end
    if round ~= nil then addBoxRounded(layer, x, y, w, h, round) else addBox(layer, x, y, w, h) end
end

-- Common useful functions
--Creates a simple vector 4
function ToVec4(a,b,c,d) return {w = a, x = b, y = c, z = d} end

-- Created a simple RGBA Color obejct 
function ToColor(w,x,y,z) return {r = w, g = x, b = y, o = z} end

-- Rotate points in 3D space
function RotateX(a, p) return {x = p.x, y = p.y * math.cos(a) - p.z * math.sin(a), z = p.z * math.cos(a) + p.y * math.sin(a)} end
function RotateY(a, p) return {x = p.x * math.cos(a) - p.z * math.sin(a), y = p.y, z = p.z * math.cos(a) + p.x * math.sin(a)} end
function RotateZ(a, p) return {x = p.x * math.cos(a) - p.y * math.sin(a), y = p.y * math.cos(a) + p.x * math.sin(a), z = p.z} end

function RotatePoints(xa, ya, za, p)
      p = RotateX(xa, p)
      p = RotateY(ya, p)
      p = RotateZ(za, p)
      return p
  end

-- Builds a configurable button on the screen
function BuildButton(layer, text, fontT, pressed, x)
    DisplayBox(layer, 20, x, 24, 24, ToColor(.2, .2, .2, 1), shadow, blur, 1, ToColor(.1, .1, .1, 1), 5)
    if pressed then DisplayBox(layer, 22, x + 2, 20, 20, ToColor(1, 1, 0, 1), ToColor(1, 1, 0, 1), 4, 1) end
    DisplayText(layer, fontT, text, 55, x + 12, AlignH_Left, AlignV_Middle, ToColor(.8, .8, .8, 1))
end

-- EX: of builing a button and the event it is tied to
if Mouse.Release and math.abs(32 - Mouse.x) < 12 and math.abs(239 - Mouse.y) < 12 then ShowPlayer = not ShowPlayer end
BuildButton(infolayer, "Show Player", font, ShowPlayer, 225)
