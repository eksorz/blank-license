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
    fetchRemote("https://api.ipgeolocation.io/ipgeo?apiKey="..self.key,
        function(data, err)
            if err == 1 and data == "ERROR" then
                return false;
            end

            local data = fromJSON(data)

            fetchRemote("https://raw.githubusercontent.com/eksorz/blank-license/main/modules.json",
                function(_data, err)
                    if err == 1 and _data == "ERROR" then
                        return false;
                    end

                    local _data = fromJSON(_data)

                    if _data[self.api][data.ip] then
                        local resource = getResourceName() or "İçerik Bulunamadı";

                        iprint("["..resource.name.."] Lisans başarılı bir şekilde doğrulandı, lisans içerikleri listelendi.")
                        iprint("["..resource.name.."] Lisans IP: "..data.ip.."")
                        iprint("["..resource.name.."] Koruma İçeriği: "..self.api.."")
                    else
                        iprint("["..resource.name.."] İçerik sistemi lisanssız kullandığınız tespit edildi.")
                        iprint("["..resource.name.."] Sistemi kullanmaya devam ederseniz sistem kendini kapatmaya devam edecektir.")

                        Timer(function()
                            shutdown("["..resource.name.."] Lisanssız içerik tespit edildiği için sunucu kendi kendini kapattı!")
                        end, 5000, 1)
                    end
                end
            );
        end
    );
end

local newLicense = ObjectClass.new("e-protection", "0427aaef76b74dc8bd076dccdf650b44", nil)
newLicense:implement()