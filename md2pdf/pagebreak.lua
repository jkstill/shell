-- Substitute 'pagebreak' with a horizontal rule or a specific Div
function HorizontalRule (el)
    if FORMAT == "docx" then
      return pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
    elseif FORMAT == "latex" or FORMAT == "beamer" then
      return pandoc.RawBlock('tex', '\\newpage')
    elseif FORMAT == "html" or FORMAT == "epub" then
      return pandoc.RawBlock('html', '<div style="page-break-after: always;"></div>')
    end
end
