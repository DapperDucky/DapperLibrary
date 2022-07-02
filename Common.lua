-- Simple Alien Core object list
AlienCores = {}
AlienCores[1]  = {Name = "AC1",  x = 13666000, y = 1622000, z = -46840000}
AlienCores[2]  = {Name = "AC2",  x = -45534000, y = -46878000, z = -739465}
AlienCores[3]  = {Name = "AC3",  x = 58166000, y = -52378000, z = -739465}
AlienCores[4]  = {Name = "AC4",  x = 33946000, y = 71381990, z = 28850000}
AlienCores[5]  = {Name = "AC5",  x = -64334000, y = 55522000, z = -14400000}
AlienCores[6]  = {Name = "AC6",  x = 81766000, y = 16912000, z = 23860000}
AlienCores[7]  = {Name = "AC7",  x = 48566000, y = 19622000, z = 101000000}
AlienCores[8]  = {Name = "AC8",  x = -73134000, y = 18722000, z = -93700000}
AlienCores[9]  = {Name = "AC9",  x = -145634000, y = -10578000, z = -739465}
AlienCores[10] = {Name = "AC10", x = 966000, y = -149278000, z = -739465}

-- EX:
for k,v in ipairs(AlienCores) do
   ---Do something... 
end

-- Simpel Space Market objects lsit
Markets = {}
Markets[1] = {Name = "Aegis", x = 13856701.7693, y = 7386301.6554, z = -258251.0307, r = 1, g = 1.0, s = 0.0}

-- EX: 
for k,v in ipairs(Markets) do
   ---Do something... 
end

-- Save zone
-- TODO: Expand to contain the safezones of or figure out if there is some common multiplier that determins safezones for outer planets
SafeZone = {x = 13771471, y = 7435803, z = -128971, r = 18000000}

-- Simple function to emulate a ternary operator
function Ternary(c,x,y) if c then return x else return y end end

-- Get the distance between to objects in 3d space
function GetDistnace(o,d) return math.abs(math.sqrt((o.x - d.x)^2 + (o.y - d.y)^2 + (o.z - d.z)^2)) end

-- Creates a simple vector 4 object
function ToVec4(a,b,c,d) return {x = a, y = b, z = c, r = d} end

-- Creates a simple RGBA object
function ToColor(w,x,y,z) return {r = w, g = x, b = y, o = z} end

-- return the number that is the given percentage of the given whole
function NumFromPrec(p,w) return math.floor((p/100)*w) end

-- splits a deleminited string
function Split(s, d)
    result = {};
    for match in (s..d):gmatch("(.-)"..d) do
        table.insert(result, match);
    end
    return result;
end

-- A pretty time string
function GetCurrentTimeString()
   local allseconds = math.floor(system.getTime() - (offset * 3600))
   local daySeconds = math.floor(allseconds % 86400)
   local hoursPassed = Ternary(Use24HourClock,math.floor(daySeconds / 3600),math.floor(math.floor(daySeconds / 3600) % 12))
   local minutesPassed = math.floor((daySeconds % 3600) / 60)
   local secondsPassed = math.floor((daySeconds % 3600) % 60)
   return string.format("%02d",hoursPassed) .. ":" .. string.format("%02d",minutesPassed) .. ":" .. string.format("%02d",secondsPassed)
end

-- Does the text contain the pattern
function Contains(text,pattern) return string.match(' '..text..' ', '%A'..pattern..'%A') ~= nil end

-- Takes a waypoint string and transforms it into a value that can be used in calculations
function GetSpaceVectorFromWaypoint(waypoint)
    waypoint = waypoint:gsub('%dsat', '')
    waypoint = waypoint:gsub('% ', '')
    waypoint = waypoint:gsub('%:', '')
    waypoint = waypoint:gsub('%pos', '')
    waypoint = waypoint:gsub('%{', '')
    waypoint = waypoint:gsub('%}', '')
    waypoint = waypoint:gsub('%.0000', '')
    return Split(waypoint,',')
end

-- An object that represents the the DU camaera
-- def needs refined
Camera = 
{
    View = {IsFirstPerson = false, Mode = 1, HorizontalFov = 0, VerticalFov = 0},
    Pos = {x = 0, y = 0, z = 0},
    WorldPos = {x = 0, y = 0, z = 0},
    Rotation = { TACO = {x = 0, y = 0, z = 0}, Forward = {x = 0, y = 0, z = 0}}
}

function UpdateCamera()
   Camera.View.IsFirstPerson = system.isFirstPerson()
   Camera.View.Mode = system.getCameraMode()
   Camera.View.HorizontalFov = system.getCameraHorizontalFov()
   Camera.View.VerticalFov = system.getCameraVerticalFov()
   Camera.Pos = vec3(system.getCameraPos())
   Camera.WorldPos = vec3(system.getCameraWorldPos())
end

-- Get the speed from velocity
function GetSpeed()
    local vel = vec3(core.getVelocity())
    return math.floor(math.floor(math.sqrt((vel.x^2)+(vel.y^2)+(vel.z^2))) * 3600)
end

-- Build a configurable svg text element
function DisplayText(t,x,y,s,a,w,r,g,b,d)
    return Ternary(d,'<text x="'..x..'" y="'..y..'" text-anchor="'..a..'" font-size="'..s..'" fill="rgb('..r..','..g..','..b..')" font-weight="'..w..'">'..t..'</text>','')
end

-- Take a vector 3 and build a waypoint string
function BuildWaypoint(waypoint) return '::pos{0,'..waypoint.Planet..','..waypoint.X..','..waypoint.Y..','..waypoint.Z..'}' end

-- Makes certian high percision values more user friends when displayed
function ReadableFloat(n) return math.floor(n*100) end
-- EX: 0.12378683467483 becomes 12

-- Prevents values from exceeding a lower limit
function Limit(n) if n < 0.01 then return 0 else return n end end
