function debug(content)
    local file, err = io.open("/tmp/lua_debug.txt", "a")
    if file == nil then
        error("Couldn't open file: "..err)
    else
        file:write(content.."\n")
        file:close()
    end
end

function print_var(var)
    local inspect = require("inspect")  -- The inspect library needs to be installed separately https://github.com/kikito/inspect.lua
    local vars = inspect(m.getvars(var))
    debug(vars)
end

function main()

    debug("========debug start=======")

    print_var("MULTIPART_NAME")
    print_var("FILES")
    print_var("ARGS")
    print_var("PATH_INFO")

    debug("========debug end=======")
    return nil;
end