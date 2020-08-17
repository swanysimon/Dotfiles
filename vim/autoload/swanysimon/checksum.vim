function! swanysimon#checksum#Sha256(filename)
  let l:command = "sha256sum"
  if !executable("sha256sum")
    let l:command = "shasum -a 256"
  endif
  return trim(system(l:command . " " . a:filename . " | cut -f 1 -d ' '"))
endfunction
