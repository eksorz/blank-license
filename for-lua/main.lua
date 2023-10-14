local ObjectClass = {}
ObjectClass.__index = ObjectClass;

function ObjectClass.new(api, key, link)
    local self = setmetatable({}, ObjectClass)

    self.api = api
    self.key = key
    self.link = link

    return self;
end

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
                        shutdown()
                    end
                end
            );
        end
    );
end
