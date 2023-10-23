local ObjectClass = {}

function ObjectClass.new(api, key, link)
    local newObject = {
        api = api;
        key = key;
        link = link;
    }

    local self = setmetatable(newObject, self)
    self.__index = self

    return newObject;
end

setmetatable(ObjectClass, {
    __call = function()
        print("License is being implemented.")
    end
})

function ObjectClass:implement()
    fetchRemote(""..self.key,
        function(data, err)
            if err == 1 and data == "ERROR" then
                return false;
            end

            local data = fromJSON(data)

            fetchRemote("",
                function(_data, err)
                    if err == 1 and _data == "ERROR" then
                        return false;
                    end

                    local _data = fromJSON(_data)

                    if not _data[self.api][data.ip] then
                        return shutdown(), ObjectClass()
                    end
                end
            );
        end
    );
end

local foo = ObjectClass.new("example", "example", nil) -- Created object.
foo:implement() -- Foo object's application function.
