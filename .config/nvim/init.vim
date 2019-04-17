"================================================================
" 基本設定
"================================================================

" エンコーディングを設定
set encoding=utf-8
set fenc=utf-8
scriptencoding utf-8

" 自動生成ファイルの出力先指定
" neovimじゃないとデフォルトで変なところに出力されるのでまとめる
if !has('nvim')
    let back_path = expand('~/.vim/backup')
    let swap_path = expand('~/.vim/swap')
    let info_path = expand('~/.vim/viminfo')
    let undo_path = expand('~/.vim/undo')

    if !isdirectory(back_path)
        call mkdir(back_path, "p")
    endif
    if !isdirectory(swap_path)
        call mkdir(swap_path, "p")
    endif
    if !isdirectory(info_path)
        call mkdir(info_path, "p")
    endif
    if !isdirectory(undo_path)
        call mkdir(undo_path, "p")
    endif

    set backupdir=~/.vim/backup
    set directory=~/.vim/swap
    set viminfo+=n~/.vim/viminfo/viminfo.txt
    set undodir=~/.vin/undo
endif

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
" 括弧入力時の対応する括弧を表示
set showmatch
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
nnoremap <Space>qq :bd<CR>
" ハイライト解除
nnoremap <Space><Esc> :noh<CR>
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
Plug 'vim-airline/vim-airline'
" サイドバー表示のファイラ
Plug 'scrooloose/nerdtree'
" NERDTreeにファイルアイコンをつける
" Cicaフォントのインストールを推奨 --> https://github.com/miiton/Cica
Plug 'ryanoasis/vim-devicons'
" インデント可視化
Plug 'Yggdroot/indentLine'
" あいまい検索インターフェース
" ファイル検索やgrepでよく使う
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" コメントアウトのトグル <Ctrl--> か <Ctrl-_> で使える
Plug 'tomtom/tcomment_vim'
" 記号とかで列を揃える
Plug 'junegunn/vim-easy-align'
" 対応するカッコやクォーテーションを自動で入力してくれる
Plug 'kana/vim-smartinput'
" カレントディレクトリを自動で変えてくれる
Plug 'airblade/vim-rooter'
" テキストを囲うものを編集しやすくする (カッコやタグなど)
Plug 'tpope/vim-surround'
" Git操作をVimから。 :Gstatusが便利
Plug 'tpope/vim-fugitive'
" multiple cursor
Plug 'terryma/vim-multiple-cursors'
" denite
Plug 'Shougo/denite.nvim'
Plug 'chemzqm/denite-git'
" 補完・言語サーバクライアント
Plug 'Shougo/neoinclude.vim'
Plug 'jsfaint/coc-neoinclude'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() } }
" easymotion
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" 言語系
Plug 'plasticboy/vim-markdown'
Plug 'Townk/vim-autoclose'
Plug 'editorconfig/editorconfig-vim'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'beanworks/vim-phpfmt', { 'for': 'php' }
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'nikvdp/ejs-syntax', { 'for': 'ejs' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'vue', 'ejs', 'css', 'less', 'scss'] }
Plug 'posva/vim-vue', { 'for': 'vue' }

" その他
Plug 'simeji/winresizer'
Plug 'osyo-manga/vim-anzu'
Plug 'skywind3000/asyncrun.vim'

call plug#end()

" 行番号
autocmd ColorScheme * highlight LineNr ctermfg = 139
autocmd ColorScheme * highlight Visual ctermbg = lightblue

" leaderキー変更
let mapleader = ","

" airline設定
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

" vimdoc-ja ヘルプを日本語優先にする
set helplang=ja,en

" カラースキーム設定
silent! colorscheme challenger_deep

" 背景透過
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight TablineSel ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermbg=NONE guibg=NONE

" multiple cursor
let g:multi_cursor_start_word_key      = '<Space><C-n>'

" fzf 表示領域
let g:fzf_layout = { 'down': '~70%' }
" fzf 選択キー
let g:fzf_commands_expect = 'enter'

" fzf ripgrepによる高速grep
if executable('rg')
    command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 0,
        \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:50%')
        \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
        \ <bang>0)
endif

" easymotion設定
map <Space><Space> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

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

" NERDTree 現在のファイルを選択した状態でファイラを開く
nnoremap <Space>nf :NERDTreeFind<CR>
" NERDTree ファイラの表示切り替え
nnoremap <Space>nt :NERDTreeToggle<CR>

" fugitive & Denite git status
nnoremap <silent> <Space>s :<C-u>Gstatus<CR><Esc>
nnoremap <Space>ds :Denite gitstatus<CR>

" Denite
nnoremap <Space>d :Denite
nnoremap <Space>db :Denite buffer<CR>
nnoremap <Space>dr :Denite gitbranch<CR>

" Window操作
nnoremap <Space>wh <c-w>h
nnoremap <Space>wj <c-w>j
nnoremap <Space>wk <c-w>k
nnoremap <Space>wl <c-w>l
nnoremap <Space>wx :bd<CR>
nnoremap <Space>wr :WinResizerStartResize<CR>

" search操作
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

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

" vim-devicons 諸設定
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" dir-icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
let g:DevIconsDefaultFolderOpenSymbol = ''
" file-icons
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = ' '

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

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

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

" Use <c-space> for trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <Space>cd <Plug>(coc-definition)
nmap <silent> <Space>ct <Plug>(coc-type-definition)
nmap <silent> <Space>ci <Plug>(coc-implementation)
nmap <silent> <Space>cr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> <Space>csd :call <SID>show_documentation()<CR>

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
nmap <Space>car <Plug>(coc-rename)

" Remap for format selected region
vmap <Space>caf  <Plug>(coc-format-selected)
nmap <Space>caf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <Space>cac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Space>caq  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call   CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>cld  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>cle :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>clc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>clo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>cls  :<C-u>CocList -I --auto-preview symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" Resume latest coc list
nnoremap <silent> <space>clr  :<C-u>CocListResume<CR>
" CocList
nnoremap <space>ccc  :CocList 

" NERDTree設定
let NERDTreeShowHidden = 1
let g:NERDTreeWinPos="right"
function s:MoveToFileAtStart()
  call feedkeys("\<Space>")
  call feedkeys("\w")
  call feedkeys("\h")
endfunction
autocmd vimenter * NERDTree | call s:MoveToFileAtStart()
autocmd FileType vue syntax sync fromstart

" Python plugin
let g:python_host_prog='/usr/local/Cellar/python@2/2.7.16/bin/python'
let g:python3_host_prog='/usr/local/Cellar/python/3.7.3/bin/python3.7'

command! Filepath echo expand('%:p')
command! InitVim e ~/.config/nvim/init.vim
