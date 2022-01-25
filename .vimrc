nnoremap ,p "0p
nnoremap ,P "0P

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber nu
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber nu
augroup END

"set mouse=a
"         ^this enables my mouse scrollbar to scroll screen instead of moving the cursor. 
"         FUCK (so I disabled it):: Also this disables my copy text to clipboard when selected by mouse.
" , also mouse scroll now works identical to ctrl+e(up) and ctrl+y(down).

set so=7
"      ^ this is :: 'scrolloff' 'so' number (default 0) global.
" Minimal number of screen lines to keep above and below the cursor.

set timeoutlen=10 "This makes the esc key to work immediately i.e., if you have some text selected in visual mode then you can see a significant delay without this switch(default value is 1000 i.e., 1sec, I guess; src: https://vi.stackexchange.com/a/20220

" >>>>> vim-plug >>>>> https://github.com/junegunn/vim-plug#example
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'yuttie/comfortable-motion.vim'
"src: https://github.com/yuttie/comfortable-motion.vim

" Initialize plugin system
call plug#end()
" <<<<<< vim-plug
