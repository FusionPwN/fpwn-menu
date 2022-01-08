Config = {}

RegisterCommand('testm', function()
    TriggerEvent('fpwn-menu:client:opentestmenu')
end)

RegisterNetEvent('fpwn-menu:client:opentestmenu', function()
    local menuData = {
        {
            type = 'title',
            clickable = false,
            text = 'My Test Menu'
        },
        {
            type = 'button',
            clickable = true, --set this to true if the user is able to click the button
            text = 'Return a value',
            value = 'test value',
            func = function(value)
                print(tostring(value))
            end
        },
        {
            type = 'button',
            clickable = true, --set this to true if the user is able to click the button
            text = 'Return an object',
            description = 'Click me',
            value = { arg1 = 'test value', arg2 = 1 },
            func = function(obj)
                print(tostring(obj))
            end
        },
        {
            type = 'button-sub',
            clickable = true, --set this to true if the user is able to click the button
            text = 'Open chain menu',
            description = 'Click me',
            func = function(value)
                print('Opened a chain menu')
                TriggerEvent('fpwn-menu:client:opentestmenu1')
            end
        }
    }

    TriggerEvent('fpwn-dialog:client:openmenu', 'testmenu', menuData, function()
        print('User closed the menu without clicking anything!')
    end)
end)

RegisterNetEvent('fpwn-menu:client:opentestmenu1', function()
    local menuData = {
        {
            type = 'title',
            clickable = false,
            text = 'My Test Sub Menu 1'
        },
        {
            type = 'button',
            clickable = true,
            text = 'Return a value',
            value = 'test value',
            func = function(value)
                print(tostring(value))
            end
        },
        {
            type = 'button',
            clickable = true,
            text = 'Return an object',
            description = 'Click me',
            value = { arg1 = 'test value', arg2 = 1 },
            func = function(obj)
                print(tostring(obj))
            end
        },
        {
            type = 'button-sub',
            clickable = true,
            text = 'Open chain menu',
            description = 'Click me',
            func = function(value)
                print('Opened a chain menu')
            end
        },
        {
            type = 'back',
            clickable = true,
            text = 'Back',
            func = function(value)
                print('Returned to last menu')
                TriggerEvent('fpwn-menu:client:opentestmenu')
            end
        }
    }

    TriggerEvent('fpwn-dialog:client:openmenu', 'testmenu1', menuData, function()
        print('User closed the menu without clicking anything!')
    end)
end)