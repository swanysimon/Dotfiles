local M = {}

function M.moveToUnit(unitRect)
	return function()
		local win = hs.window.focusedWindow()
		if win then
			win:moveToUnit(unitRect)
		end
	end
end

function M.centerWindow()
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

-- cycles through unit rects on repeated presses (Rectangle-style); jumps to the
-- first rect whenever the window isn't already at one of the listed positions
function M.cycleUnit(rects)
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

return M
