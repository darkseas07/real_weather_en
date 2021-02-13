local weathers = {
	[200] = {
		type = "THUNDER",
		rain = 0.1
	},
	[201] = {
		type = "THUNDER",
		rain = 0.3
	},
	[202] = {
		type = "THUNDER",
		rain = 0.7
	},
	[210] = {
		type = "THUNDER",
		rain = -1
	},
	[211] = {
		type = "THUNDER",
		rain = -1
	},
	[212] = {
		type = "THUNDER",
		rain = -1
	},
	[221] = {
		type = "THUNDER",
		rain = -1
	},
	[230] = {
		type = "THUNDER",
		rain = -1
	},
	[231] = {
		type = "THUNDER",
		rain = -1
	},
	[232] = {
		type = "THUNDER",
		rain = -1
	},
	[300] = {
		type = "RAIN",
		rain = 0.1
	},
	[301] = {
		type = "RAIN",
		rain = 0.2
	},
	[302] = {
		type = "RAIN",
		rain = 0.3
	},
	[310] = {
		type = "RAIN",
		rain = 0.3
	},
	[311] = {
		type = "RAIN",
		rain = 0.3
	},
	[312] = {
		type = "RAIN",
		rain = 0.3
	},
	[313] = {
		type = "RAIN",
		rain = 0.3
	},
	[314] = {
		type = "RAIN",
		rain = 0.3
	},
	[321] = {
		type = "RAIN",
		rain = 0.3
	},
	[500] = {
		type = "RAIN",
		rain = 0.2
	},
	[501] = {
		type = "RAIN",
		rain = 0.4
	},
	[502] = {
		type = "RAIN",
		rain = 0.7
	},
	[503] = {
		type = "RAIN",
		rain = 0.8
	},
	[504] = {
		type = "RAIN",
		rain = 0.9
	},
	[511] = {
		type = "RAIN",
		rain = 1.0
	},
	[520] = {
		type = "RAIN",
		rain = 1.0
	},
	[521] = {
		type = "RAIN",
		rain = 1.0
	},
	[522] = {
		type = "RAIN",
		rain = 1.0
	},
	[531] = {
		type = "RAIN",
		rain = 1.0
	},
	[600] = {
		type = "XMAS",
		rain = -1
	},
	[601] = {
		type = "XMAS",
		rain = -1
	},
	[602] = {
		type = "XMAS",
		rain = -1
	},
	[611] = {
		type = "XMAS",
		rain = -1
	},
	[612] = {
		type = "XMAS",
		rain = -1
	},
	[613] = {
		type = "SNOWLIGHT",
		rain = 0.2
	},
	[615] = {
		type = "SNOWLIGHT",
		rain = 0.4
	},
	[616] = {
		type = "SNOWLIGHT",
		rain = 1
	},
	[620] = {
		type = "BLIZZARD",
		rain = -1
	},
	[621] = {
		type = "BLIZZARD",
		rain = -1
	},
	[622] = {
		type = "BLIZZARD",
		rain = -1
	},
	[701] = {
		type = "FOGGY",
		rain = -1
	},
	[711] = {
		type = "FOGGY",
		rain = -1
	},
	[711] = {
		type = "FOGGY",
		rain = -1
	},
	[721] = {
		type = "FOGGY",
		rain = -1
	},
	[731] = {
		type = "FOGGY",
		rain = -1
	},
	[741] = {
		type = "FOGGY",
		rain = -1
	},
	[751] = {
		type = "FOGGY",
		rain = -1
	},
	[761] = {
		type = "FOGGY",
		rain = -1
	},
	[762] = {
		type = "FOGGY",
		rain = -1
	},
	[771] = {
		type = "FOGGY",
		rain = -1
	},
	[781] = {
		type = "FOGGY",
		rain = -1
	},
	[800] = {
		type = "CLEAR",
		rain = -1
	},
	[801] = {
		type = "CLEAR",
		rain = -1
	},
	[802] = {
		type = "CLEAR",
		rain = -1
	},
	[803] = {
		type = "OVERCAST",
		rain = -1
	},
	[804] = {
		type = "OVERCAST",
		rain = -1
	},
}

local curWeather = weathers[802].type
local state
local ws
local wd
local rain

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	while true do
		if curWeather ~= state then
			curWeather = state
			SetWeatherTypeOverTime(curWeather, 15.0)
			SetRainLevel(rain)
			Citizen.Wait(5000)
		end
		Citizen.Wait(10)
		ClearOverrideWeather()
        ClearWeatherTypePersist()
		SetWeatherTypePersist(curWeather)
        SetWeatherTypeNow(curWeather)
        SetWeatherTypeNowPersist(curWeather)
		SetRainLevel(rain)
		if ws and state ~= nil then
			if ws > 0.0 then
				SetWindSpeed(ws)
				SetWindDirection(wd)
			else
				SetWindSpeed(0.0)
				SetWindDirection(0.0)
			end
		end
		if curWeather == 'XMAS' then
			SetForceVehicleTrails(true)
			SetForcePedFootstepsTracks(true)
		else
			SetForceVehicleTrails(false)
			SetForcePedFootstepsTracks(false)
		end
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent("real_weather:setWeather")
AddEventHandler("real_weather:setWeather", function(st, wS, wD)
ws = wS
wd = wD
state = weathers[tonumber(st)].type
rain = weathers[tonumber(st)].rain
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("real_weather:syncWeatherOnSpawn")
end)