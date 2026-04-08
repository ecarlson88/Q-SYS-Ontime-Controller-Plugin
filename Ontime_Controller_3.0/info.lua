-- Information block for the plugin
PluginInfo = {
  Name = "Ontime Controller",
  Version = "3.0.0",
  BuildVersion = "0.3.0.0",
  Id = "ed864c7a-1808-4c0b-aa2b-2d6577783a17",
  Author = "Erik Carlson",
  Description = "WebSocket Controller For Ontime v3"
}

function GetColor(props)
  return { 80, 80, 80 }
end

function GetPrettyName(props)
  return "Ontime Controller " .. PluginInfo.Version
end
