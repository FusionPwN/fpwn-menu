FPWN_Menu               = {}
FPWN_Menu.IsOpen        = false
FPWN_Menu.Structure     = {}
FPWN_Menu.CancelCb      = false

NuiReady                = false

RegisterNetEvent('fpwn-dialog:client:openmenu', function(id, struct, cancelcb)
    FPWN_Menu.OpenMenu(id, struct, cancelcb)
end)

RegisterNetEvent('fpwn-dialog:client:closemenu', function(id, struct, cancelcb)
    FPWN_Menu.CloseMenu()
end)

FPWN_Menu.OpenMenu = function(id, struct, cancelcb)
    if not NuiReady then print('STILL WAITING FOR UI') return end
    if not id or not struct or type(struct) ~= 'table' then return end

    if not FPWN_Menu.Structure[id] then
        FPWN_Menu.Structure[id] = {}
	else
		print('MENU IS ALREADY OPEN')
		return
    end

    FPWN_Menu.Structure[id] = struct
    FPWN_Menu.CancelCb      = cancelcb or false

    FPWN_Menu.IsOpen = true

    SendNUIMessage({ action = 'show-menu', id = id, struct = struct })
    SetNuiFocus(true, true)
end

exports('OpenMenu', FPWN_Menu.OpenMenu)

FPWN_Menu.CloseMenu = function(struct, cancelcb)
    if not FPWN_Menu.IsOpen then print('UI IS NOT OPEN') return end

    SendNUIMessage({ action = 'hide-menu' })
    SetNuiFocus(false, false)

	FPWN_Menu.Structure     = {}
    FPWN_Menu.CancelCb      = false

    FPWN_Menu.IsOpen = false
end

RegisterNUICallback('nuiready', function(data, cb)
    NuiReady = true
end)

RegisterNUICallback('clickMenuItem', function(data, cb)
    if not data or not data.menuid or not data.index then return end

    if FPWN_Menu.Structure[data.menuid] and 
        FPWN_Menu.Structure[data.menuid][data.index] and 
        FPWN_Menu.Structure[data.menuid][data.index].func then

        if FPWN_Menu.Structure[data.menuid][data.index].type ~= 'button-sub' and FPWN_Menu.Structure[data.menuid][data.index].type ~= 'back' then
            FPWN_Menu.CloseMenu()
        end

        FPWN_Menu.Structure[data.menuid][data.index].func(FPWN_Menu.Structure[data.menuid][data.index].value)

        if FPWN_Menu.Structure[data.menuid][data.index].type ~= 'button-sub' and FPWN_Menu.Structure[data.menuid][data.index].type ~= 'back' then
            FPWN_Menu.Structure     = {}
            FPWN_Menu.CancelCb      = false
        end
    end
end)

RegisterNUICallback('cancelMenu', function(data, cb)
    SendNUIMessage({ action = 'hide-menu' })
    SetNuiFocus(false, false)
    
    FPWN_Menu.Structure = false
    if FPWN_Menu.CancelCb then 
        FPWN_Menu.CancelCb() 
    end

    FPWN_Menu.CancelCb = false 
    FPWN_Menu.IsOpen = false
end)