"Docs: https://wiki.archlinux.org/title/Neovim

"Getting text from copy register instead of cut/copy register (i.e, p or P ):
"I am simply remapping keys \"0p to ,p and \"0P to ,P below:
nnoremap ,p "0p
nnoremap ,P "0P

"Enable copying text to system clipboard, Yikes!: src: https://www.reddit.com/r/neovim/comments/3fricd/comment/ctr8t3h/?utm_source=share&utm_medium=web2x&context=3
set clipboard+=unnamedplus 

"Enable dynamically chainging relative number toggling in edit mode.
augroup numbertoggle
   autocmd!
   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber nu
   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber nu
augroup END
"FYI: :set nu rnu will enable number and relativenumber option in vim runtime.
"FYI: :set nu! rnu! will nonumber and norelativenumber opotion in vim runtime.
