if Controls then

  -- ─── Setup ────────────────────────────────────────────────────────────────

  local json      = require("rapidjson")
  local ws        = WebSocket.New()
  local polltimer = Timer.New()
  local delay     = Timer.New()
  local IP        = Controls.ontime_IP

  -- ─── Helper Functions ─────────────────────────────────────────────────────

  local function setControlString(name, value)
    if value ~= nil then
      Controls[name].String = value
    end
  end

  local function setControlValue(name, value)
    if value ~= nil then
      Controls[name].Value = value
    end
  end

  local function setVisible(name, isVisible)
    Controls[name].IsInvisible = not isVisible
  end

  -- ─── Blink / Flash Logic ──────────────────────────────────────────────────

  local function flashButton()
    local on = Controls.BlinkBlink.Value == 0
    Controls.BlinkBlink.Value = on and 1 or 0
    Controls.Time_Remaining.IsDisabled     = on
    Controls.Neg_Time_Remaining.IsDisabled = on
  end

  local function startFlashTimer()
    delay:Start(0.6)
  end

  local function stopFlashTimer()
    delay:Stop()
    Controls.BlinkBlink.Value              = 0
    Controls.Time_Remaining.IsDisabled     = false
    Controls.Neg_Time_Remaining.IsDisabled = false
  end

  -- ─── Timer Feedback ───────────────────────────────────────────────────────

  local function TimerFB(msg)
    local payload  = msg.payload
    local playback = payload.timer.playback

    -- Timer display
    if playback == "roll" then
      setControlString("Time_Remaining",     "")
      setControlString("Neg_Time_Remaining", "ROLL")
    elseif playback == "stop" then
      setControlString("Time_Remaining",     "-- : -- : --")
      setControlString("Neg_Time_Remaining", "")
    else
      local timerCurrent = payload.timer.current
      local isNegative   = false
      local timerValue   = 0

      if type(timerCurrent) == "number" then
        isNegative = timerCurrent < 0
        timerValue = math.abs(timerCurrent)
      elseif type(timerCurrent) == "string" then
        isNegative = timerCurrent:sub(1, 1) == "-"
        timerValue = tonumber(timerCurrent:sub(isNegative and 2 or 1)) or 0
      end

      -- timer.current is in milliseconds
      local totalSecs = math.floor(timerValue / 1000)
      local h = math.floor(totalSecs / 3600)
      local m = math.floor((totalSecs % 3600) / 60)
      local s = totalSecs % 60
      local formatted = string.format("%02d:%02d:%02d", h, m, s)
      if isNegative then formatted = "-" .. formatted end

      setControlString("Time_Remaining",     isNegative and "" or formatted)
      setControlString("Neg_Time_Remaining", isNegative and formatted or "")
    end

    -- Event index (v3 uses rundown, not runtime)
    local index     = payload.rundown.selectedEventIndex + 1
    local numEvents = payload.rundown.numEvents
    setControlValue("Event_Index", index)
    setControlValue("Event_Total", numEvents)
    setVisible("Event_Index", playback ~= "roll" and playback ~= "stop")

    -- Current event
    if payload.eventNow then
      setControlString("Event_Title", payload.eventNow.title)
      setControlString("Note",        payload.eventNow.note)
    end

    -- Next event
    if index ~= numEvents and payload.eventNext then
      setControlString("Next_Event_Title", payload.eventNext.title)
      setControlString("Next_Note",        payload.eventNext.note)
    else
      setControlString("Next_Event_Title", "End of Event List")
      setControlString("Next_Note",        "End of Event List")
    end

    -- Blink state — sync button value and start/stop flash
    local isBlinking = payload.message.timer.blink == true
    setControlValue("Blink", isBlinking and 1 or 0)
    if isBlinking then startFlashTimer() else stopFlashTimer() end

    -- Blackout state — sync button value and hide/show timer displays
    local isBlackedOut = payload.message.timer.blackout == true
    setControlValue("Blank", isBlackedOut and 1 or 0)
    setVisible("Time_Remaining",     not isBlackedOut)
    setVisible("Neg_Time_Remaining", not isBlackedOut)

    -- Timer message — sync visibility button, feedback field, and text
    local timerMsgVisible = payload.message.timer.visible == true
    setControlValue("T-MessageVis", timerMsgVisible and 1 or 0)
    setVisible("Current T-Message", timerMsgVisible)
    setControlString("Current T-Message", payload.message.timer.text)

    -- Public message — sync visibility button, feedback field, and text
    local pubMsgVisible = payload.message.external.visible == true
    setControlValue("P-MessageVis", pubMsgVisible and 1 or 0)
    setVisible("Current P-Message", pubMsgVisible)
    setControlString("Current P-Message", payload.message.external.text)
  end

  local function LogFB(msg)
    print("Ontime log: " .. tostring(msg.payload))
  end

  -- ─── WebSocket Lifecycle ──────────────────────────────────────────────────

  local function Connect()
    local port = Controls.Port.String  -- read at call time so user changes are respected
    if IP.String ~= "" and port ~= "" then
      ws:Connect("ws", IP.String, "/ws", port)
    end
  end

  local function Disconnect()
    ws:Close()
    stopFlashTimer()
    polltimer:Stop()
    print("Disconnected from Ontime")
  end

  ws.Connected = function()
    print("WebSocket connected: " .. IP.String .. " port " .. Controls.Port.String)
    polltimer:Start(0.33)
  end

  ws.Closed = function()
    print("WebSocket closed — polling stopped")
    polltimer:Stop()
    stopFlashTimer()
  end

  ws.Error = function(_, err)
    print("WebSocket error: " .. tostring(err))
    polltimer:Stop()
  end

  ws.Data = function(_, data)
    local msg = json.decode(data)
    if msg == nil then
      print("WS: failed to decode message")
      return
    end
    if msg.type == "ontime-log" then
      LogFB(msg)
    elseif msg.type == "poll" then
      TimerFB(msg)
    end
  end

  -- IP field: connect/disconnect when user changes it
  IP.EventHandler = function()
    if IP.String == "" then
      Disconnect()
    else
      Connect()
    end
  end

  -- ─── Playback Controls ────────────────────────────────────────────────────

  Controls.Play.EventHandler = function()
    ws:Write(json.encode({ type = "start" }), false)
  end

  Controls.Pause.EventHandler = function()
    ws:Write(json.encode({ type = "pause" }), false)
  end

  Controls.Restart.EventHandler = function()
    ws:Write(json.encode({ type = "reload" }), false)
  end

  Controls.Next.EventHandler = function()
    ws:Write(json.encode({ type = "load", payload = "next" }), false)
  end

  Controls.Previous.EventHandler = function()
    ws:Write(json.encode({ type = "load", payload = "previous" }), false)
  end

  -- ─── Time Adjustments (payloads in milliseconds) ──────────────────────────

  Controls["Plus 1"].EventHandler = function()
    ws:Write(json.encode({ type = "addtime", payload = 60000 }), false)
  end

  Controls["Minus 1"].EventHandler = function()
    ws:Write(json.encode({ type = "addtime", payload = -60000 }), false)
  end

  Controls["Plus 5"].EventHandler = function()
    ws:Write(json.encode({ type = "addtime", payload = 300000 }), false)
  end

  Controls["Minus 5"].EventHandler = function()
    ws:Write(json.encode({ type = "addtime", payload = -300000 }), false)
  end

  -- ─── Timer Display State ──────────────────────────────────────────────────

  Controls.Blink.EventHandler = function()
    local isBlinking = Controls.Blink.Boolean
    ws:Write(json.encode({
      type    = "message",
      payload = { timer = { blink = isBlinking } }
    }), false)
    if isBlinking then startFlashTimer() else stopFlashTimer() end
  end

  Controls.Blank.EventHandler = function()
    local isBlackedOut = Controls.Blank.Boolean
    ws:Write(json.encode({
      type    = "message",
      payload = { timer = { blackout = isBlackedOut } }
    }), false)
    setVisible("Time_Remaining",     not isBlackedOut)
    setVisible("Neg_Time_Remaining", not isBlackedOut)
  end

  -- ─── Messaging Controls ───────────────────────────────────────────────────

  Controls["T-MessageVis"].EventHandler = function()
    local isVisible = Controls["T-MessageVis"].Boolean
    ws:Write(json.encode({
      type    = "message",
      payload = { timer = { visible = isVisible } }
    }), false)
    setVisible("Current T-Message", isVisible)
  end

  Controls["P-MessageVis"].EventHandler = function()
    local isVisible = Controls["P-MessageVis"].Boolean
    ws:Write(json.encode({
      type    = "message",
      payload = { external = { visible = isVisible } }
    }), false)
    setVisible("Current P-Message", isVisible)
  end

  Controls["Send TimerMessage"].EventHandler = function()
    ws:Write(json.encode({
      type    = "message",
      payload = { timer = { text = Controls["TimerMessage"].String } }
    }), false)
  end

  Controls["Send PublicMessage"].EventHandler = function()
    ws:Write(json.encode({
      type    = "message",
      payload = { external = { text = Controls["PublicMessage"].String } }
    }), false)
  end

  -- ─── Timer Wiring ─────────────────────────────────────────────────────────

  polltimer.EventHandler = function()
    ws:Write(json.encode({ type = "poll" }), false)
  end

  delay.EventHandler = flashButton

  -- ─── Connect on Startup ───────────────────────────────────────────────────

  Connect()

end
