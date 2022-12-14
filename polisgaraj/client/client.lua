local QBCore = exports['qb-core']:GetCoreObject()

local InPreview = false

local garajKordinat = vector4(433.95, -995.2, 25.14, 178.36) -- PD
local pdGarajSpawn = vector4(592.04, -11.54, 70.63, 352.03)

local InMenu = false

PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
	end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

AddEventHandler('onClientResourceStart',function(resource)
	if GetCurrentResourceName() == resource then
		Citizen.CreateThread(function()
			while true do
				QBCore.Functions.GetPlayerData(function(PlayerData)
					if PlayerData.job then
						PlayerJob = PlayerData.job
					end
				end)
				break
			end
			Citizen.Wait(1)
		end)
	end
end)

local function InZone()
    for k, v in pairs(Config.RepairLocations) do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.coords.x, v.coords.y, v.coords.z, false) < v.distance ) then
            return true
        end
        return false
    end
end

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent(':Menu', function()
    local Menu = {
        {
            header = "Polis Garajı",
            txt = "Araçları Görüntüle",
            params = {
                event = ":Catalog",
            }
        }
    }
    if not Config.UseMarkerInsteadOfMenu then
        Menu[#Menu+1] = {
            header = "⬅ Aracı Koy",
            params = {
                event = ":StoreVehicle"
            }
        }
    end
    Menu[#Menu+1] = {
        header = "⬅ Kapat",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)


RegisterNetEvent('CL-emsGarage:Menu', function()
    local Menu = {
        {
            header = "Ems Garajı",
            txt = "Araçları Görüntüle",
            params = {
                event = "CL-emsGarage:Catalog",
            }
        }
    }
    Menu[#Menu+1] = {
        header = "Araç Önizlemesi",
        txt = "Aracı İncele",
        params = {
            event = "CL-emsGarage:PreviewCarMenu",
        }
    }
    if not Config.UseMarkerInsteadOfMenu then
        Menu[#Menu+1] = {
            header = "⬅ Aracı Koy",
            params = {
                event = "CL-emsGarage:StoreVehicle"
            }
        }
    end
    Menu[#Menu+1] = {
        header = "⬅ Kapat",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)


RegisterNetEvent('CL-emsHeli:Menu', function()
    local Menu = {
        {
            header = "Ems Garajı",
            txt = "Araçları Görüntüle",
            params = {
                event = "CL-emsHeli:Catalog",
            }
        }
    }
    Menu[#Menu+1] = {
        header = "Araç Önizlemesi",
        txt = "Aracı İncele",
        params = {
            event = "CL-emsHeli:PreviewCarMenu",
        }
    }
    if not Config.UseMarkerInsteadOfMenu then
        Menu[#Menu+1] = {
            header = "⬅ Aracı Koy",
            params = {
                event = "CL-emsHeli:StoreVehicle"
            }
        }
    end
    Menu[#Menu+1] = {
        header = "⬅ Kapat",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)


RegisterNetEvent('CL-pdHeli:Menu', function()
    local Menu = {
        {
            header = "Pd Garajı",
            txt = "Araçları Görüntüle",
            params = {
                event = "CL-pdHeli:Catalog",
            }
        }
    }
    Menu[#Menu+1] = {
        header = "Araç Önizlemesi",
        txt = "Aracı İncele",
        params = {
            event = "CL-pdHeli:PreviewCarMenu",
        }
    }
    if not Config.UseMarkerInsteadOfMenu then
        Menu[#Menu+1] = {
            header = "⬅ Aracı Koy",
            params = {
                event = "CL-pdHeli:StoreVehicle"
            }
        }
    end
    Menu[#Menu+1] = {
        header = "⬅ Kapat",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent(":Catalog", function()
    local vehicleMenu = {
        {
            header = "Polis Garajı",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Vehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.vehiclename,
            txt = "" .. v.vehiclename .. " adlı aracı " .. v.price .. "$ fiyata satın al",
            params = {
                event = ":ChoosePayment",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = ":Menu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent("CL-emsGarage:Catalog", function()
    local vehicleMenu = {
        {
            header = "Ems Garajı",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Vehicles1) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.vehiclename,
            txt = "" .. v.vehiclename .. " adlı aracı " .. v.price .. "$ fiyata satın al",
            params = {
                event = "CL-emsGarage:ChoosePayment",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = "CL-emsGarage:Menu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)


RegisterNetEvent("CL-emsHeli:Catalog", function()
    local vehicleMenu = {
        {
            header = "Ems Garajı",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Vehicles2) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.vehiclename,
            txt = "" .. v.vehiclename .. " adlı aracı " .. v.price .. "$ fiyata satın al",
            params = {
                event = "CL-emsHeli:ChoosePayment",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = "CL-emsHeli:Menu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent("CL-pdHeli:Catalog", function()
    local vehicleMenu = {
        {
            header = "PD Garajı",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Vehicles3) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v.vehiclename,
            txt = "" .. v.vehiclename .. " adlı aracı " .. v.price .. "$ fiyata satın al",
            params = {
                event = "CL-pdHeli:ChoosePayment",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = "CL-pdHeli:Menu"
        }
    }
    exports['qb-menu']:openMenu(vehicleMenu)
end)

RegisterNetEvent(":ChoosePayment", function(data)
    local Payment = exports["qb-input"]:ShowInput({
        header = "Choose Payment Method",
        submitText = "Seç",
        inputs = {
            { 
                text = 'Ödeme Yöntemi', 
                name = 'paymenttype', 
                type = 'radio', 
                isRequired = true,
                options = { 
                    { 
                        value = "cash", 
                        text = "Nakit" 
                    }, 
                    { 
                        value = "bank", 
                        text = "Banka" 
                    } 
                } 
            }
        }
    })
    if Payment ~= nil then
        TriggerServerEvent(":TakeMoney", Payment.paymenttype, data.price, data.vehiclename, data.vehicle) 
    end
end)

RegisterNetEvent("CL-emsGarage:ChoosePayment", function(data)
    local Payment = exports["qb-input"]:ShowInput({
        header = "Choose Payment Method",
        submitText = "Seç",
        inputs = {
            { 
                text = 'Ödeme Yöntemi', 
                name = 'paymenttype', 
                type = 'radio', 
                isRequired = true,
                options = { 
                    { 
                        value = "cash", 
                        text = "Nakit" 
                    }, 
                    { 
                        value = "bank", 
                        text = "Banka" 
                    } 
                } 
            }
        }
    })
    if Payment ~= nil then
        TriggerServerEvent("CL-emsGarage:TakeMoney", Payment.paymenttype, data.price, data.vehiclename, data.vehicle) 
    end
end)


RegisterNetEvent("CL-emsHeli:ChoosePayment", function(data)
    local Payment = exports["qb-input"]:ShowInput({
        header = "Choose Payment Method",
        submitText = "Seç",
        inputs = {
            { 
                text = 'Ödeme Yöntemi', 
                name = 'paymenttype', 
                type = 'radio', 
                isRequired = true,
                options = { 
                    { 
                        value = "cash", 
                        text = "Nakit" 
                    }, 
                    { 
                        value = "bank", 
                        text = "Banka" 
                    } 
                } 
            }
        }
    })
    if Payment ~= nil then
        TriggerServerEvent("CL-emsHeli:TakeMoney", Payment.paymenttype, data.price, data.vehiclename, data.vehicle) 
    end
end)


RegisterNetEvent("CL-pdHeli:ChoosePayment", function(data)
    local Payment = exports["qb-input"]:ShowInput({
        header = "Choose Payment Method",
        submitText = "Seç",
        inputs = {
            { 
                text = 'Ödeme Yöntemi', 
                name = 'paymenttype', 
                type = 'radio', 
                isRequired = true,
                options = { 
                    { 
                        value = "cash", 
                        text = "Nakit" 
                    }, 
                    { 
                        value = "bank", 
                        text = "Banka" 
                    } 
                } 
            }
        }
    })
    if Payment ~= nil then
        TriggerServerEvent("CL-pdHeli:TakeMoney", Payment.paymenttype, data.price, data.vehiclename, data.vehicle) 
    end
end)


RegisterNetEvent(':PreviewCarMenu', function()
    local PreviewMenu = {
        {
            header = "Önizleme",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.Vehicles) do
        PreviewMenu[#PreviewMenu+1] = {
            header = v.vehiclename,
            txt = "Önizle: " .. v.vehiclename,
            params = {
                event = ":PreviewVehicle",
                args = {
                    vehicle = v.vehicle,
                }
            }
        }
    end
    PreviewMenu[#PreviewMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = ":Menu"
        }
    }
    exports['qb-menu']:openMenu(PreviewMenu)
end)

RegisterNetEvent('CL-emsGarage:PreviewCarMenu', function()
    local PreviewMenu = {
        {
            header = "Önizleme",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.Vehicles1) do
        PreviewMenu[#PreviewMenu+1] = {
            header = v.vehiclename,
            txt = "Önizle: " .. v.vehiclename,
            params = {
                event = "CL-emsGarage:PreviewVehicle",
                args = {
                    vehicle = v.vehicle,
                }
            }
        }
    end
    PreviewMenu[#PreviewMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = "CL-emsGarage:Menu"
        }
    }
    exports['qb-menu']:openMenu(PreviewMenu)
end)


RegisterNetEvent('CL-emsHeli:PreviewCarMenu', function()
    local PreviewMenu = {
        {
            header = "Önizleme",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.Vehicles2) do
        PreviewMenu[#PreviewMenu+1] = {
            header = v.vehiclename,
            txt = "Önizle: " .. v.vehiclename,
            params = {
                event = "CL-emsHeli:PreviewVehicle",
                args = {
                    vehicle = v.vehicle,
                }
            }
        }
    end
    PreviewMenu[#PreviewMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = "CL-emsHeli:Menu"
        }
    }
    exports['qb-menu']:openMenu(PreviewMenu)
end)


RegisterNetEvent('CL-pdHeli:PreviewCarMenu', function()
    local PreviewMenu = {
        {
            header = "Önizleme",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.Vehicles3) do
        PreviewMenu[#PreviewMenu+1] = {
            header = v.vehiclename,
            txt = "Önizle: " .. v.vehiclename,
            params = {
                event = "CL-pdHeli:PreviewVehicle",
                args = {
                    vehicle = v.vehicle,
                }
            }
        }
    end
    PreviewMenu[#PreviewMenu+1] = {
        header = "⬅ Geri",
        params = {
            event = "CL-pdHeli:Menu"
        }
    }
    exports['qb-menu']:openMenu(PreviewMenu)
end)
-- CreateThread(function()
--     while true do
--         local plyPed = PlayerPedId()
--         local plyCoords = GetEntityCoords(plyPed) 
--         local letSleep = true

--         if PlayerJob.name == Config.Job then
--             if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.78894, -1020.011, 28.225797, true) < 10) then
--                 letSleep = false
--                 DrawMarker(36, 441.78894, -1020.011, 28.225797 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, 0, 0, 0, 255, true, false, false, true, false, false, false)
--                 if Config.UseMarkerInsteadOfMenu then
--                     if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.78894, -1020.011, 28.225797, true) < 1.5) and not IsPedInAnyVehicle(PlayerPedId(), false) then
--                         DrawText3D(441.78894, -1020.011, 28.225797, "~g~E~w~ - Police Garage") 
--                         if IsControlJustReleased(0, 38) then
--                             TriggerEvent(":Menu")
--                         end
--                     end
--                     if IsPedInAnyVehicle(PlayerPedId(), false) then   
--                         DrawText3D(441.78894, -1020.011, 28.225797, "~g~E~w~ - Store Vehicle (Will Get Impounded)") 
--                     end
--                     if IsControlJustReleased(0, 38) and IsPedInAnyVehicle(PlayerPedId(), false) then
--                         TriggerEvent(":StoreVehicle")
--                     end
--                 else
--                     if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 441.78894, -1020.011, 28.225797, true) < 1.5) then
--                         DrawText3D(441.78894, -1020.011, 28.225797, "~g~E~w~ - Police Garage") 
--                         if IsControlJustReleased(0, 38) then
--                             TriggerEvent(":Menu")
--                         end
--                     end
--                 end
--             end
--         end

--         if letSleep then
--             Wait(2000)
--         end

--         Wait(1)
--     end
-- end)

RegisterNetEvent(':client:SetActive', function(status)
    InMenu = status
end)

RegisterNetEvent(':StoreVehicle', function()
    local ped = PlayerPedId()
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    if IsPedInAnyVehicle(ped, false) then
        TaskLeaveVehicle(ped, car, 1)
        Citizen.Wait(2000)
        QBCore.Functions.Notify('Araç garaja gönderildi!')
        DeleteVehicle(car)
        DeleteEntity(car)
    else
        QBCore.Functions.Notify("Araçta değilsin!", "error")
    end
end)

RegisterNetEvent(":SpawnVehicle", function(vehicle)
    local coords = pdGarajSpawn
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        local VehicleProps = QBCore.Functions.GetVehicleProperties(veh)
        SetVehicleNumberPlateText(veh, "PD"..tostring(math.random(1000, 9999)))
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        TriggerServerEvent(":AddVehicleSQL", VehicleProps, vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh))
    end, coords, true)
end)

RegisterNetEvent("CL-emsGarage:SpawnVehicle", function(vehicle)
    local coords = vector4(326.45, -547.31, 28.74, 265.67)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        local VehicleProps = QBCore.Functions.GetVehicleProperties(veh)
        SetVehicleNumberPlateText(veh, "EMS"..tostring(math.random(1000, 9999)))
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        TriggerServerEvent("CL-emsGarage:AddVehicleSQL", VehicleProps, vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh))
    end, coords, true)
end)


RegisterNetEvent("CL-emsHeli:SpawnVehicle", function(vehicle)
    local coords = vector4(351.45, -588.74, 74.16, 319.23)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        local VehicleProps = QBCore.Functions.GetVehicleProperties(veh)
        SetVehicleNumberPlateText(veh, "EMS"..tostring(math.random(1000, 9999)))
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        TriggerServerEvent("CL-emsHeli:AddVehicleSQL", VehicleProps, vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh))
    end, coords, true)
end)


RegisterNetEvent("CL-pdHeli:SpawnVehicle", function(vehicle)
    local coords = vector4(449.3, -981.35, 43.69, 87.14)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        local VehicleProps = QBCore.Functions.GetVehicleProperties(veh)
        SetVehicleNumberPlateText(veh, "PD"..tostring(math.random(1000, 9999)))
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        TriggerServerEvent("CL-pdHeli:AddVehicleSQL", VehicleProps, vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh))
    end, coords, true)
end)


RegisterNetEvent(":PreviewVehicle", function(data)
    if Config.UsePreviewMenuSync then
        QBCore.Functions.TriggerCallback(':CheckIfActive', function(result)
            if result then
                InPreview = true
                local coords = garajKordinat
                QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                    SetEntityVisible(PlayerPedId(), false, 1)
                    if Config.SetVehicleTransparency == 'low' then
                        SetEntityAlpha(veh, 400)
                    elseif Config.SetVehicleTransparency == 'medium' then
                        SetEntityAlpha(veh, 93)
                    elseif Config.SetVehicleTransparency == 'high' then
                        SetEntityAlpha(veh, 40)
                    elseif Config.SetVehicleTransparency == 'none' then
                        
                    end
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                    exports['LegacyFuel']:SetFuel(veh, 0.0)
                    FreezeEntityPosition(veh, true)
                    SetVehicleEngineOn(veh, false, false)
                    DoScreenFadeOut(200)
                    Citizen.Wait(500)
                    DoScreenFadeIn(200)
                    SetVehicleUndriveable(veh, true) 
                
                    VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 598.66, -8.01, 72.23, 50, 0.00, 282.17034, 0.58, false, 0)
                    SetCamActive(VehicleCam, true)
                    RenderScriptCams(true, true, 500, true, true)
            
                    Citizen.CreateThread(function()
                        while true do
                            if InPreview then
                                ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                            elseif not InPreview then
                                break
                            end
                            if IsControlJustReleased(0, 177) then
                                SetEntityVisible(PlayerPedId(), true, 1)
                                FreezeEntityPosition(PlayerPedId(), false)
                                PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                QBCore.Functions.DeleteVehicle(veh)
                                DoScreenFadeOut(200)
                                Citizen.Wait(500)
                                DoScreenFadeIn(200)
                                RenderScriptCams(false, false, 1, true, true)
                                InPreview = false
                                TriggerServerEvent(":server:SetActive", false)
                                break
                            end
                            Citizen.Wait(1)
                        end
                    end)
                end, coords, true)
            end
        end)
    else
        InPreview = true
        local coords = garajKordinat
        QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
            SetEntityVisible(PlayerPedId(), false, 1)
            if Config.SetVehicleTransparency == 'low' then
                SetEntityAlpha(veh, 400)
            elseif Config.SetVehicleTransparency == 'medium' then
                SetEntityAlpha(veh, 93)
            elseif Config.SetVehicleTransparency == 'high' then
                SetEntityAlpha(veh, 40)
            elseif Config.SetVehicleTransparency == 'none' then
                
            end
            FreezeEntityPosition(PlayerPedId(), true)
            SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
            exports['LegacyFuel']:SetFuel(veh, 0.0)
            FreezeEntityPosition(veh, true)
            SetVehicleEngineOn(veh, false, false)
            DoScreenFadeOut(200)
            Citizen.Wait(500)
            DoScreenFadeIn(200)
            SetVehicleUndriveable(veh, true)
        
            VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1075.48, -872.99, 5.3, 50, 0.00, 282.17034, 0.58, false, 0)
            SetCamActive(VehicleCam, true)
            RenderScriptCams(true, true, 500, true, true)
            
            Citizen.CreateThread(function()
                while true do
                    if InPreview then
                        ShowHelpNotification("~INPUT_FRONTEND_RRIGHT~ Kapat")
                    elseif not InPreview then
                        break
                    end
                    if IsControlJustReleased(0, 177) then
                        SetEntityVisible(PlayerPedId(), true, 1)
                        FreezeEntityPosition(PlayerPedId(), false)
                        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        QBCore.Functions.DeleteVehicle(veh)
                        DoScreenFadeOut(200)
                        Citizen.Wait(500)
                        DoScreenFadeIn(200)
                        RenderScriptCams(false, false, 1, true, true)
                        InPreview = false
                        TriggerServerEvent(":server:SetActive", false)
                        break
                    end
                    Citizen.Wait(1)
                end
            end)
        end, coords, true)
    end
end)

RegisterNetEvent("CL-emsGarage:PreviewVehicle", function(data)
    if Config.UsePreviewMenuSync then
        QBCore.Functions.TriggerCallback('CL-emsGarage:CheckIfActive', function(result)
            if result then
                InPreview = true
                local coords = vector4(328.98, -575.27, 28.8, 159.34)
                QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                    SetEntityVisible(PlayerPedId(), false, 1)
                    if Config.SetVehicleTransparency == 'low' then
                        SetEntityAlpha(veh, 400)
                    elseif Config.SetVehicleTransparency == 'medium' then
                        SetEntityAlpha(veh, 93)
                    elseif Config.SetVehicleTransparency == 'high' then
                        SetEntityAlpha(veh, 40)
                    elseif Config.SetVehicleTransparency == 'none' then

                    end
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                    exports['LegacyFuel']:SetFuel(veh, 0.0)
                    FreezeEntityPosition(veh, true)
                    SetVehicleEngineOn(veh, false, false)
                    DoScreenFadeOut(200)
                    Citizen.Wait(500)
                    DoScreenFadeIn(200)
                    SetVehicleUndriveable(veh, true) --

                    VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -837.77, -1289.9, 28.8, 15.6, 0.00, 282.17034, 80.00, false, 0)
                    SetCamActive(VehicleCam, true)
                    RenderScriptCams(true, true, 500, true, true)
            
                    Citizen.CreateThread(function()
                        while true do
                            if InPreview then
                                ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                            elseif not InPreview then
                                break
                            end
                            if IsControlJustReleased(0, 177) then
                                SetEntityVisible(PlayerPedId(), true, 1)
                                FreezeEntityPosition(PlayerPedId(), false)
                                PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                QBCore.Functions.DeleteVehicle(veh)
                                DoScreenFadeOut(200)
                                Citizen.Wait(500)
                                DoScreenFadeIn(200)
                                RenderScriptCams(false, false, 1, true, true)
                                InPreview = false
                                TriggerServerEvent("CL-emsGarage:server:SetActive", false)
                                break
                            end
                            Citizen.Wait(1)
                        end
                    end)
                end, coords, true)
            end
        end)
    else
        InPreview = true
        local coords = vector4(328.98, -575.27, 28.8, 159.34)
        QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
            SetEntityVisible(PlayerPedId(), false, 1)
            if Config.SetVehicleTransparency == 'low' then
                SetEntityAlpha(veh, 400)
            elseif Config.SetVehicleTransparency == 'medium' then
                SetEntityAlpha(veh, 93)
            elseif Config.SetVehicleTransparency == 'high' then
                SetEntityAlpha(veh, 40)
            elseif Config.SetVehicleTransparency == 'none' then
                
            end
            FreezeEntityPosition(PlayerPedId(), true)
            SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
            exports['LegacyFuel']:SetFuel(veh, 0.0)
            FreezeEntityPosition(veh, true)
            SetVehicleEngineOn(veh, false, false)
            DoScreenFadeOut(200)
            Citizen.Wait(500)
            DoScreenFadeIn(200)
            SetVehicleUndriveable(veh, true)
        
            VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 325.32, -577.58, 28.8, 50, 0.00, 282.17034, 80.00, 80.00, false, 0)
            SetCamActive(VehicleCam, true)
            RenderScriptCams(true, true, 500, true, true)
            
            Citizen.CreateThread(function()
                while true do
                    if InPreview then
                        ShowHelpNotification("~INPUT_FRONTEND_RRIGHT~ Kapat")
                    elseif not InPreview then
                        break
                    end
                    if IsControlJustReleased(0, 177) then
                        SetEntityVisible(PlayerPedId(), true, 1)
                        FreezeEntityPosition(PlayerPedId(), false)
                        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        QBCore.Functions.DeleteVehicle(veh)
                        DoScreenFadeOut(200)
                        Citizen.Wait(500)
                        DoScreenFadeIn(200)
                        RenderScriptCams(false, false, 1, true, true)
                        InPreview = false
                        TriggerServerEvent("CL-emsGarage:server:SetActive", false)
                        break
                    end
                    Citizen.Wait(1)
                end
            end)
        end, coords, true)
    end
end)

RegisterNetEvent("CL-emsHeli:PreviewVehicle", function(data)
    if Config.UsePreviewMenuSync then
        QBCore.Functions.TriggerCallback('CL-emsHeli:CheckIfActive', function(result)
            if result then
                InPreview = true
                local coords = vector4(351.18, -589.2, 74.16, 354.86)
                QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                    SetEntityVisible(PlayerPedId(), false, 1)
                    if Config.SetVehicleTransparency == 'low' then
                        SetEntityAlpha(veh, 400)
                    elseif Config.SetVehicleTransparency == 'medium' then
                        SetEntityAlpha(veh, 93)
                    elseif Config.SetVehicleTransparency == 'high' then
                        SetEntityAlpha(veh, 40)
                    elseif Config.SetVehicleTransparency == 'none' then

                    end
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                    exports['LegacyFuel']:SetFuel(veh, 0.0)
                    FreezeEntityPosition(veh, true)
                    SetVehicleEngineOn(veh, false, false)
                    DoScreenFadeOut(200)
                    Citizen.Wait(500)
                    DoScreenFadeIn(200)
                    SetVehicleUndriveable(veh, true)

                    VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 338.63, -584.54, 76.4, 50, 0.00, 282.17034, 80.00, false, 0)
                    SetCamActive(VehicleCam, true)
                    RenderScriptCams(true, true, 500, true, true)
            
                    Citizen.CreateThread(function()
                        while true do
                            if InPreview then
                                ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                            elseif not InPreview then
                                break
                            end
                            if IsControlJustReleased(0, 177) then
                                SetEntityVisible(PlayerPedId(), true, 1)
                                FreezeEntityPosition(PlayerPedId(), false)
                                PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                QBCore.Functions.DeleteVehicle(veh)
                                DoScreenFadeOut(200)
                                Citizen.Wait(500)
                                DoScreenFadeIn(200)
                                RenderScriptCams(false, false, 1, true, true)
                                InPreview = false
                                TriggerServerEvent("CL-emsHeli:server:SetActive", false)
                                break
                            end
                            Citizen.Wait(1)
                        end
                    end)
                end, coords, true)
            end
        end)
    else
        InPreview = true
        local coords = vector4(351.18, -589.2, 74.16, 354.86)
        QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
            SetEntityVisible(PlayerPedId(), false, 1)
            if Config.SetVehicleTransparency == 'low' then
                SetEntityAlpha(veh, 400)
            elseif Config.SetVehicleTransparency == 'medium' then
                SetEntityAlpha(veh, 93)
            elseif Config.SetVehicleTransparency == 'high' then
                SetEntityAlpha(veh, 40)
            elseif Config.SetVehicleTransparency == 'none' then
                
            end
            FreezeEntityPosition(PlayerPedId(), true)
            SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
            exports['LegacyFuel']:SetFuel(veh, 0.0)
            FreezeEntityPosition(veh, true)
            SetVehicleEngineOn(veh, false, false)
            DoScreenFadeOut(200)
            Citizen.Wait(500)
            DoScreenFadeIn(200)
            SetVehicleUndriveable(veh, true)
        
            VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 338.63, -584.54, 76.4, 50, 0.00, 282.17034, 80.00, 80.00, false, 0)
            SetCamActive(VehicleCam, true)
            RenderScriptCams(true, true, 500, true, true)
            
            Citizen.CreateThread(function()
                while true do
                    if InPreview then
                        ShowHelpNotification("~INPUT_FRONTEND_RRIGHT~ Kapat")
                    elseif not InPreview then
                        break
                    end
                    if IsControlJustReleased(0, 177) then
                        SetEntityVisible(PlayerPedId(), true, 1)
                        FreezeEntityPosition(PlayerPedId(), false)
                        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        QBCore.Functions.DeleteVehicle(veh)
                        DoScreenFadeOut(200)
                        Citizen.Wait(500)
                        DoScreenFadeIn(200)
                        RenderScriptCams(false, false, 1, true, true)
                        InPreview = false
                        TriggerServerEvent("CL-emsHeli:server:SetActive", false)
                        break
                    end
                    Citizen.Wait(1)
                end
            end)
        end, coords, true)
    end
end)


RegisterNetEvent("CL-pdHeli:PreviewVehicle", function(data)
    if Config.UsePreviewMenuSync then
        QBCore.Functions.TriggerCallback('CL-pdHeli:CheckIfActive', function(result)
            if result then
                InPreview = true
                local coords = vector4(449.3, -981.35, 43.69, 87.14)
                QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                    SetEntityVisible(PlayerPedId(), false, 1)
                    if Config.SetVehicleTransparency == 'low' then
                        SetEntityAlpha(veh, 400)
                    elseif Config.SetVehicleTransparency == 'medium' then
                        SetEntityAlpha(veh, 93)
                    elseif Config.SetVehicleTransparency == 'high' then
                        SetEntityAlpha(veh, 40)
                    elseif Config.SetVehicleTransparency == 'none' then

                    end
                    FreezeEntityPosition(PlayerPedId(), true)
                    SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                    exports['LegacyFuel']:SetFuel(veh, 0.0)
                    FreezeEntityPosition(veh, true)
                    SetVehicleEngineOn(veh, false, false)
                    DoScreenFadeOut(200)
                    Citizen.Wait(500)
                    DoScreenFadeIn(200)
                    SetVehicleUndriveable(veh, true)

                    VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 439.59, -987.72, 47.82, 50, 0.00, 282.17034, 80.00, false, 0)
                    SetCamActive(VehicleCam, true)
                    RenderScriptCams(true, true, 500, true, true)
            
                    Citizen.CreateThread(function()
                        while true do
                            if InPreview then
                                ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Close")
                            elseif not InPreview then
                                break
                            end
                            if IsControlJustReleased(0, 177) then
                                SetEntityVisible(PlayerPedId(), true, 1)
                                FreezeEntityPosition(PlayerPedId(), false)
                                PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                QBCore.Functions.DeleteVehicle(veh)
                                DoScreenFadeOut(200)
                                Citizen.Wait(500)
                                DoScreenFadeIn(200)
                                RenderScriptCams(false, false, 1, true, true)
                                InPreview = false
                                TriggerServerEvent("CL-pdHeli:server:SetActive", false)
                                break
                            end
                            Citizen.Wait(1)
                        end
                    end)
                end, coords, true)
            end
        end)
    else
        InPreview = true
        local coords = vector4(449.3, -981.35, 43.69, 87.14)
        QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
            SetEntityVisible(PlayerPedId(), false, 1)
            if Config.SetVehicleTransparency == 'low' then
                SetEntityAlpha(veh, 400)
            elseif Config.SetVehicleTransparency == 'medium' then
                SetEntityAlpha(veh, 93)
            elseif Config.SetVehicleTransparency == 'high' then
                SetEntityAlpha(veh, 40)
            elseif Config.SetVehicleTransparency == 'none' then
                
            end
            FreezeEntityPosition(PlayerPedId(), true)
            SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
            exports['LegacyFuel']:SetFuel(veh, 0.0)
            FreezeEntityPosition(veh, true)
            SetVehicleEngineOn(veh, false, false)
            DoScreenFadeOut(200)
            Citizen.Wait(500)
            DoScreenFadeIn(200)
            SetVehicleUndriveable(veh, true)
        
            VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 439.59, -987.72, 47.82, 50, 0.00, 282.17034, 80.00, 80.00, false, 0)
            SetCamActive(VehicleCam, true)
            RenderScriptCams(true, true, 500, true, true)
            
            Citizen.CreateThread(function()
                while true do
                    if InPreview then
                        ShowHelpNotification("~INPUT_FRONTEND_RRIGHT~ Kapat")
                    elseif not InPreview then
                        break
                    end
                    if IsControlJustReleased(0, 177) then
                        SetEntityVisible(PlayerPedId(), true, 1)
                        FreezeEntityPosition(PlayerPedId(), false)
                        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        QBCore.Functions.DeleteVehicle(veh)
                        DoScreenFadeOut(200)
                        Citizen.Wait(500)
                        DoScreenFadeIn(200)
                        RenderScriptCams(false, false, 1, true, true)
                        InPreview = false
                        TriggerServerEvent("CL-pdHeli:server:SetActive", false)
                        break
                    end
                    Citizen.Wait(1)
                end
            end)
        end, coords, true)
    end
end)


RegisterNetEvent(":CheckZone", function()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        if InZone() then
            SetVehicleEngineHealth(veh, 1000)
            SetVehiclePetrolTankHealth(veh, 1000)
            SetVehicleFixed(veh)
            SetVehicleDeformationFixed(veh)
            SetVehicleUndriveable(veh, false)
            SetVehicleEngineOn(veh, true, true)
            QBCore.Functions.Notify("Araç tamir edildi !", "success", 3000)
        else
            QBCore.Functions.Notify("Tamir alanında değilsin !", "error", 3000)
        end
    else
        QBCore.Functions.Notify("Araçta değilsin !", "error")
    end
end)