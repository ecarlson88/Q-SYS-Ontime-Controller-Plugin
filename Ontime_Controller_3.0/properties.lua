function GetProperties()
  local props = {}
  return props
end

PageNames = { "Timer", "Event", "Messaging", "Info" }

function GetPages(props)
  local pages = {}
  for ix, name in ipairs(PageNames) do
    table.insert(pages, { name = PageNames[ix] })
  end
  return pages
end
