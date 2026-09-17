local windowManagement = require("windowManagement")

local mash = { "ctrl", "alt" }

-- halves, cycling through half -> third -> two-thirds on repeated presses
hs.hotkey.bind(
	mash,
	"Left",
	windowManagement.cycleUnit({ { 0, 0, 0.5, 1 }, { 0, 0, 1 / 3, 1 }, { 0, 0, 2 / 3, 1 } })
)
hs.hotkey.bind(
	mash,
	"Right",
	windowManagement.cycleUnit({ { 0.5, 0, 0.5, 1 }, { 2 / 3, 0, 1 / 3, 1 }, { 1 / 3, 0, 2 / 3, 1 } })
)
hs.hotkey.bind(mash, "Up", windowManagement.moveToUnit({ 0, 0, 1, 0.5 }))
hs.hotkey.bind(mash, "Down", windowManagement.moveToUnit({ 0, 0.5, 1, 0.5 }))

-- quarters
hs.hotkey.bind(mash, "U", windowManagement.moveToUnit({ 0, 0, 0.5, 0.5 }))
hs.hotkey.bind(mash, "I", windowManagement.moveToUnit({ 0.5, 0, 0.5, 0.5 }))
hs.hotkey.bind(mash, "J", windowManagement.moveToUnit({ 0, 0.5, 0.5, 0.5 }))
hs.hotkey.bind(mash, "K", windowManagement.moveToUnit({ 0.5, 0.5, 0.5, 0.5 }))

-- thirds
hs.hotkey.bind(mash, "D", windowManagement.moveToUnit({ 0, 0, 1 / 3, 1 }))
hs.hotkey.bind(mash, "F", windowManagement.moveToUnit({ 1 / 3, 0, 1 / 3, 1 }))
hs.hotkey.bind(mash, "G", windowManagement.moveToUnit({ 2 / 3, 0, 1 / 3, 1 }))

-- two-thirds
hs.hotkey.bind(mash, "E", windowManagement.moveToUnit({ 0, 0, 2 / 3, 1 }))
hs.hotkey.bind(mash, "T", windowManagement.moveToUnit({ 1 / 3, 0, 2 / 3, 1 }))

-- maximize / center
hs.hotkey.bind(mash, "Return", windowManagement.moveToUnit({ 0, 0, 1, 1 }))
hs.hotkey.bind(mash, "C", windowManagement.centerWindow)
hs.hotkey.bind(
	{ "cmd", "alt", "shift" },
	"C",
	windowManagement.cycleUnit({ { 0.05, 0.05, 0.9, 0.9 }, { 0, 0, 1, 1 } })
)

keyboardWatcher = require("keyboardLayout").start()
