local M = {}

local Modes = {}
Modes.c = "COMMAND"
Modes.i = "INSERT"
Modes.n = "NORMAL"
Modes.r = "REPLACE"
Modes.s = "SELECT"
Modes.t = "TERMINAL"
Modes.v = "VISUAL"

local function made_name()
  mode = vim.api.nvim_eval("mode()")
  if Modes[mode] then
    return Modes[mode]
  end
  return "UNKNOWN: " .. mode
end

return M

-- set laststatus=2
-- set statusline=
-- set statusline+=%2*
-- set statusline+=%{StatuslineMode()}
-- set statusline+=%1*
-- set statusline+=\ 
-- set statusline+=<
-- set statusline+=<
-- set statusline+=\ 
-- set statusline+=%f
-- set statusline+=\ 
-- set statusline+=>
-- set statusline+=>
-- set statusline+=%=
-- set statusline+=%m
-- set statusline+=%h
-- set statusline+=%r
-- set statusline+=\ 
-- set statusline+=%3*
-- set statusline+=%{b:gitbranch}
-- set statusline+=%1*
-- set statusline+=\ 
-- set statusline+=%4*
-- set statusline+=%F
-- set statusline+=:
-- set statusline+=:
-- set statusline+=%5*
-- set statusline+=%l
-- set statusline+=/
-- set statusline+=%L
-- set statusline+=%1*
-- set statusline+=|
-- set statusline+=%y
-- hi User2 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
-- hi User1 ctermbg=black ctermfg=white guibg=black guifg=white
-- hi User3 ctermbg=black ctermfg=lightblue guibg=black guifg=lightblue
-- hi User4 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen
-- hi User5 ctermbg=black ctermfg=magenta guibg=black guifg=magenta

-- function! StatuslineGitBranch()
--   let b:gitbranch=""
--   if &modifiable
--     try
--       let l:dir=expand('%:p:h')
--       let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
--       if !v:shell_error
--         let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
--       endif
--     catch
--     endtry
--   endif
-- endfunction

-- augroup GetGitBranch
--   autocmd!
--   autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
-- augroup END
