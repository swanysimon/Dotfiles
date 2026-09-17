local mash = { "ctrl", "alt" }

local function moveToUnit(unitRect)
	return function()
		local win = hs.window.focusedWindow()
		if win then
			win:moveToUnit(unitRect)
		end
	end
end

local function centerWindow()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end
	local screenFrame = win:screen():frame()
	local winFrame = win:frame()
	winFrame.x = screenFrame.x + (screenFrame.w - winFrame.w) / 2
	winFrame.y = screenFrame.y + (screenFrame.h - winFrame.h) / 2
	win:setFrame(winFrame)
end

-- almost-maximize: large centered window, not edge-to-edge
local function almostMaximize()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end
	local margin = 0.05
	local screenFrame = win:screen():frame()
	win:setFrame({
		x = screenFrame.x + screenFrame.w * margin,
		y = screenFrame.y + screenFrame.h * margin,
		w = screenFrame.w * (1 - 2 * margin),
		h = screenFrame.h * (1 - 2 * margin),
	})
end

-- cycles through unit rects on repeated presses (Rectangle-style); jumps to the
-- first rect whenever the window isn't already at one of the listed positions
local function cycleUnit(rects)
	return function()
		local win = hs.window.focusedWindow()
		if not win then
			return
		end
		local screenFrame = win:screen():frame()
		local winFrame = win:frame()
		local tolerance = 2
		local currentIndex = nil
		for i, rect in ipairs(rects) do
			local x = screenFrame.x + rect[1] * screenFrame.w
			local y = screenFrame.y + rect[2] * screenFrame.h
			local w = rect[3] * screenFrame.w
			local h = rect[4] * screenFrame.h
			if
				math.abs(winFrame.x - x) < tolerance
				and math.abs(winFrame.y - y) < tolerance
				and math.abs(winFrame.w - w) < tolerance
				and math.abs(winFrame.h - h) < tolerance
			then
				currentIndex = i
				break
			end
		end
		local nextIndex = currentIndex and (currentIndex % #rects) + 1 or 1
		win:moveToUnit(rects[nextIndex])
	end
end

-- halves, cycling through half -> third -> two-thirds on repeated presses
hs.hotkey.bind(
	mash,
	"Left",
	cycleUnit({ { 0, 0, 0.5, 1 }, { 0, 0, 1 / 3, 1 }, { 0, 0, 2 / 3, 1 } })
)
hs.hotkey.bind(
	mash,
	"Right",
	cycleUnit({ { 0.5, 0, 0.5, 1 }, { 2 / 3, 0, 1 / 3, 1 }, { 1 / 3, 0, 2 / 3, 1 } })
)
hs.hotkey.bind(mash, "Up", moveToUnit({ 0, 0, 1, 0.5 }))
hs.hotkey.bind(mash, "Down", moveToUnit({ 0, 0.5, 1, 0.5 }))

-- quarters
hs.hotkey.bind(mash, "U", moveToUnit({ 0, 0, 0.5, 0.5 }))
hs.hotkey.bind(mash, "I", moveToUnit({ 0.5, 0, 0.5, 0.5 }))
hs.hotkey.bind(mash, "J", moveToUnit({ 0, 0.5, 0.5, 0.5 }))
hs.hotkey.bind(mash, "K", moveToUnit({ 0.5, 0.5, 0.5, 0.5 }))

-- thirds
hs.hotkey.bind(mash, "D", moveToUnit({ 0, 0, 1 / 3, 1 }))
hs.hotkey.bind(mash, "F", moveToUnit({ 1 / 3, 0, 1 / 3, 1 }))
hs.hotkey.bind(mash, "G", moveToUnit({ 2 / 3, 0, 1 / 3, 1 }))

-- two-thirds
hs.hotkey.bind(mash, "E", moveToUnit({ 0, 0, 2 / 3, 1 }))
hs.hotkey.bind(mash, "T", moveToUnit({ 1 / 3, 0, 2 / 3, 1 }))

-- maximize / center
hs.hotkey.bind(mash, "Return", moveToUnit({ 0, 0, 1, 1 }))
hs.hotkey.bind(mash, "C", centerWindow)
hs.hotkey.bind({ "cmd", "alt", "shift" }, "C", almostMaximize)

-- switch layout when a registered keyboard is connected, back to the default layout when unplugged
local DEFAULT_LAYOUT = "Dvorak"

-- add a { vendorID, productID, layout } entry here for each other keyboard
local KEYBOARD_LAYOUTS = {
	{ vendorID = 4617, productID = 8963, layout = "U.S." }, -- Atreus
}

local function deviceKey(vendorID, productID)
	return vendorID .. ":" .. productID
end

local connectedLayouts = {}

keyboardWatcher = hs.usb.watcher.new(function(event)
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
