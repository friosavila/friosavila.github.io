function Bibliography(div)
  local citations = div.content
  table.sort(citations, function(a, b)
    local year_a = tonumber(a.content[1].content:match("%((%d+)%)"))
    local year_b = tonumber(b.content[1].content:match("%((%d+)%)"))
    if year_a == year_b then
      return a.content[1].content < b.content[1].content
    else
      return year_a > year_b
    end
  end)
  div.content = citations
  return div
end