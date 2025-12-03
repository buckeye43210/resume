function CodeBlock(elem)
    local text = elem.text:gsub('([\\{%%#$&_%^~}])', '\\%1')
    return pandoc.RawBlock('latex', '\\begin{shaded}\n\\begin{Verbatim}\n' .. text .. '\n\\end{Verbatim}\n\\end{shaded}')
end
