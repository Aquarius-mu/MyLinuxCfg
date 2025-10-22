" 禁用系统 vimrc
set nocp          " 禁用兼容模式（避免加载系统配置）
set nocompatible  " 同上（Vim 默认行为）
filetype off 
"let skip_defaults_vim = 1  " 跳过 /usr/share/vim/vimrc
" 强制每次打开后，就是上次记录的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'IammyselfYBX/vim-rainbow'
Plugin 'bfrg/vim-cpp-modern'
"Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'majutsushi/tagbar'
Plugin 'easymotion/vim-easymotion'
Plugin 'Yggdroot/LeaderF'
Plugin 'scrooloose/nerdcommenter'  " \cs 和 \ci快速注释
" 以下范例用来支持不同格式的插件安装
" 请将安装插件的命令放在vundle#begin和vundle#end之间
" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall       - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate 可能需要修改installer.vim中git拉取方式
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!`
call vundle#end() " 必须
filetype plugin indent on

" 语法高亮
syntax on
" 设置行号
set number
" 取消行号
:map! <C-n> <ESC>:set nonumber<CR>

"——————————————————————————————————————————————————插件管理begin——————————————————————————————————————————————————
" sw键H和CPP切换  需要插件vim-fswitch
nnoremap sw :FSHere<CR>  

" 彩虹括号
let g:rainbow_active = 1
let g:rainbow_guifgs = ['RoyalBlue3', 'cornsilk2', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['blue', 'lightgreen', 'lightyellow', 'red', 'magenta']

" cpp
let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_type_name_highlight = 1

" tagbar
let g:tagbar_autofocus = 1
nmap <F9> :TagbarToggle<CR>

" leaf <C-O>跳回 <C-I>跳回的跳回
let g:Lf_Ctags = 'ctags'
let g:Lf_ShortcutF = '<C-P>'
noremap <leader>f :LeaderfSelf<cr>
noremap <leader>fm :LeaderfMru<cr>
noremap <leader>ff :LeaderfFunction<cr>
noremap <leader>fg :LeaderfTag<cr>
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
"noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
"noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
"——————————————————————————————————————————————————插件管理end——————————————————————————————————————————————————

" auto file type
set cscopetag

" 缩进设置
set tabstop=4
set backspace=indent,eol,start
set smartindent
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent

" 显示括号匹配
set showmatch
" 括号匹配时间为1
set matchtime=1

" ctrl + \ 推出文件  
:map! <C-\> <ESC>:q<CR>  

" svn blame插件 v选中后按bm输出blame结果 非常好用
vmap bl :<C-U>!svn blame <C-R>=expand("%p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p<CR>

" 设置高亮搜索  
set hlsearch  
" 在搜索时，输入的词句逐字符高亮  
set incsearch  

" smart search case sensitivevim  
set ignorecase smartcase  

" 设置编码自动识别，中文引导显示  
set fileencodings=zh_CN.GB2312

" 设置C/C++代码缩进风格,几乎完美
set cinoptions=g0,i0,5s,+0,:0,10,5s,(0,t0,N-s

" 输入C/C++代码时自动缩进
set cindent

" 使用ctags跳转到定义
set tags=./tags,tags,$HOME

" 文件头注释模板（F10触发）
map <F10> :call TitleDet()<cr>'s
function AddTitle()
    call append(00,"//")
    call append(01,"// 功能: ")
    call append(02,"//")
    call append(03,"// 作者: sunjiadong")
    call append(04,"//")
    call append(05,"// 修订: ")
    call append(06,"// - [".strftime("%Y-%m-%d")."] 增加XXX功能 (by Aquaruis)")
    call append(07,"//")
    echohl warningMsg | echo "Successful!" | echohl None
endfunction

" 更新文件头
function UpdateTitle(line)
    normal m'
    call append(a:line,"// - [".strftime("%Y-%m-%d").") 本次做了XXX修改 (by Aquaruis)")
    normal ''
    echohl warningMsg | echo "Successful in updating the copy right." | echohl None
endfunction

" 添加或更新文件头
function TitleDet()
    let n=100
    while n > 1
        let line = getline(n)
        if line =~ '^\/\/\s\s\s\s-'
            call UpdateTitle(n)
            return
        endif
        let n = n - 1
    endwhile
    call AddTitle()
endfunction
