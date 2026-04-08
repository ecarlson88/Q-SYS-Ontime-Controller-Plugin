-- Information block for the plugin
PluginInfo = {
  Name = "Ontime Controller",
  Version = "3.0.0",
  BuildVersion = "0.3.0.0",
  Id = "e228364d-8e3d-3253-be94-bcb75ha2c76e",
  Author = "Erik Carlson",
  Description = "WebSocket Controller For Ontime v3"
}

function GetColor(props)
  return { 80, 80, 80 }
end

function GetPrettyName(props)
  return "Ontime Controller " .. PluginInfo.Version
end
