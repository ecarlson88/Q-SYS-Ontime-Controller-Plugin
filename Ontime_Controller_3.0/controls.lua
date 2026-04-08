function GetControls(props)
  local ctrls = {}

  -- Playback controls
  table.insert(ctrls, {
    Name = "Play",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Play",
    IconColor = {47, 133, 90}
  })
  table.insert(ctrls, {
    Name = "Pause",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Pause"
  })
  table.insert(ctrls, {
    Name = "Restart",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Refresh"
  })
  table.insert(ctrls, {
    Name = "Next",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Next"
  })
  table.insert(ctrls, {
    Name = "Previous",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Previous"
  })

  -- Time adjustment controls (payloads in milliseconds)
  table.insert(ctrls, {
    Name = "Plus 1",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
  table.insert(ctrls, {
    Name = "Minus 1",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
  table.insert(ctrls, {
    Name = "Plus 5",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
  table.insert(ctrls, {
    Name = "Minus 5",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })

  -- Timer display state controls
  table.insert(ctrls, {
    Name = "Blink",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = 1,
    UserPin = true,
    PinStyle = "Input"
  })
  table.insert(ctrls, {
    Name = "BlinkBlink",  -- internal: drives the flashing animation
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = 1,
    UserPin = false,
    Icon = "Burst"
  })
  table.insert(ctrls, {
    Name = "Blank",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Prohibited"
  })

  -- Messaging controls
  table.insert(ctrls, {
    Name = "T-MessageVis",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Eye"
  })
  table.insert(ctrls, {
    Name = "P-MessageVis",
    ControlType = "Button",
    ButtonType = "Toggle",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Eye"
  })
  table.insert(ctrls, {
    Name = "Send TimerMessage",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Checkbox"
  })
  table.insert(ctrls, {
    Name = "Send PublicMessage",
    ControlType = "Button",
    ButtonType = "Trigger",
    Count = 1,
    UserPin = true,
    PinStyle = "Input",
    Icon = "Checkbox"
  })
  table.insert(ctrls, {
    Name = "TimerMessage",
    ControlType = "Text",
    Count = 1,
    PinStyle = "Input",
    UserPin = true
  })
  table.insert(ctrls, {
    Name = "PublicMessage",
    ControlType = "Text",
    Count = 1,
    PinStyle = "Input",
    UserPin = true
  })

  -- Feedback / display controls
  table.insert(ctrls, {
    Name = "Current T-Message",
    ControlType = "Text",
    Count = 1,
    UserPin = false
  })
  table.insert(ctrls, {
    Name = "Current P-Message",
    ControlType = "Text",
    Count = 1,
    UserPin = false
  })
  table.insert(ctrls, {
    Name = "Event_Title",
    ControlType = "Text",
    Count = 1,
    UserPin = false
  })
  table.insert(ctrls, {
    Name = "Note",
    ControlType = "Text",
    Count = 1,
    UserPin = false
  })
  table.insert(ctrls, {
    Name = "Next_Event_Title",
    ControlType = "Text",
    Count = 1,
    UserPin = false
  })
  table.insert(ctrls, {
    Name = "Next_Note",
    ControlType = "Text",
    Count = 1,
    UserPin = false
  })
  table.insert(ctrls, {
    Name = "Time_Remaining",
    ControlType = "Text",
    Count = 1,
    UserPin = false,
    FontSize = 28,
    FrontColor = {255, 255, 255}
  })
  table.insert(ctrls, {
    Name = "Neg_Time_Remaining",
    ControlType = "Text",
    Count = 1,
    UserPin = false,
    FontSize = 28,
    FrontColor = {255, 0, 0}
  })
  table.insert(ctrls, {
    Name = "Event_Index",
    ControlType = "Knob",
    ControlUnit = "Integer",
    Min = 0,
    Max = 100,
    Count = 1,
    UserPin = true,
    PinStyle = "Output"
  })
  table.insert(ctrls, {
    Name = "Event_Total",
    ControlType = "Knob",
    ControlUnit = "Integer",
    Min = 0,
    Max = 100,
    Count = 1,
    UserPin = true,
    PinStyle = "Output"
  })

  table.insert(ctrls, {
    Name = "Cue",
    ControlType = "Text",
    Count = 1,
    UserPin = true,
    PinStyle = "Output"
  })

  -- Connection settings
  table.insert(ctrls, {
    Name = "ontime_IP",
    ControlType = "Text",
    Count = 1,
    UserPin = false
  })
  table.insert(ctrls, {
    Name = "Port",
    ControlType = "Text",
    Count = 1,
    UserPin = false,
    DefaultValue = "4001"
  })

  return ctrls
end
