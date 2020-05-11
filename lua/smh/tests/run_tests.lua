function smhInclude(path)
    local rootPath = os.getenv("SMH_PATH")
    if rootPath == nil then
        error("SMH_PATH is undefined")
    end
    return dofile(rootPath .. path)
end

function includeMock(path)
    return smhInclude("/smh/tests/mocks" .. path)
end

function math.Round(value)
    local fraction = math.floor(value) - value
    if fraction >= 0.5 then
        return math.ceil(value)
    else
        return math.floor(value)
    end
end

-- GMOD constants
MOUSE_LEFT = 107
MOUSE_RIGHT = 108
MOUSE_MIDDLE = 109

LU = smhInclude("/smh/tests/luaunit.lua")
Ludi = smhInclude("/smh/submodules/ludi/ludi.lua")

local testFiles = {
    "implementations/ui/frame_pointer_test.lua",
    "implementations/entity_highlighter_test.lua",
    "implementations/entity_selector_test.lua",
}

for _, f in pairs(testFiles) do
    smhInclude("/smh/tests/" .. f)
end

local runner = LU.LuaUnit.new()
runner:setOutputType("tap")
os.exit(runner:runSuite())