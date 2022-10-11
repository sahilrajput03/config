" Fish doesn't play all that well with others
" ~ SAHIL: Read the shortcuts of language server usage below:
" My notes: C-n/p to search down and up in the autocomplete suggestions list.
" EXIT LSP DEFINITIONS WITH ctrl+o ~with Ratanjeet.
" Enable completion triggered by <c-x><c-o>
" :h lsp
" :LspInstall tsserver "Src: https://youtu.be/tOjVHXaUrzo
"..CODE STARTS HERE..
"
"

" ------- ALERT ALERT ALERT ALERT ALERT ALERT -------
" WHILE INSTALLING ON SOME OTHER SYSTEM, you may need to copy nvim directory
" to ~/.config directory instead of ~ directory to make it work and simply
" :PlugInstall should work !!


" Set ctrl+/ to comment code simply
" Commenting using `c+/` hotkey. Src: https://github.com/tpope/vim-commentary/issues/36#issuecomment-60329227
" map <C-_> <Plug>Commentary
map <C-_> gcl0
"		  ^^^^ This is a clever hack of my own hit and tria method, so now simple ctrl+/ work phenomenally.

"Tetsing map commands from vim fandom: Source: https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)#:~:text=Key%20mapping%20refers%20to%20creating,define%20your%20own%20Vim%20commands.
" MY LEARNINGS: 
"The ':map' command creates a key map that works in normal, visual, select and operator pending modes.
"The ':map!' command creates a key map that works in insert and command-line mode.
"THOUGH: A better alternative than using the 'map' and 'map!' commands is to use mode-specific map commands
:map <F2> :echo 'Current time is ' . strftime('%c')<CR>
:map! <F3> <C-R>=strftime('%c')<CR>

" Map c-s to save a file. ~Sahil, Source: https://stackoverflow.com/a/3448551/10012446
" LEARN: read below acronym as: "no re-map" meaning that mapping can't be changed or say in real terms its non recursive (source: https://stackoverflow.com/a/10272179/10012446).
" Originally: ~sahil, from source of above SO link.
" noremap <silent> <C-S>          :update<CR>
" vnoremap <silent> <C-S>         <C-C>:update<CR>
" inoremap <silent> <C-S>         <C-O>:update<CR>
"
" I mapped the hotkey to actual save command now, i.e, ```:w```:
noremap <silent> <C-S>          :w<CR>
vnoremap <silent> <C-S>         <C-C>:w<CR>
inoremap <silent> <C-S>         <C-O>:w<CR>


" ORIGINALLY FROM JOHNHOO.
" set shell=/bin/bash
let $BASH_ENV = "~/.vim_bash_env"
" USING ABOVE ONLY,,,, WAS(some error log conflict with tmux can't assign terminal group shit...) USING BELOW TO SOURCE INTERACTIVE SHELL SO THAT I CAN USE ALIASES DEFINED IN
" .bashrc file simply, src: https://stackoverflow.com/a/8946710/10012446
" DONT ENABLE THIS AS THIS CAUSES CRITICAL trouble with Prettier autoformatting.
" set shell=/bin/bash\ -i


"Enable copying text to system clipboard ~SAHIL, Yikes!: src: https://www.reddit.com/r/neovim/comments/3fricd/comment/ctr8t3h/?utm_source=share&utm_medium=web2x&context=3
set clipboard+=unnamedplus 

" Keep clipboard text even after exiting vim/nvim: src: https://stackoverflow.com/a/9381778/10012446
autocmd VimLeave * call system("xsel -ib", getreg('+'))



let mapleader = "\<Space>"

"ADDING RENAMING A FILE FUNCTIONALITY; src: https://vi.stackexchange.com/a/307, also, david pedersen using same below code though.
map <leader>ren :call RenameFile()<cr>
"Usage: Use <space>ren to get the renaming prompt.
"FYI: If you feel restricted, you can use another plugin that helps in couple
"of other similar features like renaming as well. Find it here: https://github.com/tpope/vim-eunuch , source: https://vi.stackexchange.com/a/306

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" =============================================================================
" # PLUGINS
" =============================================================================
" Load vundle.vim: src: https://github.com/VundleVim/Vundle.vim
set nocompatible
filetype off
"set rtp+=~/nvim/bundle/Vundle.vim
"set rtp+=~/.vim/bundle/Vundle.vim
" I am NOT loadig vundle at all.
"
" Load vim-plug: SRC: https://github.com/junegunn/vim-plug
" FYI: Use command :PlugInstall to install all below plugins from inside neovim.
call plug#begin()
" Load plugins
" Sahil (from David Pedersen's ```dotfiles``` repository): Github: https://github.com/tpope/vim-commentary
Plug 'tpope/vim-commentary'
"Usage: You need to select lines and use gc to toggle commenting lines.
"Usage: To comment current line only, then use gc l
"Usage: To comment all lines inside braces, use gc i{
"Usage: To comment all lines including(around) braces, use gc a{

" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
Plug 'chriskempson/base16-vim' " ~Sahil so that base16 colors can be accessed.

" GUI enhancements
Plug 'itchyny/lightline.vim' "This is the green/blue line in the bottom of nvim you. ~Sahil
Plug 'machakann/vim-highlightedyank' "This shows colour for the yanked text for a second.
Plug 'andymass/vim-matchup'

" Fuzzy finder
" NOTE: ~Sahil, if you are getting node_modules folder in the ctrl-p dialog
" boz then you can simply get rid of it by simly making the current folder a
" git repo via ```git init``` or making any of its parent folder simply.
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Earlier I used to use ^^^ but now following official docs, I am using below:
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" From docs ~Sahil.
" export FZF_CTRL_T_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*, **/.yarn.lock}'"
"FYI SAHIL: You must have proximity-sort package on your linux as well coz
"that might be a problem to search functionality implemented by fzf vim library
"for search functionality. So make sure you have it installed: Source of
"```proximity-sort```: https://aur.archlinux.org/packages/proximity-sort

Plug 'airblade/vim-rooter' "rooter identifies the root directory in any project, yikes!
let g:rooter_patterns = ['vimrooter', 'package.json'] "This sets any nearest parent folder which has src named folder (searched breadfirst) as project root. Set project root directory with ``vim-rooter``. FYI: vim-rooter uses ``:cd folderPathHere`` to set the ``pwd`` folder in nvim it can be relative or absolute. Rooter works too great for fzf coz it allows fzf to search only in the current project folder i.e., with the help of searching in the path of project.
" I don't want src to be included so amending this...>>> let g:rooter_patterns = ['=src', 'package.json'] "This sets any nearest parent folder which has src named folder (searched breadfirst) as project root. Set project root directory with ``vim-rooter``. FYI: vim-rooter uses ``:cd folderPathHere`` to set the ``pwd`` folder in nvim it can be relative or absolute. Rooter works too great for fzf coz it allows fzf to search only in the current project folder i.e., with the help of searching in the path of project.

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
" Read what is vim-clang-format ~sahil @ https://github.com/rhysd/vim-clang-format
Plug 'rhysd/vim-clang-format'
"Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" prettier support for js/ts formatting ~Sahil: source: https://github.com/prettier/vim-prettier

" Need to test this...:
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'branch': 'release/0.x'
  \ }
" USE BELOW CONFIGURATION INSTEAD IF YOU WANT TO ENABLE FORMATTING FOR ONLY
" CERTAIN FILE TYPES SAY .js and .ts FILES ONLY.
" AND DON"T FORGET TO COMMENT ABOVE PLUGIN AND DOING ```:PlugInstall!```. Note
" the ending ! which says force install coz thats IMPORTANT to make it function.
" Source: https://github.com/prettier/vim-prettier#install
" certain fileypes.
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install --frozen-lockfile --production',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }



" Install nerdtree
Plug 'preservim/nerdtree'
call plug#end()

" I AM DISABLING FORMATTTING ON FILE ON SAVE, FROM NOW ON! 8 APRIL, 2022
" Enable autoformatting. (FYI: Autoformatting is done for file with "@format" or "@prettier" tag at top will only be formatted.
" let g:prettier#autoformat = 1
" Allow auto formatting for files without "@format" or "@prettier" tag
" let g:prettier#autoformat_require_pragma = 0


" Enable async formatting by default: ~Sahil, from official docs @ https://github.com/prettier/vim-prettier
let g:prettier#exec_cmd_async = 1
" By default we auto focus on the quickfix when there are errors but can also be disabled, src: https://github.com/prettier/vim-prettier#usage
let g:prettier#quickfix_auto_focus = 0

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    " noremap <C-q> :confirm qall<CR> "ORIGINALLY FROM jonhoo.
    noremap <leader>z :confirm qall<CR>
end

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
set background=dark
let base16colorspace=256
let g:base16_shell_path="~/nvim/base16-gruvbox-scheme" "THIS IS NOT WORKING IMO ~NEED HELP ON THIS. ~SAHIL.
"colorscheme base16-gruvbox-light-soft
"Lost of themes @ https://github.com/chriskempson/base16
syntax on
" hi Normal ctermbg=NONE

" Customize the highlight a bit.
" Make comments more prominent -- they are important.
"call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
" Make it clearly visible which argument we're at.
"call Base16hi("LspSignatureActiveParameter", g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold", "")
" Would be nice to customize the highlighting of warnings and the like to make
" them less glaring. But alas
" https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
"call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")

" LSP configuration
lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
	postfix = {
	  enable = false,
	},
      },
    },
  },
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl"
                \ ]
                " Removing default color column setting from above:
				" \ "colorcolumn",
" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Javascript
let javaScript_fold=0

" Java
let java_ignore_javadoc=1

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
"let g:rust_clip_command = 'xclip -selection clipboard'
" ~SAHIL, commenting above line and now I get clipboard and buffer connected
" in rust files as well, Yikes!

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/go/bin")

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set timeoutlen=1500 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
" To enable/disable wrap, #unwrap, #wrap
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo "This helps in retaining the undo history even after you
" close the file, so its helpful like when you need to undo things in a file
" that you changed weeks ago(say a system config file).
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor


" Here I am setting one tab width equals to 4 spaces width, ~Sahil. Src: https://stackoverflow.com/a/1878987/10012446
" set sw=4 "sw is just alias of shiftwidth, though which I am setting below.

" Use wide tabs
" I am setting shiftwidth to 4 spaces wide now! ~Sahil. Src: https://stackoverflow.com/a/1878987/10012446
set shiftwidth=4
set softtabstop=8
set tabstop=4 "This works good to set the size of the tab! ~Sahil.
set noexpandtab
" set shiftwidth=8 "Originally.
" set softtabstop=8 "Originally.

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
" Show linewidth color line @ 80, 100, 120, etc, WITH ```set cc=```, I am disabling colorcolumn.
" set colorcolumn=100 " and give me a colored column
" set cc=
"Src: https://vi.stackexchange.com/a/6989
"
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :

" Ctrl+j and Ctrl+k as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f, I don't know what suspend is for so I am commenting it
" for now. ~Sahil
" inoremap <C-f> :sus<cr>
" vnoremap <C-f> :sus<cr>
" nnoremap <C-f> :sus<cr>

" Instead I am using my old ,p and ,P to get copy register contents.
" Why thes? story: You copied something, then cut something, but you want get
" what you copied earlier but thats now possible now, coz you cut's content is
" in default copy register.
" But why 0 register?? ~Sahil.
" Ans. Try yanking anything and try pasting with p and "0p, you'll notice that
" both the registers will have your yanked text. And anytime you delete or cut
" anything that'll copy to default register(p) but won't edit 0 register. So
" thats why this "0p works!!
nnoremap ,p "0p
nnoremap ,P "0P
"^ first n means normal mode, then nore means non recursive.
"vim is a modal text editor. Read more about it @ https://stackoverflow.com/a/3776182/10012446

" Make ,p and ,P bindings work in visual mode as well, ROCKS, WORKS AMAZING!
xnoremap ,p "0p
xnoremap ,P "0P
" vim is modal text editor, and it rocks,, read about different type of
" bindings above @ ^^^^^ stackoverflow question. Yo!

" map p to "0p ()
" nnoremap p "0p

"Map x to simply delete i.e., don't put it to default clipboard
"register but use _ register
" nnoremap x "_x

" Map d to simply delete (not cut), so now we can use x to use cut
" functionality thogh. Yikes!
" nnoremap d "_d
" what is "_ in above??  AWESOME READ @ https://stackoverflow.com/a/20922502/10012446

" Jump to start and end of line using the home row keys ~SAHIL ~SUPERB FROM
" JONHOO. #h and l
" map H ^ "Originally.
map H 0
"^^^ I made it to use 0 instead, ~Sahil
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
" noremap <leader>p :read !xsel --clipboard --output<cr>
" noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Rg search
noremap <leader>s :Rg<space>
let g:fzf_layout = { 'down': '~20%' }
" ~Sahil, below command WORKS GOOD and it is executed only when you type Rg in the command(you
" you hv shortcut to it with ```<space>s``` as well.
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -g "!{**/package-lock.json,**/node_modules/**,**/yarn.lock}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  " FYI: Sahil, The first case in below ternary executes when no file is
  " opened and you try to use :Files, and second is obvious(i.e., any files is
  " already open).
  return base == '.' ? 'fd --type file --follow --exclude "node_modules"' : printf('fd --type file --follow --exclude "node_modules" | proximity-sort %s', shellescape(expand('%')))
  " Originally node_modules was not ignored so now I am ignoring it.
  " return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction
" ~Sahil, what does proximity-sort does? Ans. https://github.com/jonhoo/proximity-sort

" SAHIL: FYI:(Below is called when you type `:Files` or uses your <c-p> to get a
" fuzzy search) SAHIL, I am calling s:list_cmd function which which is defined above^^^.
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)
  " ~Sahil,experiments below!
  " \ call fzf#vim#files(<q-args>, <bang>0)

" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" Left and right can switch buffers
" So ~SAHIL, we can use :bp and :bn to switch between previous and next opned files (buffers) yikes!!
" nnoremap <left> :bp<CR>
" nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>b shows stats (~Sahil, I modified it, originally <leader>q ).
nnoremap <leader>e g<c-g> "This is simulating typing g ctrl-g

" ~Sahil (NEWLY ADDED) :: <leader>z closes current buffer.
" LEARN: <CR> anywhere in this file means <Carriage Return> key.
" nnoremap <leader>z :bw!<CR> "originally working.
" nnoremap <C-W> :bw<CR> " Trying to map ctrl+w to close buffer. ( NOT USING
" ^^^^COZ C-W is reserved for window management in vim.
"My new binding works super cool! Yikes!!
nnoremap <c-q> :bw!<CR>

" ~Sahil (NEWLY ADDED) :: <leader>Z closes current buffer FORCELY.
" nnoremap <leader>Z :bw!<CR>
" nnoremap <c-Q> :bw!<CR>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>


" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Follow Rust code style rules
au Filetype rust source ~/nvim/scripts/spacetab.vim
" au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/nvim/scripts/closetag.vim

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

" ~SAHIL: Source: https://stackoverflow.com/a/1117532/10012446
highlight Normal ctermfg=grey ctermbg=black

" Set vim bracket highlighting colors, ~Sahil: Src: https://stackoverflow.com/a/10746829/10012446
hi MatchParen cterm=none ctermbg=green ctermfg=blue

"Setting background color, source: https://stackoverflow.com/a/1117532/10012446
hi Normal ctermfg=grey ctermbg=black
" Hint: try changing ctrembg to red and reload config to see what it does ~Sahil.

" Using this will allow you to see selcted text in color even in ubuntu-server
" like operating system.
hi Visual cterm=reverse ctermbg=NONE

" This disables spellbad highlights from nvimlsp, you can get help on this
" via: ```:h hi```
hi clear spellbad

" Loading nvim/init.vim config file without reloading neovim(should also works
" vim as well). SRC: https://vi.stackexchange.com/a/26627
" FYI: mapping it to <leader>r causes to wait for 1 whole second, which is
" abusrd, TODO: fix it some day, coz i have `C-t r` to reload config in tmux
" as well so it would be good if i use `<leader>r` to reload in vim as well.
nnoremap <leader>l :source $MYVIMRC<CR>

" Buffer navigation with alt+h and alt+l keys.
" I can use these command to switch to buffers to but currently using alt key
" to do that.
" map gn :bn<cr>
" map gp :bp<cr>
" map gd :bd<cr>  
" ---
map <M-h> :bp<cr>
map <M-l> :bn<cr>
" I made above bindings by refering to docs of nvim, i.e., `:help key-notation`

" Trying to switch to windows using ctrl+hjkl
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


" To unhighlight after search, you need to do :noh or :nohighlight Src: https://stackoverflow.com/a/99182/10012446
map gs :noh<CR>
" To update github repo.
map gu :!gac Update.<CR>
" map gu :!gacp Update.<CR>
" To show recent files ~Sahil
map gh :His<CR>

" I might WORK THIS SOME OTHER DAY.
" Mapping getting out of terminal in vim via ctrl+n (BELOW DID'T work for now):
" None of below worked!
" map <C-n> <C-Bslash> <C-n>
" map <C-n> <C-\><C-n>
" map <C-n> <C-\> <C-n>
"

" To toggle wrapping, src: https://stackoverflow.com/a/248165/10012446
map gz :set wrap!<cr>

" IMPORTANT: TO know what setting is getting overridden from anywhere?
"https://stackoverflow.com/a/37528484/10012446
" Use command like: verbose set colorcolumn
" WHERE colorcolumn is the setting i want to check, like what is the
" effectively line thats getting used in current setting.


" Zoom current window and restore back to all window equal width:
" src: https://medium.com/@vinodkri/zooming-vim-window-splits-like-a-pro-d7a9317d40
" Original, (mapping Zz and Zo)
" noremap Zz <c-w>_ \| <c-w>\|
" noremap Zo <c-w>=
" My mapping with ,
noremap <leader>i <c-w>_ \| <c-w>\|
noremap <leader>o <c-w>=




" AMAZING:: Map [ to { and ] to }
" src: https://vi.stackexchange.com/a/36531
set langmap=[{,]}


" Remove <C-w>n binding:
map <C-w>n <Nop>

" Enable creating new window with `<C-w>c` instead of default `<C-w>n`:
nmap <C-w>c :wincmd n<CR>
" FYI: I couldn't map `<C-w>c` to `<C-w>n` coz i nullified that binding in a previously
" above in this config file.

" learned about :wincmd from :: https://vim.fandom.com/wiki/Switch_between_Vim_window_splits_easily
"
"
" Enabel indented folding in vim:
" HEY>> BELOW WON"T WORK COZ AS I CHECKED WITH `:verbose set foldmethod`
" command the settings are comming from syntax file of javascript from nvim
" internals and to overwrite that we must use autocmd. src: https://stackoverflow.com/a/68813146/10012446
" SO, I added set foldmethod=indent to my `~/nvim/filetype.vim` file, yikes,
" it works!!
" set foldmethod=indent   
" set foldnestmax=10
" set nofoldenable
" set foldlevel=2
" USAGE:
" zR Reveal all folds at once.
" zM Closes all folds at once.
" zo opens current fold only.
" zc close current fold only.(this was performing buggy for me coz I wasn't
" using foldlevel=10, src: https://stackoverflow.com/a/5786588/10012446!)
"
set foldlevel=10
" src: https://stackoverflow.com/a/5786588/10012446
"

" Renaming multiple variables occurences very fast!!
" LEARN: gdcgn<enter_new_varirable_name><ESC> and now press . to do it multiple times.
" LEARN: gdcdn<enter_new_varirable_name><ESC> and now type :%norm.
" src: https://vi.stackexchange.com/questions/18004/renaming-variables
"
"
" LEARN: 
" :%norm.
" ^^^ What does this do??
" Actually it runs the command which you just did to the whole file!! Yikes!!!


" Search the visually selected text:
" NATIVE APPROACH IS TO USE IT LIKE: yank some text, then press /CTRL+r 0
" SRC^^^^: https://stackoverflow.com/a/363125/10012446
" ALSO THIS TEACHES HOW TO PASTE TEXT FROM BUFFER TO COMMAND MODE WHENEVER YOU
" NEED TO DO THAT!!
"
" Usage: Select some text and type // to do search, and navigate with n to
" search forward and N to search backward.
" src: https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"
"
" Fyi: * search forward and # searchs backward for a variable definition.
"
"
"

" HIGHLIGHT the search items when you are circling on them beautifully:
" src: https://vi.stackexchange.com/a/2770/41399
" Damian Conway's Die Blinkënmatchen: highlight matches
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction


" Enable linebreaking so that if I have turned on line wrap the lines will
" break at whitespaces(i.e., words will not fit like how many in the screen
" can fit in real), yikes!
set linebreak
" src: https://stackoverflow.com/a/19624717/10012446


" Run build command via `gb`
" map gb :!node ./main.js <CR>
map gb :!node % <CR>
" src: https://unix.stackexchange.com/a/7853/504112
"

" NEW KEYBINDINGS for nerdTree (explorer for vim editors: https://github.com/preservim/nerdtree)
" You can view all default bindings via: :NERDTree and then press ?
" FYI: LEARN FUN: Simply press ? in the nerd tree explore and you can see the
" all the shortcuts, yikes!
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>
" ~Sahil, you only need these two bindings to use this new nerdTree explore
" with power!
nnoremap <leader>b :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFocus<CR>
