TrackingSwitch_X = LibStub("AceAddon-3.0"):NewAddon("TrackingSwitch_X", "AceConsole-3.0")
-- Add this line to include CallbackHandler-1.0
local CallbackHandler = LibStub("CallbackHandler-1.0")
TrackingSwitch_X.trackingTimer = nil

local defaults = {
  profile = {
    disableStationary = true,
    disableResting = true,
    disableCombat = true,
    timeInterval = 2,
  },
}

local options = {
  name = "TrackingSwitch_X",
  handler = TrackingSwitch_X,
  type = "group",
  args = {
    disableStationary = {
      name = "Disable tracking switch while stationary.",
      desc = "Check to disable switching while stationary.",
      type = "toggle",
      get = function() return TrackingSwitch_X.db.profile.disableStationary end,
      set = function(_, value) TrackingSwitch_X.db.profile.disableStationary = value end,
      width = "full",
    },
    disableResting = {
      name = "Disable tracking switch while in a town/inn.",
      desc = "Check to disable switching while in a town/inn.",
      type = "toggle",
      get = function() return TrackingSwitch_X.db.profile.disableResting end,
      set = function(_, value) TrackingSwitch_X.db.profile.disableResting = value end,
      width = "full",
    },
    disableCombat = {
      name = "Disable tracking switch while in combat.",
      desc = "Check to disable switching while in combat.",
      type = "toggle",
      get = function() return TrackingSwitch_X.db.profile.disableCombat end,
      set = function(_, value) TrackingSwitch_X.db.profile.disableCombat = value end,
      width = "full",
    },
    timeInterval = {
      name = "Time interval",
      desc = "Seconds before switch.",
      type = "range",
      min = 2,
      max = 20,
      step = 1,
      get = function() return TrackingSwitch_X.db.profile.timeInterval end,
      set = function(_, value)
        TrackingSwitch_X.db.profile.timeInterval = value
        TrackingSwitch_X:UpdateTimerInterval() -- Call UpdateTimerInterval when the interval changes
      end,
      width = "full",
    },
  },
}

function TrackingSwitch_X:OnInitialize()
  -- Initialize Ace3
  self.db = LibStub("AceDB-3.0"):New("TrackingSwitch_XDB", defaults, true)

  -- Create a new CallbackHandle

  LibStub("AceConfig-3.0"):RegisterOptionsTable("TrackingSwitch_X", options)
  self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('TrackingSwitch_X', 'TrackingSwitch_X')
  self.IS_RUNNING = false
  self:RegisterChatCommand("rl", function() ReloadUI() end) -- Reloads on /rl command
  self:RegisterChatCommand("tsxtoggle", "ToggleTracking") -- Corrected
  self:RegisterChatCommand("tsxt", "ToggleTracking") -- Corrected
  self:RegisterChatCommand("tsx", "OpenConfigMenu") -- Corrected
end


function TrackingSwitch_X:OpenConfigMenu()
  InterfaceOptionsFrame_OpenToCategory("TrackingSwitch_X")
  print(TrackingSwitch_X.db.profile.timeInterval)
end

function TrackingSwitch_X:UpdateTimerInterval()
  print("time interval", TrackingSwitch_X.db.profile.timeInterval )
end
function TrackingSwitch_X:SwitchTracking()
  local trackingIndex = GetTrackingTexture() -- Replace 1 with the appropriate tracking index
  print(trackingIndex, TrackingSwitch_X.db.profile.timeInterval)
  CastSpellByName("Find Minerals")
end