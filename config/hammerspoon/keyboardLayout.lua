local M = {}

-- switch layout when a registered keyboard is connected, back to the default layout when unplugged
local DEFAULT_LAYOUT = "Dvorak"

-- add a { vendorID, productID, layout } entry here for each other keyboard
local KEYBOARD_LAYOUTS = {
	{ vendorID = 4617, productID = 8963, layout = "U.S." }, -- Atreus
	{ vendorID = 10730, productID = 258, layout = "U.S." }, -- Kinesis Advantage2
}

local function deviceKey(vendorID, productID)
	return vendorID .. ":" .. productID
end

local connectedLayouts = {}

function M.start()
	return hs.usb.watcher.new(function(event)
		for _, keyboard in ipairs(KEYBOARD_LAYOUTS) do
			if event.vendorID == keyboard.vendorID and event.productID == keyboard.productID then
				local key = deviceKey(keyboard.vendorID, keyboard.productID)
				if event.eventType == "added" then
					connectedLayouts[key] = keyboard.layout
					hs.keycodes.setLayout(keyboard.layout)
				elseif event.eventType == "removed" then
					connectedLayouts[key] = nil
					local fallback = DEFAULT_LAYOUT
					for _, layout in pairs(connectedLayouts) do
						fallback = layout
					end
					hs.keycodes.setLayout(fallback)
				end
				return
			end
		end
	end):start()
end

return M
