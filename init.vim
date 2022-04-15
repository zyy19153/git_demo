""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  PlugList                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('D:\developer_tools\Neovim\share\nvim\plugged') 
"状态栏的例子
Plug 'morhetz/gruvbox'
" Plug 'iCyMind/NeoSolarized'
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
Plug 'vim-scripts/argtextobj.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "极限搜索文件
Plug 'junegunn/fzf.vim'
"Plug 'windwp/nvim-autopairs'
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              plugin settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 主题设置
" Plug 'iCyMind/NeoSolarized'
set termguicolors
" colorscheme NeoSolarized
" Plug 'morhetz/gruvbox'
colorscheme gruvbox

" 彩虹括号
" Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" 缩进指示线颜色
" Plug 'Yggdroot/indentLine'
let g:indentLine_color_term = 238

" 状态栏增强
" Plug 'vim-airline/vim-airline'
" 打开后可以美化显示窗口 tab 和 buffer，比 NeoVim 自带好看
let g:airline#extensions#tabline#enabled = 1
" tabline 中 buffer 显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1


if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'


"关于状态栏的小配置
"Powerline setting
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"let g:airline_theme='molokai'  " murmur配色不错



" 树形文件浏览
" Plug 'preservim/nerdtree'
" 设定 NERDTree 视窗大小
let g:NERDTreeWinSize = 25
" 过滤所有指定的文件不显示
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '\.vscode', '__pycache__']
" 打开或关闭 nerdtree
" 当 NERDTree 为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"打开vim时如果没有文件自动打开NERDTree
autocmd vimenter * if !argc()|NERDTree|endif
" 正常下 Nerdtree 是不会自动刷新的，按 r 刷新



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               common setting                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"ideavim related
" 设置leader键
let mapleader=' '
set clipboard=unnamed
noremap H ^
noremap L $
noremap q b
noremap b q
"inoremap jj <Esc>
inoremap ` <Esc>

nnoremap <S-Enter> o<Esc>
noremap Y y$
noremap ; :


set mouse=nv " 可视模式


" 基本配置
set nocompatible "关闭与vi的兼容模式
set encoding=utf-8  "通用的 utf8 编码，避免乱码
set fenc=utf-8      "编码
set mouse=a        "支持使用鼠标
" 缩进
set tabstop=4    " Tab = 4 空格
set shiftwidth=4 " 这三个要一起设置，设置完后就表示“tab=4空格”
set expandtab   " Tab 键在不同的编辑器缩进不一致，自动将 Tab 转为空格
" 外观
set cursorline  " 光标所在的当前行高亮

set number  "显示绝对行号
set rnu  "显示相对行号
set nowrap    "不自动折行
set showmatch   " 光标遇到圆括号、方括号、大括号时，自动高亮对应的另一半
set cc=80 "标尺线
set scrolloff=5        "垂直滚动时，光标距离顶部/底部的行数
" 搜索
set hlsearch        " 搜索时，高亮显示匹配结果
set foldmethod=indent  " 代码折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码

set guifont=DejaVu\ Sans\ Mono:h20   " 设置字体和字体大小


" 快捷键
nnoremap <Leader>f :FZF 
nnoremap <Leader>n :NERDTree 


"fzf related
" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
" 打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  " 设置浮动窗口打开的位置，大小等。
  " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  " 设置浮动窗口高亮
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction



