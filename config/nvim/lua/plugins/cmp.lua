local cmp = require("cmp")
local luasnip = require("luasnip")

local function tabSelect(should_select_next, fallback)
  if should_select_next then
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      fallback()
    end

  else
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end
end

cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        tabSelect(true, fallback)
      end,
      {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        tabSelect(false, fallback)
      end,
      {"i", "s"}),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- move through documentation
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"},
  },
}
