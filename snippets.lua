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

    s("wat", {
      t "watch(",
      i(1),
      t ",()=>{",
      i(2),
      t "})",
    }),

    s("effct", {
      t "watchEffect(()=>{",
      i(1),
      t "})",
    }),

    s("compu", {
      t "computed(()=>",
      i(1),
      t ")",
    }),

    s("cmodel",{
      t "const { modelVale }defineModel<{",
      i(1),
      t "}>()"
    }),
    s("cemits",{
      t "const emits = defineEmits<{",
      i(1),
      t "}>()"
    }),
    s("cprops",{
      t "defineProps<{",
      i(1),
      t "}>()"
    }),
    s("cdefault",{
      t "const props = withDefaults(defineProps<{",
      i(1),
      t "}>(),{",
      t "})",
    }),
    -- s("model",{
    --   t "defineModel{<",
    --   i(1),
    --   t "}>()"
    -- })
  })
end

return loadCustomSnippet
