"================================================================
" 基本設定
"================================================================

" エンコーディングを設定
set encoding=utf-8
set fenc=utf-8
scriptencoding utf-8

" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 終了時の保存確認
set confirm
"タイトルバーにファイルパス情報等の表示をする
set title
" 行番号を表示
set number
" バックアップファイルを作らない
set nobackup
set nowritebackup
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list,full
set wildignorecase
" コマンドラインの高さ
set cmdheight=1
" タブページ表示
set showtabline=2
" 不可視文字を可視化
set list listchars=tab:>-,trail:~
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=2
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" 置換時に g オプションをデフォルトでつける
set gdefault
" カーソルの回り込みを可能に
set whichwrap=b,s,h,l,[,],<,>
" BackSpace を空白、行頭、行末でも可能に
set backspace=indent,eol,start
" クリップボードへのコピー
set clipboard+=unnamedplus
" 畳み込み禁止
set nofoldenable
" スクロールに行数の余裕をもたせる
set scrolloff=7
" １行表示させる
set display=lastline
" 水平分割は下に作成する
set splitbelow

" ===============================================================
" Plugins
" プラグイン管理は "vim-plug" --> https://github.com/junegunn/vim-plug
"
" Install for Vim
"
" ```
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" ```
"
" Install for Neovim
"
" ```
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" ```
"
" プラグインを追加したら、このファイルを読み込み直して `:PlugInstall`
" を実行することでインストールされる
"
" ===============================================================

call plug#begin('~/.vim/plugged')

" Vimで非同期実行できるようにする
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" 日本語ヘルプ
Plug 'vim-jp/vimdoc-ja'
" カラースキーム
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
" ステータスバーなどの見た目を綺麗にする
Plug 'liuchengxu/eleline.vim'
" サイドバー表示のファイラ
Plug 'scrooloose/nerdtree'
" あいまい検索インターフェース
" ファイル検索やgrepでよく使う
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" 整形系
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-smartinput'
Plug 'itchyny/vim-parenmatch'
" Git
Plug 'sgur/vim-gitgutter'
" denite
Plug 'Shougo/denite.nvim'
" 補完
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" easymotion
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" 言語系
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'Townk/vim-autoclose'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'vue', 'ejs', 'css', 'less', 'scss'] }
Plug 'sheerun/vim-polyglot'
Plug 'othree/yajs.vim', { 'for': 'javascript' }

" tag系
Plug 'liuchengxu/vista.vim'

" その他
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-rooter'
Plug 'simeji/winresizer'
Plug 'osyo-manga/vim-anzu'
Plug 'skywind3000/asyncrun.vim'
Plug 'tyru/open-browser.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-repeat'
Plug 'thinca/vim-quickrun'
Plug 't9md/vim-choosewin'

call plug#end()

"================================================================
" 自動コマンド
"================================================================

" Quickfix の自動化
autocmd QuickFixCmdPost *grep* cwindow

" ペースト時の自動インデントと自動コメントアウトの無効化
autocmd FileType * setlocal formatoptions-=ro

"================================================================
" カーソル形状
"================================================================

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor


"================================================================
" キーマップ
"================================================================

" ---------------------------------------------------------------
" ノーマルモード & ビジュアルモードでのキーマッピング

" Exモード無効
noremap Q <Nop>
noremap gQ <Nop>

" ---------------------------------------------------------------
" コマンドモード & 挿入モードでのキーマッピング

" カーソル移動系
noremap! <c-f> <right>
noremap! <c-b> <left>
noremap! <c-a> <home>
noremap! <c-e> <end>
noremap! <c-d> <del>

" ---------------------------------------------------------------
" ノーマルモードでのキーマッピング

" 行末までコピー
nnoremap Y y$
" インクリメント＆デクリメント
nnoremap + <c-a>
nnoremap - <c-x>
" buffer close
nnoremap <silent><Space>qq :BD<CR>
" ハイライト解除
nnoremap <silent><Space><Esc> :noh<CR>
" 上下と入れ替えてインデント調整
nnoremap sj ddp==
nnoremap sk ddkP==

" ---------------------------------------------------------------
" コマンドモードでのキーマッピング
cnoremap <c-p> <up>
cnoremap <c-k> <up>
cnoremap <c-n> <down>
cnoremap <c-j> <down>

" ---------------------------------------------------------------
" 挿入モードでのキーマッピング
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kj <Esc><Right>
inoremap <C-]> <Esc><Right>

" 行を移動
nnoremap <S-Up> "zdd<Up>"zP
nnoremap <S-Down> "zdd"zp
" 複数行を移動
vnoremap <S-Up> "zx<Up>"zP`[V`]
vnoremap <S-Down> "zx"zp`[V`]

" その他のキーマッピング
imap <C-h> <BS>
inoremap <C-t> <Esc><Left>"zx"zpa

" terminal
if has('nvim')
  autocmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
else
  autocmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
endif

" 行番号
autocmd ColorScheme * highlight LineNr ctermfg = 139
autocmd ColorScheme * highlight Visual ctermbg = lightblue

" leaderキー変更
let mapleader = ";"

" leader action
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
nmap <leader>b  :Buffers<CR>
nmap <leader>f  :Files<CR>
nmap <leader>h  :History<CR>

" quickrun設定
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/vsplit'  : ':rightbelow 4sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }

nmap <silent><leader>d :QuickRun<CR>
nmap <silent><leader>dn  :QuickRun node<CR>
nmap <leader>da :QuickRun

autocmd FileType qf nnoremap <silent><buffer>q :quit<CR>

" git
nmap <silent><leader>gn :GitGutterNextHunk<CR>
nmap <silent><leader>gp :GitGutterPrevHunk<CR>
nmap <silent><leader>gt :GitGutterToggle<CR>
nmap <silent><leader>gs <Plug>GitGutterStageHunk
nmap <silent><leader>gr <Plug>GitGutterRevertHunk

nnoremap tig :<C-u>w<CR>:te tig<CR>

"eleline
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" easymotion設定
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" easymotion
map <silent> <leader>j <Plug>(easymotion-j)
map <silent> <leader>k <Plug>(easymotion-k)
map <silent> f <Plug>(easymotion-fl)
map <silent> t <Plug>(easymotion-tl)
map <silent> F <Plug>(easymotion-Fl)
map <silent> T <Plug>(easymotion-Tl)

" surround.vimと被らないように
nmap <silent> <leader>s <Plug>(easymotion-s2)
xmap <silent> <leader>s <Plug>(easymotion-s2)
omap <silent> <leader>s <Plug>(easymotion-s2)

" vimdoc-ja ヘルプを日本語優先にする
set helplang=ja,en

" カラースキーム設定
silent! colorscheme challenger_deep
highlight link ParenMatch MatchParen
let g:parenmatch_highlight = 0

" 背景透過
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight TablineSel ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermbg=NONE guibg=NONE

" fzf
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" fzf 表示領域
let g:fzf_layout = { 'down': '~70%' }
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

let g:fzf_action = {
            \ 'ctrl-t': 'edit',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit'}

" fzf ripgrepによる高速grep
if executable('rg')
    command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 0,
        \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:50%')
        \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
        \ <bang>0)
endif

" incsearch fuzzy jump
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
noremap <silent><expr> <leader>/ incsearch#go(<SID>config_easyfuzzymotion())

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" fzf コマンド検索
nnoremap <Space>fc :Commands<CR>
" fzf Gitプロジェクト内のファイル検索
nnoremap <Space>ff :GFiles<CR>
" fzf ファイル履歴検索
nnoremap <Space>fh :History<CR>
" fzf バッファ検索
nnoremap <Space>fb :Buffers<CR>
" fzf カレントディレクトリ以下でgrep検索
nnoremap <Space>fg :Rg<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" NERDTree 現在のファイルを選択した状態でファイラを開く
nnoremap <silent> <Space>nf :NERDTreeFind<CR>
" NERDTree ファイラの表示切り替え
nnoremap <silent> <Space>nt :NERDTreeToggle<CR>

" Denite
nnoremap <Space>d :Denite
nnoremap <Space>db :Denite buffer<CR>
nnoremap <Space>dr :Denite gitbranch<CR>

" Window操作
nnoremap <Space>wh <c-w>h
nnoremap <Space>wj <c-w>j
nnoremap <Space>wk <c-w>k
nnoremap <Space>wl <c-w>l
nnoremap <Space>wq :bd<CR>
nnoremap <Space>wr :WinResizerStartResize<CR>
nmap <silent><Space>wc <Plug>(choosewin)

" search操作
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

" toggle
nmap <silent> <Space>tf :NERDTreeToggle<CR>
nmap <silent><Space>tt :Vista!!<CR>
nmap <silent><Space>tg :GitGutterToggle<CR>

" denite
" denite/insert モードのときは，C- で移動できるようにする
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')

" insert mode keymap
call denite#custom#map('insert', "<C-a>", '<denite:do_action:open>')

" tabopen や vsplit のキーバインドを割り当て
call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')

" jj, jk, kj で denite/insert を抜けるようにする
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>')
call denite#custom#map('insert', 'jk', '<denite:enter_mode:normal>')
call denite#custom#map('insert', 'kj', '<denite:enter_mode:normal>')

" normal mode keymap
call denite#custom#map('normal', "v", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "o", '<denite:do_action:open>')
call denite#custom#map('normal', "c", '<denite:do_action:checkout>')
call denite#custom#map('normal', "r", '<denite:do_action:reset>')

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'

" filetypeごとにインデント幅を設定
augroup IndentSetting
  autocmd!
  autocmd FileType text setlocal shiftwidth=4
  autocmd FileType markdown setlocal shiftwidth=4
augroup end

" markdownはテキストを隠さない
let g:vim_markdown_conceal = 0

" Vim
let g:indentLine_color_term = 239

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" vista設定
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 0

" coc settings
set sessionoptions+=globals

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>rf  <Plug>(coc-format-selected)
nmap <leader>rf  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>y  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR

" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" NERDTree設定
let NERDTreeShowHidden = 1

autocmd FileType vue syntax sync fromstart
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Python plugin
let g:python_host_prog='/usr/local/Cellar/python@2/2.7.16/bin/python'
let g:python3_host_prog='/usr/local/Cellar/python/3.7.3/bin/python3.7'

command! Filepath echo expand('%:p')
command! InitVim e ~/.config/nvim/init.vim
