function GetProperties()
  local props = {}
  table.insert(props, {
    Name = "page_index",
    Type = "integer",
    Min = 1,
    Max = #PageNames,
    Value = 1
  })
  return props
end

PageNames = { "Timer", "Event", "Messaging" }

function GetPages(props)
  local pages = {}
  for ix, name in ipairs(PageNames) do
    table.insert(pages, { name = PageNames[ix] })
  end
  return pages
end
