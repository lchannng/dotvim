" File  : plugins.vim
" Author: Lch <fn.stanc@gmail.com>
" Date  : 2018/12/01 16:14:46

"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
    let g:bundle_group = ['basic', 'airline', 'programming']
    let g:bundle_group += ['tags']
    " let g:bundle_group += ['neocomplete']
    let g:bundle_group += ['coc.nvim']
endif

"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
    let path = expand(s:home . '/' . a:path )
    return substitute(path, '\\', '/', 'g')
endfunc

let s:plugins_home = s:path("plugins")
let s:vim_plug_home = s:path("vim-plug")

filetype off                    " required!

exec 'set rtp+='.s:vim_plug_home
call plug#begin(s:plugins_home)

"----------------------------------------------------------------------
" 默认插件
"----------------------------------------------------------------------
Plug 'tomasiser/vim-code-dark'

if g:os == "Linux"
    Plug 'lilydjwg/fcitx.vim'
endif

if index(g:bundle_group, 'basic') >= 0
    Plug 'mhinz/vim-signify'

    if has("win32")
        Plug 'Yggdroot/LeaderF', { 'do': './install.bat' }
    else
        Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    endif

    let g:Lf_UseCache = 0
    let g:Lf_ShowDevIcons = 0
    let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
    let g:Lf_RgConfig = [
        \ "--max-columns=150",
        \ "--glob=!git/*",
    \ ]

    " vim-indent-guides
    Plug 'nathanaelkane/vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 2
    let g:indentLine_color_gui = '#A4E57E'
endif

" ariline
if index(g:bundle_group, 'airline') >= 0
    Plug 'vim-airline/vim-airline'
    let g:airline_enable_syntastic = 0
    let g:airline#extensions#tabline#enabled = 1
    set noshowmode
endif

" programming
if index(g:bundle_group, 'programming') >= 0
    Plug 'dense-analysis/ale'
    let g:ale_linters = {'python': ['flake8']}
    let g:ale_python_flake8_options = '--ignore=E501'
    let g:ale_fixers = {'python': ['autopep8']}
    let g:ale_echo_msg_format = '%s [%code%]'

    Plug 'scrooloose/nerdcommenter'
    Plug 'vim-scripts/a.vim'

    " vim-header
    Plug 'lchannng/vim-header'
    let g:header_field_author = 'lchannng'
    let g:header_field_author_email = 'l.channng@gmail.com'
    let g:header_field_filename_path = 0
    let g:header_field_modified_timestamp = 0
    let g:header_field_modified_by = 0
    let g:header_field_timestamp_format = '%Y/%m/%d %H:%M:%S'

    " pep8
    Plug 'tell-k/vim-autopep8', { 'for' : 'python' }
    autocmd FileType python noremap <buffer> <F11> :call Autopep8()<CR>
endif

" tags
if index(g:bundle_group, 'tags') >= 0
    " vim-gutentags
    Plug 'ludovicchabant/vim-gutentags'

    " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'

    " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let s:vim_tags = expand('~/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags

    " 配置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 检测 ~/.cache/tags 不存在就新建
    if !isdirectory(s:vim_tags)
       silent! call mkdir(s:vim_tags, 'p')
    endif
endif

" autocomplete
if index(g:bundle_group, 'neocomplete') >= 0
    " snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-l>"
    let g:UltiSnipsJumpBackwardTrigger="<c-h>"

    Plug 'Shougo/neocomplete.vim'

    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=python3complete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

if index(g:bundle_group, 'coc.nvim') >= 0
    " Use release branch (Recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " coc explorer
    nmap <F4> :CocCommand explorer<CR>

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
endif

call plug#end()            " required
" filetype plugin indent on    " required
