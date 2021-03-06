
set expandtab
retab 2
set tabstop=2
set shiftwidth=2

syntax on

set t_Co=256

set number
set autoread
set showcmd
set mouse=a
set autoindent
set hlsearch
set incsearch
set splitbelow
set belloff=all
set background=dark
set noswapfile
set nobackup
set clipboard+=unnamedplus

syntax enable
nnoremap x "_x
"nnoremap d "_d
nnoremap D "_D
nnoremap diw "_diw

nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

set splitbelow

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/async.vim'
" Plug 'w0ng/vim-hybrid'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tomasr/molokai'
Plug 'neoclide/coc.nvim', {'blanch': 'release'}
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'easymotion/vim-easymotion'
call plug#end()

let g:airline_theme = 'luna'
let g:airline#extensions#tabline#enabled = 1
let g:typescript_indent_disable = 1

" autocmd ColorScheme * highlight LineNr ctermfg=244
" set background=dark
colorscheme molokai


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
 nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
 nnoremap <silent><buffer><expr> c
 \ defx#do_action('copy')
 nnoremap <silent><buffer><expr> m
 \ defx#do_action('move')
 nnoremap <silent><buffer><expr> p
 \ defx#do_action('paste')
 nnoremap <silent><buffer><expr> l
 \ defx#do_action('drop')
 nnoremap <silent><buffer><expr> t
 \ defx#do_action('open','tabnew')
 nnoremap <silent><buffer><expr> E
 \ defx#do_action('drop', 'vsplit')
 nnoremap <silent><buffer><expr> P
 \ defx#do_action('drop', 'pedit')
 nnoremap <silent><buffer><expr> o
 \ defx#do_action('open_or_close_tree')
 nnoremap <silent><buffer><expr> K
 \ defx#do_action('new_directory')
 nnoremap <silent><buffer><expr> N
 \ defx#do_action('new_file')
 nnoremap <silent><buffer><expr> M
 \ defx#do_action('new_multiple_files')
 nnoremap <silent><buffer><expr> C
 \ defx#do_action('toggle_columns',
 \'mark:indent:icon:filename:type:size:time')
 nnoremap <silent><buffer><expr> S
 \ defx#do_action('toggle_sort', 'time')
 nnoremap <silent><buffer><expr> d
 \ defx#do_action('remove')
 nnoremap <silent><buffer><expr> r
 \ defx#do_action('rename')
 nnoremap <silent><buffer><expr> !
 \ defx#do_action('execute_command')
 nnoremap <silent><buffer><expr> x
 \ defx#do_action('execute_system')
 nnoremap <silent><buffer><expr> yy
 \ defx#do_action('yank_path')
 nnoremap <silent><buffer><expr> .
 \ defx#do_action('toggle_ignored_files')
 nnoremap <silent><buffer><expr> ;
 \ defx#do_action('repeat')
 nnoremap <silent><buffer><expr> h
 \ defx#do_action('cd', ['..'])
 nnoremap <silent><buffer><expr> ~
 \ defx#do_action('cd')
 nnoremap <silent><buffer><expr> q
 \ defx#do_action('quit')
 nnoremap <silent><buffer><expr> <Space>
 \ defx#do_action('toggle_select') . 'j'
 nnoremap <silent><buffer><expr> *
 \ defx#do_action('toggle_select_all')
 nnoremap <silent><buffer><expr> j
 \ line('.') == line('$') ? 'gg' : 'j'
 nnoremap <silent><buffer><expr> k
 \ line('.') == 1 ? 'G' : 'k'
 nnoremap <silent><buffer><expr> <C-l>
 \ defx#do_action('redraw')
 nnoremap <silent><buffer><expr> <C-g>
 \ defx#do_action('print')
 nnoremap <silent><buffer><expr> cd
 \ defx#do_action('change_vim_cwd')
endfunction


call defx#custom#option('_', {
  \ 'winwidth': 40,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 1,
  \ 'buffer_name': 'exproler',
  \ 'toggle': 1,
  \ 'resume': 1,
  \ 'columns': 'indent:icons:filename:mark',
  \ })


" nmap <leader>s <Plug>(easymotion-s2)
map <leader>s <Plug>(easymotion-bd-f2)
map <leader>l <Plug>(easymotion-bd-jk)
