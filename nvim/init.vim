
"Docs: https://wiki.archlinux.org/title/Neovim
nnoremap ,p "0p
nnoremap ,P "0P

"Enable copying text to system clipboard, Yikes!: src: https://www.reddit.com/r/neovim/comments/3fricd/comment/ctr8t3h/?utm_source=share&utm_medium=web2x&context=3
set clipboard+=unnamedplus 

augroup numbertoggle
   autocmd!
   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber nu
   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber nu
augroup END
"FYI: :set nu rnu will enable number and relativenumber option in vim runtime.
"FYI: :set nu! rnu! will nonumber and norelativenumber opotion in vim runtime.
