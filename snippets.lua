local function loadCustomSnippet(ls)
  local s = ls.snippet
  -- local sn = ls.snippet_node
  -- local isn = ls.indent_snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  -- local f = ls.function_node
  -- local c = ls.choice_node
  -- local d = ls.dynamic_node
  -- local r = ls.restore_node
  ls.add_snippets("all", {
    s("clg", {
      t "console.log(",
      i(1),
      t ")",
    }),

    s("typ", {
      t "type PropsType = {",
      i(1),
      t "}",
    }),

    s("tys", {
      t "type StatesType = {",
      i(1),
      t "}",
    }),

    s("watch", {
      t "watch(",
      i(1),
      t ",()=>{",
      i(2),
      t "})",
    }),

    s("usef", {
      t "export default (",
      i(1),
      t { ") => {", "  return aysnc (" },
      i(2),
      t { ") => {" },
      i(3),
      t { "}", "}" },
    }),

    s("effct", {
      t "watchEffect(()=>{",
      i(1),
      t "})",
    }),
  })
end

return loadCustomSnippet
