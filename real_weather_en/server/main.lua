local data
local ws
local wd
local state
local api_url = "http://api.openweathermap.org/data/2.5/weather?q="..Config.city.."&units=metric&appid="..Config.appid

Citizen.CreateThread(function()
    while true do
    syncWeather()
    Citizen.Wait(60000)
    end
end)

function syncWeather()
    PerformHttpRequest(api_url, function (errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            data = json.decode(resultData)
            state = data.weather[1].id
            ws = data.wind.speed
            wd = data.wind.deg
        end
    end)
end

RegisterServerEvent("real_weather:syncWeatherOnSpawn")
AddEventHandler("real_weather:syncWeatherOnSpawn", function()
    TriggerClientEvent("real_weather:setWeather", source, state, ws, wd)
end)