Config = Config or {}

Config.LogsImage = "https://cdn.discordapp.com/attachments/926465631770005514/966038265130008576/CloudDevv.png"
Config.WebHook = "YOUR WEBHOOK"
Config.FuelSystem = "zade-fuel" -- Put here your fuel system LegacyFuel by default
Config.UsePreviewMenuSync = false -- Sync for the preview menu when player is inside the preview menu other players cant get inside (can prevent bugs but not have to use)
Config.UseMarkerInsteadOfMenu = true -- Want to use the marker to return the vehice? if false you can do that by opening the menu
Config.SetVehicleTransparency = 'low' -- Want to make the vehicle more transparent? you have a lot of options to choose from: low, medium, high, none
Config.Job = 'police, ambulance' --The job needed to open the menu


Config.Vehicles = {
    [1] = {
        ['vehiclename'] = "Dodge Charger 2014", --Name
        ['vehicle'] = "14chargerw", --Model
        ['price'] = 1, --Price
    }, 
    [2] = {
        ['vehiclename'] = "Chevrolet Burban 2018", --Name
        ['vehicle'] = "18burbanw", --Model
        ['price'] = 1, --Price
    }, 
    [3] = {
        ['vehiclename'] = "Chevrolet Tahoe 2006", --Name
        ['vehicle'] = "06tahoew", --Model
        ['price'] = 1, --Price
    }, 
    [4] = {
        ['vehiclename'] = "Chevrolet Tahoe 2018", --Name
        ['vehicle'] = "18tahoew", --Model
        ['price'] = 1, --Price
    }, 
    [5] = {
        ['vehiclename'] = "Ford 150 Ranger", --Name
        ['vehicle'] = "18f150w", --Model
        ['price'] = 1, --Price
    }, 
    [6] = {
        ['vehiclename'] = "Ford Victoria", --Name
        ['vehicle'] = "11cvpiw", --Model
        ['price'] = 1, --Price
    }, 
    [7] = {
        ['vehiclename'] = "Ford Explorer", --Name
        ['vehicle'] = "16fpiuw", --Model
        ['price'] = 1, --Price
    }, 
    [8] = {
        ['vehiclename'] = "Ford Taurus 2018", --Name
        ['vehicle'] = "18taurusw", --Model
        ['price'] = 1, --Price
    }, 
    [9] = {
        ['vehiclename'] = "Dodge Charger 2018 HSU", --Name
        ['vehicle'] = "18chargerw", --Model
        ['price'] = 1, --Price
    }, 
    [10] = {
        ['vehiclename'] = "Porsche 911 HSU", --Name
        ['vehicle'] = "911turboleo", --Model
        ['price'] = 1, --Price
    }, 
}

Config.Vehicles1 = {
    [1] = {
        ['vehiclename'] = "Ambulans", --Name
        ['vehicle'] = "20ramambo", --Model
        ['price'] = 1, --Price
    }, 
    [2] = {
        ['vehiclename'] = "Tekerlekli Sandalye", --Name
        ['vehicle'] = "iak_wheelchair", --Model
        ['price'] = 1, --Price
    }, 
    [3] = {
        ['vehiclename'] = "Sedye", --Name
        ['vehicle'] = "stretcher", --Model
        ['price'] = 1, --Price
    },
    [4] = {
        ['vehiclename'] = "Ambulance 2", --Name
        ['vehicle'] = "emsnspeedo", --Model
        ['price'] = 1, --Price
    },
}


Config.Vehicles2 = {
    [1] = {
        ['vehiclename'] = "ADIMOKTER", --Name
        ['vehicle'] = "polmav", --Model
        ['price'] = 1, --Price
    }, 
}


Config.Vehicles3 = {
    [1] = {
        ['vehiclename'] = "ADIMOKTER", --Name
        ['vehicle'] = "polmav", --Model
        ['price'] = 1, --Price
    }, 
}

Config.RepairLocations = {
    --MRPD
    [1] = {
        ['coords'] = vector3(431.21, -984.01, 25.14),
        ['distance'] = 32.0
    },  
}