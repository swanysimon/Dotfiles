" detect rust files
function! s:set_rust_filetype() abort
    if &filetype !=# 'rust'
        set filetype=rust
    endif
endfunction

autocmd BufRead,BufNewFile *.rs call s:set_rust_filetype()
