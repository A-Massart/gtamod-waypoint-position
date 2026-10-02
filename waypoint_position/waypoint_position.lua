local waypoint_x = nil
local waypoint_y = nil

CreateThread(function()
    local last_x = nil
    local last_y = nil

    while true do
        Wait(100)

        local blip = GetFirstBlipInfoId(8)

        if DoesBlipExist(blip) then
            local coords = GetBlipInfoIdCoord(blip)

            -- Nouveau waypoint ou waypoint déplacé
            if coords.x ~= last_x or coords.y ~= last_y then
                waypoint_x = coords.x
                waypoint_y = coords.y

                last_x = coords.x
                last_y = coords.y

                print(('Waypoint: x = %.2f, y = %.2f'):format(
                    waypoint_x,
                    waypoint_y
                ))
            end
        else
            waypoint_x = nil
            waypoint_y = nil

            last_x = nil
            last_y = nil
        end
    end
end)


function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(4, 0, 0, 0, 255)

    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end


CreateThread(function()
    while true do
        Wait(0)

        if waypoint_x ~= nil and waypoint_y ~= nil then
            local text = ('Waypoint: X %.2f | Y %.2f'):format(
                waypoint_x,
                waypoint_y
            )

            Draw2DText(0.8, 0.9, text, 0.5)
        end
    end
end)
