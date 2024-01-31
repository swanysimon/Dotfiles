local function cycle(forward)
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local function cycle_internal(use_snippets)
    return function(fallback)
      local invisible = not cmp.visible()
      local try_snippets = invisible and use_snippets

      if try_snippets and forward then
        local col = vim.fn.col('.') - 1
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
          fallback()
        else
          cmp.complete()
        end
      elseif try_snippets then
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      elseif invisible then
        fallback()
      elseif #cmp.get_entries() == 1 then
        cmp.confirm({select = true})
      elseif forward then
        cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
      else
        cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
      end
    end
  end

  return require("cmp").mapping({
    c = cycle_internal(false),
    i = cycle_internal(true),
    s = cycle_internal(true),
  })
end


local function confirm()
  local cmp = require("cmp")
  local replace = cmp.ConfirmBehavior.Replace

  return cmp.mapping({
    c = cmp.mapping.confirm({behavior = replace}),
    i = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm({behavior = replace})
      else
        fallback()
      end
    end,
    s = cmp.mapping.confirm(),
  })
end


local function setup(_)

  local cmp = require("cmp")
  local luasnip = require("luasnip")

  require("lspkind")
  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    completion = {
      autocomplete = {
        cmp.TriggerEvent.InsertEnter,
        cmp.TriggerEvent.TextChanged,
      },
      completeopt = "menu,menuone,noselect",
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-f>"] = cmp.mapping.scroll_docs(-4),
      ["<C-b>"] = cmp.mapping.scroll_docs(4),
      ["<Tab>"] = cycle(true),
      ["<S-Tab>"] = cycle(false),
      ["<CR>"] = confirm(),
    }),
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    sources = cmp.config.sources({
      { keyword_length = 1, name = "nvim_lsp" },
      { keyword_length = 2, name = "luasnip" },
      { keyword_length = 3, name = "buffer" },
      { keyword_length = 2, name = "path" },
    }),
  })
end


return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    event = { "CmdlineEnter", "InsertEnter", },
    config = function(_, opts) setup(opts) end,
  },
}
