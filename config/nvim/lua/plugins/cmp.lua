local function setup(options)
  local cmp = require("cmp")

  local function tabSelect(should_select_next, fallback)
    if cmp.visible() then
      if should_select_next then
        cmp.select_next_item()
      else
        cmp.select_prev_item()
      end
    else
      fallback()
    end
  end

  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping(
        function(fallback) tabSelect(true, fallback) end,
        {"i", "s"}),
      ["<S-Tab>"] = cmp.mapping(
        function(fallback) tabSelect(false, fallback) end,
        {"i", "s"}),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
    }),
    sources = {
      { name = "nvim_lsp", },
      { name = "buffer", },
    },
    completion = {
      autocomplete = {
        cmp.TriggerEvent.TextChanged,
        cmp.TriggerEvent.InsertEnter,
      },
      completeopt = "menu,menuone,noselect",
    }
  })

  cmp.setup.cmdline(
    ":",
    {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "cmdline", }, },
    }
  )
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = "InsertEnter",
    config = function(_, opts) setup(opts) end,
  },
}
