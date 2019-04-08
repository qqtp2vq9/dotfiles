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
" 現在の行を強調表示 (カーソル移動が重くなる)
" set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
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
nnoremap <Space>x :bd<CR>
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
Plug 'itchyny/lightline.vim'
" サイドバー表示のファイラ
Plug 'scrooloose/nerdtree'
" NERDTreeにファイルアイコンをつける
" Cicaフォントのインストールを推奨 --> https://github.com/miiton/Cica
Plug 'ryanoasis/vim-devicons'
" インデント可視化
Plug 'Yggdroot/indentLine'
" あいまい検索インターフェース
" ファイル検索やgrepでよく使う
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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
" スニペット挿入
Plug 'SirVer/ultisnips'
" スニペット リスト
Plug 'honza/vim-snippets'
" Git操作をVimから。 :Gstatusが便利
Plug 'tpope/vim-fugitive'
" mulitiple cursor
Plug 'terryma/vim-multiple-cursors'
" denite
Plug 'Shougo/denite.nvim'
Plug 'chemzqm/denite-git'
" Linter
Plug 'w0rp/ale'
" 補完
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" 言語サーバクライアント
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

" 言語系
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'pangloss/vim-javascript'
Plug 'Townk/vim-autoclose'

" PHP
Plug 'roxma/LanguageServer-php-neovim', {'do': 'composer install && composer run-script parse-stubs'}
Plug 'beanworks/vim-phpfmt'

" node
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'moll/vim-node'

" ejs
Plug 'nikvdp/ejs-syntax', { 'for': 'ejs' }

" vue
Plug 'posva/vim-vue', { 'for': 'vue' }

" front end
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'elmcast/elm-vim'
Plug 'leafgarland/typescript-vim'
Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }

" その他
Plug 'simeji/winresizer'
Plug 'osyo-manga/vim-anzu'

call plug#end()

" 行番号
autocmd ColorScheme * highlight LineNr ctermfg = 139
autocmd ColorScheme * highlight Visual ctermbg = lightblue
set cursorline
autocmd ColorScheme * highlight CursorLine

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

" lightline カレントディレクトリからの相対パス
function! LightLineFilename()
  return expand('%')
endfunction

" lightline ステータスバーの表示設定
let g:lightline = {
            \ 'component': {
            \   'readonly': '%{&readonly?"":""}',
            \   'coordinate': '%c: %l/%L',
            \   'truncate': '%<',
            \   'bubo': "",
            \ },
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified', 'readonly', 'gitbranch'], ['truncate']],
            \   'right': [['coordinate'], ['fileformat', 'fileencoding', 'filetype'], ['bubo', 'linter_errors', 'linter_warnings', 'linter_ok']]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'GitBranch'
            \ },
            \ 'separator': { 'left': "", 'right': " " },
            \ 'subseparator': { 'left': "", 'right': " " }
            \ }

" lightline タブバーの表示設定
let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': [ [ 'close' ] ] }

" lightline 色の設定
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" lightline コンポーネントが何を返すか
let g:lightline.component_expand = {
            \ 'tabs': 'lightline#tabs',
            \ 'linter_warnings': 'LightlineLinterWarnings',
            \ 'linter_errors': 'LightlineLinterErrors',
            \ 'linter_ok': 'LightlineLinterOK'
            \ }

" lightline コンポーネントの表示色
let g:lightline.component_type = {
            \ 'tabs': 'tabsel',
            \ 'readonly': 'error',
            \ 'linter_warnings': 'warning',
            \ 'linter_errors': 'error'
            \ }

" lightline 現在のgitブランチ
function! GitBranch() abort
  let l:branch = fugitive#head()
  return l:branch == '' ? '' : printf(" %s", branch)
endfunction

" lightline ALEのエラー数
" ale
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf("%d ", all_errors)
endfunction

" lightline ALEの警告数
" ale
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf("%d ", all_non_errors)
endfunction

" lightline OK
" ale
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? "" : ''
endfunction

" lightline Lint時にlightline表示更新
" ale
augroup LightLineOnALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END

" fzf 表示領域
let g:fzf_layout = { 'down': '~70%' }
" fzf 選択キー
let g:fzf_commands_expect = 'enter'

" fzf ripgrepによる高速grep
if executable('rg')
    command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --line-number --no-heading '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'up:50%:wrap'))
endif

" fzf コマンド検索
nnoremap <Space>p :Commands<CR>
" fzf ホームディレクトリからのファイル検索
" nnoremap <silent> <Space>ff :Files ~/<CR>
" fzf Gitプロジェクト内のファイル検索
nnoremap <Space>f :GFiles<CR>
" fzf ファイル履歴検索
nnoremap <Space>h :History<CR>
" fzf バッファ検索
nnoremap <Space>bf :Buffers<CR>
" fzf カレントディレクトリ以下でgrep検索
nnoremap <Space>g :Rg<CR>

" NERDTree 現在のファイルを選択した状態でファイラを開く
nnoremap <Space>n :NERDTreeFind<CR>
" NERDTree ファイラの表示切り替え
nnoremap <Space>e :NERDTreeToggle<CR>

" fugitive & Denite git status
nnoremap <silent> <Space>s :<C-u>Gstatus<CR><Esc>
nnoremap <Space>ss :Denite gitstatus<CR>

" Denite
nnoremap <Space>u :Denite
nnoremap <Space>bb :Denite buffer<CR>
nnoremap <Space>br :Denite gitbranch<CR>

" Window操作
nnoremap <Space>wh <c-w>h
nnoremap <Space>wj <c-w>j
nnoremap <Space>wk <c-w>k
nnoremap <Space>wl <c-w>l

" search操作
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

" denite
" denite/insert モードのときは，C- で移動できるようにする
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')

" tabopen や vsplit のキーバインドを割り当て
call denite#custom#map('insert', "<C-t>", '<denite:do_action:tabopen>')
call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>')
call denite#custom#map('normal', "v", '<denite:do_action:vsplit>')

" jj, jk, kj で denite/insert を抜けるようにする
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>')
call denite#custom#map('insert', 'jk', '<denite:enter_mode:normal>')
call denite#custom#map('insert', 'kj', '<denite:enter_mode:normal>')


" ale 諸設定
let g:ale_set_highlights = 1
" let g:ale_fix_on_save = 1
let g:ale_linters = {
      \ 'html': [],
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'vue': ['eslint']
      \ }
" let g:ale_fixers = {
"       \ 'javascript': ['prettier']
"       \ }
let g:ale_sign_column_always = 1
let g:ale_javascript_prettier_use_local_config = 1

" カーソル表示
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[0 q"

if has('nvim')
    let g:deoplete#enable_at_startup = 1

    " python3 設定
    let g:python3_host_prog = '/usr/local/bin/python3'
    " LanguageClient
    " 各言語の Language Server 設定
    let g:LanguageClient_serverCommands = {
                \ 'html': ['html-languageserver', '--stdio'],
                \ 'css': ['css-languageserver', '--stdio'],
    	        \ 'javascript': ['~/.nodebrew/node/v8.15.0/bin/javascript-typescript-stdio'],
    	        \ 'typescript': ['~/.nodebrew/node/v8.15.0/bin/javascript-typescript-stdio'],
                \ 'vue': ['vls']
                \ }
    let g:LanguageClient_autoStart = 1

    " LanguageClient カーソル下のドキュメント表示
    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    " LanguageClient カーソル下の定義ジャンプ
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    " LanguageClient カーソル下のリネーム
    nnoremap <silent> <Space>lr :call LanguageClient_textDocument_rename()<CR>
    " LanguageClient シンボルリスト
    nnoremap <silent> <Space>ls :call LanguageClient_textDocument_documentSymbol()<CR>
    " LanguageClient カーソル下の参照リスト
    nnoremap <silent> <Space>ll :call LanguageClient_textDocument_references()<CR>
    " LanguageClient テキスト整形
    nnoremap <silent> <Space>lf :call LanguageClient_textDocument_formatting()<CR>
    " LanguageClient 範囲のテキスト整形
    nnoremap <silent> <Space>lF :call LanguageClient_textDocument_rangeFormatting()<CR>
endif

" UltiSnips スニペット展開
let g:UltiSnipsExpandTrigger="<c-k>"
" UltiSnips スニペット次の位置に移動
let g:UltiSnipsJumpForwardTrigger="<c-j>"
" UltiSnips スニペット前の位置に戻る
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" UltiSnips スニペットエディタの表示方法
let g:UltiSnipsEditSplit="vertical"

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

" 自作スニペット置場
set runtimepath+=~/.vim/snippets
let g:UltiSnipsSnippetsDir = '~/.vim/snippets'

" deoplete auto complete
set completeopt+=noinsert

" Mac vimr用
if has('gui_vimr')
    " cursorlineすると遅くなる
    set nocursorline
endif

" smartinput設定
call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',
      \                        '<BS>',
      \                        '<BS>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)',
      \                        '<BS>',
      \                        '<C-h>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',
      \                        '<Enter>',
      \                        '<Enter>')

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB> 
      \ pumvisible() ? "\<C-p>" : "\<C-h>"

" <BS> で閉じて文字削除
imap <expr> <BS>
      \ deoplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
" <C-h> で閉じる
imap <expr> <C-h>
      \ deoplete#smart_close_popup()
" <CR> で候補を選択し改行する
" ポップアップがないときには改行する
imap <expr> <CR> pumvisible() ?
      \ deoplete#close_popup() : "\<Plug>(smartinput_CR)"

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1

" NERDTree設定
let NERDTreeShowHidden = 1
function s:MoveToFileAtStart()
  call feedkeys("\<Space>")
  call feedkeys("\w")
  call feedkeys("\l")
endfunction
autocmd vimenter * NERDTree | call s:MoveToFileAtStart()
autocmd FileType vue syntax sync fromstart

command! Filepath echo expand('%:p')
command! InitVim e ~/.config/nvim/init.vim
