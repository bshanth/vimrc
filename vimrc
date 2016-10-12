"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
"
filetype plugin on
set nocompatible
set history=700
set rnu
set nu
set cscopequickfix=s-,c-,d-,i-,t-,e-
set tags=tags 
set expandtab
set cindent
set cinoptions=g0,:0,l1,(0,t0
set cmdwinheight=1
set viminfo^=!
set textwidth=78
set notimeout
set nottimeout
set diffopt+=iwhite
set t_Co=256
set pastetoggle=<F1>
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
let @q='d2wywiprintf .q<80>kbpli.; .5x<80>kbbi0x<80>kblllli, <80>kb$bx0j'
"set rtp+=/home/ebapras/env/bin/powerline/powerline/bindings/vim

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

fun! Scolor()
    let g:colo=1
    while g:colo < 255
        let synname=synIDattr(synID(line("."), col("."), 0), "name")
        exe "hi ".synname." ctermfg=".g:colo
        let inp = input("")
        echo g:colo
        exe "redraw"
        if (inp == 'e')
            echo "hi ".synname." ctermfg=".g:colo
            return
            elseif (inp  == 'j')
            let g:colo = g:colo + 1
            elseif (inp == 'k') 
            if (g:colo > 1)
                let g:colo = g:colo - 1
            endif
            else
            let g:colo = g:colo + 1
        endif
    endwhile
endfun

"encoding
"
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

nmap gC :'a,. s/^/ */:. s/\(.*\)/\1^V^V **************\//:'a s/\(.*\)/\/**************^V^V\1/
vmap gC :'a,. s/^/ */:. s/\(.*\)/\1^V^V **************\//:'a s/\(.*\)/\/**************^V^V\1/

vmap <script> <silent> 5 %

vmap <script> <silent> ca :w! ~/.vim/.vimbuffer<CR>
nmap <script> <silent> cb :r  ~/.vim/.vimbuffer<CR>

map <F3> : call CompileGcc()<CR>

func! CompileGcc()
  exec "w"
  exec "!gcc % -o %<"
endfunc

map <F4> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  exec "!gcc % -o %<"
  exec "! ./%<"
endfunc

syntax enable

au FileType * call Cabrs()
au FileType *.txt call Syntax() 

fun! Syntax()
    syntax off
endfun

fun! Map(arg) 
    return (col('.') == 1 || getline('.')[col('.')-2] =~ '\S' ? ' ' : ''). a:arg. ' ' 
endfun

fun! Imove() 
    if (stridx(getline('.'), "for") > 0)
        normal /;<CR>
    endif
endfun

cnoremap ,, ,
cnoremap ,5 5
cnoremap ,3 #
cnoremap ,i !
cnoremap ,; :
cnoremap ,r "
cnoremap ,e -
cnoremap - _
cnoremap ,a @
cnoremap ,w <s-left>\<<s-right>\><CR>
cnoremap .. .*

" temp abbrs
fun! Cabrs()
    iab com /*<CR><CR>/<Up>

    inoremap .. <ESC>/[;()*&^%$#}{@!~]/e<CR><Right><Insert>

    "inoremap .. <End><Insert>;<ESC>o
    inoremap [ {<CR>}<ESC>ko
    inoremap ] }
    inoremap { [
    inoremap } ]
    inoremap .a &
    inoremap .b ()<ESC>i
    inoremap .x {}<ESC>i
    inoremap .c )
    inoremap .d .
    inoremap .e \|
    inoremap ,w <ESC>daw<Insert>
    inoremap ; <End><Insert>;<ESC>
    inoremap  <expr> .g Map('>')
    inoremap  .fg <Space>>=<Space>
    inoremap  .fl <Space><=<Space>
    inoremap .h #
    inoremap .i !
    inoremap <expr> .k Imove()
    inoremap .l <Space><<Space>
    inoremap .m --
    inoremap .o (
    inoremap .p ++
    inoremap .q ""<left>
    inoremap .r <Space>\|\| 
    inoremap .s *
    inoremap .n <Space>&&<Space>
    inoremap .t  <End><Insert><Space>{<CR>}<ESC><Up>o
    inoremap .u <Space>-<space>
    inoremap .v <Space>+ 
    "inoremap .v <ESC>lbe<Insert> \+ 
    inoremap .y []<ESC>i
    inoremap  .z <Esc>gUawea
    inoremap - _
    inoremap .4 $
    inoremap .5 %
    inoremap .; :
    "inoremap  ; ;<ESC>o
    inoremap .= <Space>==<Space>
    inoremap  = <Space>=<Space>
    inoremap ,b  <C-P>
    inoremap ,d ->
    inoremap ,e <Space>!=<Space>
    inoremap ,f  <C-N>
    inoremap ,g <><ESC>i
    inoremap ,n \n
    inoremap ,i if ()<ESC>i
    inoremap ,r for (;;)<Left><Left><Left>
    inoremap ,o {
    inoremap ,c }
    inoremap ,m -1
    inoremap ,v <Space>+=<Space>
    inoremap ,u <Space>-=<Space>
    inoremap ,s <C-O>:call Talign()<CR>
endfun

fun! Talign()
    set ve=all
    normal \<up>\<c-right>\<down> 
    set ve= 
endfun

fun! Disable_Cabrs()
    iabc
    imapc
    inoremap <BS> <ESC>
endfun

let g:netrw_browse_split=4
let g:netrw_winsize=30
let generate_tags=1
let g:ctags_statusline=1
let generate_tags=1	" To start automatically when a supported
let g:ctags_title=1
let LID_File='/project/swbuild14/ebapras/sfi.xref/pkt/sw/ID'

hi MatchParen  none
hi MatchParen  ctermfg=red ctermbg=239
hi Macro ctermfg=red
hi Special ctermfg=red
hi Pmenu ctermbg=0 ctermfg=red

hi TabLineFill  term=standout cterm=bold ctermfg=grey
hi TabLineSel term=standout cterm=bold ctermfg=grey
hi TabLine term=standout cterm=bold ctermfg=lightgrey ctermbg=0

" ----------------colorscheme begins -------------------

hi Normal ctermfg=246
" highlight groups
highlight cGNUStorageClass ctermbg=none ctermfg=green
hi Cursor	guibg=khaki guifg=slategrey
hi VertSplit	guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded	guibg=grey30 guifg=gold
hi FoldColumn	guibg=grey30 guifg=tan
hi IncSearch	guifg=slategrey guibg=khaki
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue guibg=grey30
hi Question	guifg=springgreen
hi Search	guibg=peru guifg=wheat
hi SpecialKey	guifg=yellowgreen
hi Title	guifg=indianred
"hi VisualNOS
hi WarningMsg	guifg=salmon
" syntax highlighting groups
hi Constant	guifg=#87af5f
hi Identifier	guifg=palegreen
hi PreProc	guifg=indianred
hi Type		guifg=darkkhaki
hi Special	guifg=navajowhite
"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		guifg=orangered guibg=yellow2

hi SignColumn ctermbg=none ctermfg=2
" color terminal definitions
hi cEllipsesError ctermfg=darkgreen ctermbg=none
hi cCommentError ctermbg=none
hi cCommentError ctermfg=101  guifg=#afafaf 
hi SpecialKey    ctermfg=darkgreen
hi NonText       cterm=bold ctermfg=darkblue
hi Directory     ctermfg=darkcyan
hi ErrorMsg      cterm=bold ctermfg=7 ctermbg=1
hi IncSearch     ctermfg=244
hi Search        cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg       ctermfg=darkgreen
hi ModeMsg       cterm=NONE ctermfg=brown
hi LineNr        ctermfg=239
hi Question      ctermfg=green
highlight        StatusLine none
highlight        StatusLine ctermbg=244 ctermfg=0
hi StatusLineNC  cterm=reverse
hi VertSplit     cterm=reverse
hi Title         ctermfg=5
hi VisualNOS     cterm=bold,underline
hi WarningMsg    ctermfg=1
hi WildMenu      ctermfg=0 ctermbg=3
hi Folded        ctermfg=darkgrey ctermbg=NONE
hi FoldColumn    ctermfg=darkgrey ctermbg=NONE
hi Operator      none
hi Operator      ctermfg=204
hi Keyword       none
hi Keyword       ctermfg=154
hi Statement     none
hi Statement     ctermfg=108
hi String        none
hi String        ctermfg=136
hi cScanFormat   none
hi cScanFormat   ctermfg=142
hi cEscapeChar   none
hi cEscapeChar   ctermfg=212
hi DiffAdd       none
"hi DiffAdd       ctermbg=238 ctermfg=70
hi DiffAdd       ctermbg=22
hi DiffChange    none
hi DiffChange    ctermbg=60
hi DiffDelete    none
hi DiffDelete    ctermbg=131
hi DiffText      none
hi DiffText      ctermbg=96
hi Visual        none
hi Visual        ctermbg=23 
hi Comment       ctermfg=101  guifg=#afafaf 
hi Function      ctermfg=31 guifg=#af8787
hi Constant      ctermfg=brown
hi Special       ctermfg=5
hi Identifier    ctermfg=6
hi PreProc       none
hi PreProc       ctermfg=204
hi Type          ctermfg=2
hi Underlined    cterm=underline ctermfg=5
hi Ignore        cterm=bold ctermfg=7
hi Ignore        ctermfg=darkgrey
hi Error         cterm=bold ctermfg=7 ctermbg=1
" ----------------colorscheme ends -------------------
set showtabline=2
set tabline=""
set title


" When vimrc is edited, reload it
au! bufwritepost vimrc source ~/.vim_runtime/vimrc



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
"set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set ignorecase "Ignore case when searching
set smartcase

set incsearch "Make search act like search in modern browsers
set nohlsearch
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

"set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

"if has("cscope")
"    set cscopetag
"
"    set csto=0
"
"    if filereadable("cscope.out")
"        "cs add cscope.out  
"    elseif $CSCOPE_DB != ""
"        "cs add $CSCOPE_DB
"    endif
"
"    " show msg when any other cscope db added
"    set cscopeverbose  
"
"    nmap <script>  gs :call ChangeNP(1) <bar> cs find s <C-R>=expand("<cword>")<CR><CR> 
"    nmap <script> \jg :call ChangeNP(1) <bar> cs find g <C-R>=expand("<cword>")<CR><CR>	
"    nmap <script>  gc :call ChangeNP(1) <bar> cs find c <C-R>=expand("<cword>")<CR><CR>	
    "    nmap <script>  gt :call ChangeNP(1) <bar> cs find t <C-R>=expand("<cword>")<CR><CR>	
    "    nmap <script> \je :call ChangeNP(1) <bar> cs find e <C-R>=expand("<cword>")<CR><CR>	
    "    nmap <script> \jf :call ChangeNP(1) <bar> cs find f <C-R>=expand("<cfile>")<CR><CR>	
    "    nmap <script> \ji :call ChangeNP(1) <bar> cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "    nmap <script> \jd :call ChangeNP(1) <bar> cs find d <C-R>=expand("<cword>")<CR><CR>	
    "    nmap <script> <C-n> :cnext<CR>
    "    nmap <script> <C-p> :cprev<CR>
    "
    "endif

    nmap <script> <insert> <S-insert>

    let g:gtagsxrefpath = 0

    fun! GtagsCdXref()
        if (g:gtagsxrefpath == 0)
            let g:gtagsxrefpath = 1
            exe "cd /project/swbuild14/ebapras/sfi.xref/pkt/sw"
        else
            let g:gtagsxrefpath = 0
            exe "cd -"
        endif
    endfun

    fun! GtagsFile()
        let l:file = input("file: ")

        if (l:file != ' ')
            exe ":Gtags -P" . l:file
        endif
    endfun

    fun! GtagsExtraFile()
        exe "cd /project/swbuild14/ebapras/sfi.xref/pkt/sw"
        call GtagsFile()
    endfun

    " gnu global definitions
    if has("cscope")
        set cscopetag

        set csto=0

        nmap <script>  gh :Gtags 
        "nmap <script>  gc :call CvsListCheckouts() <CR>
        nmap <script> <silent>  gc :call GtagsCdXref() <CR>
        nmap <script>  =  :silent! Gtags <C-R>=expand("<cword>") <CR><CR> z<CR>
        nmap <script>  gr :call ChangeNP(1) <bar> Gtags -r <C-R>=expand("<cword>")<CR><CR> 
        nmap <script>  gs :call ChangeNP(1) <bar> Gtags -s <C-R>=expand("<cword>")<CR><CR> 
        nmap <script>  gg :call ChangeNP(1) <bar> Gtags -g <CR>	
        nmap <script>  gi :call ChangeNP(1) <bar> Gtags -gi <CR>	
        nmap <script>  ge :call ChangeNP(1) <bar> Gtags -ge <CR>	
        nmap <script>  gh :call ChangeNP(1) <bar> Gtags -ge <C-R>=expand("<cword>")<CR><CR>	
        nmap <script>  f  :call ChangeNP(1) <bar> call GtagsFile() <CR> 
        nmap <script>  F  :call ChangeNP(1) <bar> call GtagsExtraFile() <CR> 

        nmap <script> <C-n> :cnext<CR>
        nmap <script> <C-p> :cprev<CR>
endif
        nmap <script>  g1 1G
        nmap <script>  g4 $
        nmap <script>  gl bG
        nmap <script>  g4 d$
        nmap <script>  ga ?{<CR>v%<CR>
        vmap <script>   a %<ESC>?{<CR>v%<CR>

augroup vimrc_autocmds
  autocmd BufEnter *.[ch] highlight OverLength ctermbg=238 guibg=#592929
  autocmd BufEnter *.[ch] match OverLength /\%80v.*/
augroup END

"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif

" cvsdiff mapping 
nmap gy :call VcsDiff() <CR> wh

fun! VcsDiff()
    if (mapcheck("[") != "")
        exe ":unmap <script> ["
    endif

    if (mapcheck("]") != "")
        exe ":unmap <script> ]"
    endif

    exe "silent! VCSVimDiff"
endfun

" all my crazy mappings
vmap <script> ; :
nmap <script> ; :
nmap <script> <silent>gm :set makeprg=gcc\ %<CR>
nmap <script> <silent> wi :hide <CR>
nmap <script> <silent> wd :unhide <CR>

nmap <script> v V
nmap <script> V v
"nmap <script> <Space> /[a-z\|_\|0-9]\+(.\+[^\r\n]\+);\C<CR>


map gx :e <C-R>=expand("%:p:h") . "/" <CR>
nmap <script> <silent> 0 :call Zero() <CR>
fun! Zero()
     normal ^
endfun

nmap <script> <silent> 8 <C-u>
nmap <script> <silent> 9 <C-d>
"nmap <script> <silent> 2 @:
"nmap <silent> <script> 7 :call Gb() <CR>

"nmap <silent> <script> ] /{<CR>
"nmap <silent> <script> [ ?{<CR>

"nmap <silent> <script> ] :call JumpCblock(1) <CR>
"nmap <silent> <script> [ :call JumpCblock(0) <CR>

fun! JumpCblock(forward)
    if a:forward
        execute "normal /{"
        if (winline() > winheight(winnr())/2)
            execute "normal z."
        endif
    else
        execute "normal ?{"
        if (winline() < winheight(winnr())/2)
            execute "normal z."
        endif
    endif
endfun

let g:nummapped = 1

nmap <script> <silent> gt :call NumTogglemap() <CR>

fun! NumTogglemap()
    if (g:nummapped == 1)
        unmap <silent> <script> [
        unmap <silent> <script> ]
        unmap <silent> <script> t
        unmap <silent> <script> p
        let g:nummapped = 0
        call Disable_Cabrs()
    else
        nmap <script> <silent> 0 :call Zero() <CR>
        nmap <script> <silent> 8 <C-u>
        nmap <script> <silent> 9 <C-d>
"        nmap <silent> <script> 7 :call Gb() <CR>
        "nmap <silent> <script> ] L
        "nmap <silent> <script> [ H
        "nmap <silent> <script> t M
        "nmap <silent> <script> ] JumpCblock(1)
        "nmap <silent> <script> [ JumpCblock(0)
        "nmap <script> <silent> t :Vexplore <CR>
        inoremap <Tab> <C-R>=CleverTab()<CR>
        nmap <script> p :call Qfprev() <CR>
        let g:nummapped = 1
        call Cabrs()
    endif
endfun

imap <tab> <C-p>
"nmap <script> <silent>  g_

let g:bs = 1
nmap <script> <silent>  :call Bspace() <CR>
vmap <script> <silent>  :call Bspace() <CR>

fun! Bspace()
    if (g:bs)
        normal! g_
       "let g:bs = 0
    else
        normal! ^
        let g:bs = 1
    endif
endfun

nmap <script> , <C-o> 
nmap <script> . <C-i> 
"nmap <script> <silent> - ?^{<CR>

fun! CvsListCheckouts()
    let tlist = system("~/cf")
    let list = eval(tlist)
    call setqflist(list, 'r')
    exe ":cc 1"
    call ChangeNP(1)
    
endfun

function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
    else
    return "\<C-P>"
    endif
endfunction

inoremap <BS> <ESC>
noremap <space> *

inoremap <Tab> <C-R>=CleverTab()<CR>

nmap <script> <silent> w <C-w>
nmap <script> <silent> a A
nmap <script> <silent> s :Gtags <CR>

"nmap <script> <silent> gj :silent! call Gj() <CR>

"nmap <silent> <script> ] :call Gj()<CR>/<C-R>/<CR>
"nmap <silent> <script> [ :call Gk()<CR>?<C-R>?<CR>
"nmap <silent> <script> t M
"nmap <silent> <script> ] L
"nmap <silent> <script> [ H

nnoremap gj :call Gj()<CR>/<C-R>/<CR>

let g:hl = 0

fun! Gj()
    call ChangeNP(0)

    if @/ =~ expand('<cword>')
        if g:hl
            let g:hl = 0
            set nohlsearch
        else 
            let g:hl = 1
            set hlsearch
        endif
    endif

    let @/ = expand('<cword>')
    silent normal! N
endfun 

"noremap <script> <silent> gk :silent! call Gk() <CR>
nnoremap gk :call Gk()<CR>?<C-R>?<CR>
fun! Gk()
    call ChangeNP(0)

    if @/ =~ expand('<cword>')
        if g:hl
            let g:hl = 0
            set nohlsearch
        else 
            let g:hl = 1
            set hlsearch
        endif
    endif

    let @/ = expand('<cword>')
    silent normal! ?
    silent normal! N
endfun

if &term =~ "xterm"
let &t_SI = "\<Esc>]12;purple\x7"
let &t_EI = "\<Esc>]12;blue\x7"
endif

nmap <script> <silent>  ma :silent! call Mark('A') <CR>
nmap <script> <silent>  mb :silent! call Mark('B') <CR>
nmap <script> <silent>  mc :silent! call Mark('C') <CR>
nmap <script> <silent>  md :silent! call Mark('D') <CR>
nmap <script> <silent>  me :silent! call Mark('E') <CR>
nmap <script> <silent>  mf :silent! call Mark('F') <CR>
nmap <script> <silent>  mg :silent! call Mark('G') <CR>
nmap <script> <silent>  mh :silent! call Mark('H') <CR>
nmap <script> <silent>  mi :silent! call Mark('I') <CR>
nmap <script> <silent>  mj :silent! call Mark('J') <CR>
nmap <script> <silent>  mk :silent! call Mark('K') <CR>
nmap <script> <silent>  ml :silent! call Mark('L') <CR>
nmap <script> <silent>  mm :silent! call Mark('M') <CR>
nmap <script> <silent>  mn :silent! call Mark('N') <CR>
nmap <script> <silent>  mo :silent! call Mark('O') <CR>
nmap <script> <silent>  mp :silent! call Mark('P') <CR>
nmap <script> <silent>  mq :silent! call Mark('Q') <CR>
nmap <script> <silent>  mr :silent! call Mark('R') <CR>
nmap <script> <silent>  ms :silent! call Mark('S') <CR>
nmap <script> <silent>  mt :silent! call Mark('T') <CR>
nmap <script> <silent>  mu :silent! call Mark('U') <CR>
nmap <script> <silent>  mv :silent! call Mark('V') <CR>
nmap <script> <silent>  mw :silent! call Mark('W') <CR>
nmap <script> <silent>  mx :silent! call Mark('X') <CR>
nmap <script> <silent>  my :silent! call Mark('Y') <CR>
nmap <script> <silent>  mz :silent! call Mark('Z') <CR>

" Marks start
nmap <script> <silent> ' :call Showmarks() <CR>

au VimLeavePre * let g:MARKLISTSTR = string(g:MARKLIST)
au VimEnter *
        \ if exists('MARKLISTSTR')
        \ | let g:MARKLIST = eval(MARKLISTSTR)

let g:MARKLIST=[]

fun! Mark(index)
    if (&filetype == 'c' || &filetype == 'h')
        let wi = 0
        while wi < len(g:MARKLIST)
            let item = g:MARKLIST[wi]
            if (item[0] == a:index)
                let item[1] = GetTagName(line('.'))
                let item[2] = line(".")
                let item[3] = bufname("%")
                exe ":mark " . a:index
                return 
            endif
            let wi = wi + 1
        endwhile
            call add(g:MARKLIST, [a:index, GetTagName(line('.')), line("."), bufname("%")])
            exe ":mark " . a:index
    else
            exe ":mark " . a:index
    endif
endfun

fun! Showmarks()
    rightbelow new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    setlocal nowrap
    setlocal nonu
    for m in g:MARKLIST
        let s:txt = printf("%s %-35s %-4d %-50s", m[0], m[1]. "()", m[2], m[3])
        put =s:txt
    endfor
    exe ":redraw"
    let s:char = nr2char(getchar())
    setlocal nomodifiable
    exe ":close"
    if (s:char < 'a' || s:char > 'z')
        return
    endif
    exe ":silent! '".toupper(s:char)
endfun

" Marks end

"nmap <script> <silent> t :Vexplore <CR>
nmap <script> <silent> t H

"nmap <script> <silent> co :call Copen() <CR>
fun! Copen()
    if (mapcheck("<CR>") != "")
        exe ":unmap <script> <CR>"
    endif
    exe ":copen"
endfun

"nmap <script> <silent> cr :crewind <CR>
"nmap <script> <silent> cc :call Cclose() <CR>

fun! Cclose()
    exe ":nmap <script> <silent> <CR> :call Enter() <CR>"
    exe ":cclose"
endfun

nmap <script> <silent> co :call Lopen() <CR>
fun! Lopen()
    if (mapcheck("<CR>") != "")
        exe ":unmap <script> <CR>"
    endif
    "exe ":lopen"
    exe ":copen"
endfun

nmap <script> <silent> cr :lrewind <CR>
nmap <script> <silent> cc :call Lclose() <CR>

fun! Lclose()
    exe ":nmap <script> <silent> <CR> :call Enter() <CR>"
    "exe ":lclose"
    exe ":cclose"
endfun


nmap <script> <silent> <CR> :call Enter() <CR> 
vmap <script> <silent> <CR> :call Enter() <CR> 

fun! Enter()
    silent normal! 5
endfun


"nmap <script> =  :Tags <C-R>=expand("<cword>")<CR> <CR>

"command! -nargs=1 Tags call Tags(<f-args>)

" to create tmp file.
nmap <script> <silent> gb :Mktmpdir <CR>
command! Mktmpdir call mkdir(fnamemodify(tempname(),":p:h"), "", 0700)

fun! Tags(tag)
    if (strpart(a:tag, strlen(a:tag)-3, 2) == "_t")
        let newtag = "_".a:tag
        echo a:tag
        echo taglist(a:tag)
        return
        if !empty(get(taglist(newtag),0))
        echo "one"
        return
            exe ":tag " . newtag 
        else
        echo "two"
        return
            exe ":tag " . a:tag 
        endif
    else
        exe ":silent! tag " . a:tag 
    endif
endfun

noremap <script> <silent> - :call Jump(getline(".")[col(".")-1], getline(".")) <CR>
vmap    <script> <silent> - :call Jump(getline(".")[col(".")-1], getline(".")) <CR>
command! -nargs=+ Jump call Jump(<f-args>)

fun! Jump(cword, line)
let Jflag=0

let Jumpx =  taglist(GetTagName(line('.')))
if !empty(Jumpx) 
let y = get(Jumpx, 0)
let Jflag=1
endif

if (a:cword == "}")
    silent normal! %
    if (a:line == "}")
        silent execute "normal! z\<CR>"
        exe ":silent! ?("
        silent execute "normal! k"
        exe ":silent! /{"
    endif
elseif (a:cword == "{" || a:cword == "(" || a:cword == ")" || a:cword == "[" || a:cword == "]")
    silent normal! %
elseif (Jflag == 1) 
    if (y.kind == "s" || y.kind == "t")
        exe ":silent! ?{"
        silent execute "normal! z\<CR>"
        silent execute "normal! k"
        exe ":silent! /{"
    else
        exe ":silent! ?^{"
        silent execute "normal! z\<CR>"
        exe ":silent! ?("
        silent execute "normal! k"
        exe ":silent! /{"
    endif
else
    exe ":silent! ?^{"
    silent execute "normal! z\<CR>"
    exe ":silent! ?("
    silent execute "normal! k"
    exe ":silent! /{"
endif
endfun

let g:qfnextflag=0

nmap <script> <silent> gn :call ChangeNP(2)<CR>
command! -nargs=1 ChangeNP call ChangeNP(<f-args>)

fun! ChangeNP(mode)

    if (a:mode != 2)
        let g:qfnextflag = a:mode
    else
        let g:qfnextflag = (g:qfnextflag + 1)%2
    endif

    if (g:qfnextflag == 1)
        highlight StatusLine none
        highlight StatusLine ctermbg=23 ctermfg=black
    else
        highlight StatusLine none
        highlight StatusLine ctermbg=243 ctermfg=black
    endif
endfun

nmap <script> n :call Qfnext() <CR>

fun! Qfnext()
    if (&diff)
        exe "normal ]c" 
    else
        if (g:qfnextflag == 2)
            call ChangeListScanNext()
        elseif (g:qfnextflag == 1)
            if (empty(getqflist()))
                exe "unmap <silent> n"
                exe "silent! normal n"
                exe "nmap <script> n :call Qfnext() <CR>"
            else
                "exe ":silent! lnext"
                exe ":silent! cnext"
                let tmp = g:loclist[g:loclistscntr][2]
                let tmp = tmp + 1

                if (tmp <= len(g:loclist[g:loclistscntr][1]))
                    let g:loclist[g:loclistscntr][2] = tmp
                endif
            endif
        else
            exe "unmap <silent> n"
            exe "normal n"
            exe "nmap <script> n :call Qfnext() <CR>"
        endif
    endif
endfun

nmap <script> gp :call Gp() <CR>

let g:gp = 0

fun! Gp()
    if (g:gp == 0)
        exe "unmap <silent> p"
        let g:gp = 1
    else
        nmap <script> p :call Qfprev() <CR>
        let g:gp = 0
    endif
endfun

nmap <script> p :call Qfprev() <CR>

fun! Qfprev()
    if (&diff)
        exe "normal [c" 
    else
        if (g:qfnextflag == 2)
            call ChangeListScanPrev()
        elseif (g:qfnextflag == 1)
            "if (empty(getloclist(g:loclistscntr)))
            if (empty(getqflist()))
                exe "unmap <silent> p"
                execute "silent! normal p"
                nmap <script> p :call Qfprev() <CR>
            else
                "exe ":silent! lprev"
                exe ":silent! cprev"
                
                let tmp = g:loclist[g:loclistscntr][2]
                let tmp = tmp - 1

                if (tmp > 0)
                    let g:loclist[g:loclistscntr][2] = tmp
                endif

            endif
        else
            exe "unmap <silent> p"
            execute "silent! normal p"
            nmap <script> p :call Qfprev() <CR>
        endif
    endif
endfun

let g:loclistscntr = 0

nmap <script> <silent> <tab> :call SetQfList() <CR>

fun! SetQfList()
    rightbelow new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    setlocal nowrap
    setlocal nonu

    let alpha="abcdefghijklmnopqrstvwxyz"
    let ntoalplha = {'a':0, 'b':1, 'c':2, 'd':3, 'e':4, 'f':5, 'g':6, 'h':7, 'i':8, 'j':9}

    let i = 0
    let chr = "a"
    let cnt = len(g:loclist)

    while (i < cnt)
        if (type(g:loclist[i]) != 0)
            let s:txt = printf("%s %-35s ", alpha[i], strpart(g:loclist[i][0], stridx(g:loclist[i][0],"'")))
            put =s:txt
        endif 
        let i = i + 1
        let chr = chr + 1

        if (chr == "z")
            return 
        endif
    endwhile

    setlocal nomodifiable
    exe ":redraw"
    let s:char = nr2char(getchar())
    exe ":close"

    if (s:char < 'a' || s:char > 'z')
        return
    endif

    let sel = ntoalplha[s:char]

    if (g:loclistscntr == sel)
        return
    else
        let g:loclistscntr = sel
    endif

    call setqflist(g:loclist[sel][1])

    " goto the position in the qflist where we left-off before switching to the new list
    if (g:loclist[g:loclistscntr][2] > 1)
        let tmpcmd = ":silent! "
        let tmpcmd = tmpcmd.g:loclist[g:loclistscntr][2]
        let tmpcmd = tmpcmd."cnext"
        exe tmpcmd
    else
        exe "crewind"
    endif

endfun

nmap <script> <silent> gq :call ShowQfListVars() <CR>
fun! ShowQfListVars()
    echo "g:loclistscntr = ".g:loclistscntr
    echo "g:loclistrcntr = ".g:loclistrcntr
    echo "g:maxqflists   = ".g:maxqflists
    echo "g:maxqfreached = ".g:maxqfreached
endfun

let g:s = 0

fun! Sum(num)
    let g:s=g:s+a:num
    return a:num
endfun


command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

fun! s:RunShellCommand(cmdline)
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    setlocal nowrap
    call setline(1,a:cmdline)
    call setline(2,substitute(a:cmdline,'.','=','g'))
    execute 'silent 2read !'.escape(a:cmdline,'%#')
    setlocal nomodifiable
endfun 


fun! Gb()
    let tagname = GetTagName(line("."))
    exe ":CCTreeTraceReverse ".tagname
endfun

au BufWritePost *.[ch] 
          \ if (&filetype == 'c' || &filetype == 'h')
          "\ |  :GenerategtagsFiles"
          "\ |   exe "redraw!"

" Changlist start 

"au BufWritePost * 
"        \ if (&filetype == 'c' || &filetype == 'h')
"        \ | let g:CHLISTSTR = string(g:CHLIST)

"au BufReadPre *.[ch]
"       \ if exists('CHLISTSTR')
"       \ | let g:CHLIST = eval(CHLISTSTR)
"       \ | if len(g:CHLIST) > 0
"       \ | let g:ChlistCurKey = (keys(g:CHLIST))[0]


"au BufLeave *.[ch] let g:CHLISTSTR = string(g:CHLIST)

let g:ChlistCurKey = ""

nmap <script> <silent> cn :call ChangeListNewKey() <CR>
nmap <script> <silent> ct :call ChangeListShow() <CR>
nmap <script> <silent> ca :call ChangeListAdd() <CR>
nmap <script> <silent> cd :call ChangeListDel() <CR>
nmap <script> <silent> ck :call ChangeListSetCurKey() <CR>
nmap <script> <silent> cs :call ChangeListScan()   <CR>

"nmap <script> <silent> cu :call ChangeListUpdate() <CR>
"nmap <script> <silent> cd :call ChangeListDelkey() <CR>
"nmap <script> <silent> cj :call ChangeListScanNext() <CR>
"nmap <script> <silent> ck :call ChangeListScanPrev() <CR>

let g:CHLIST = {}

fun! ChangeListSetCurKey()
    let ckey = input("ckey:")
    let g:ChlistCurKey = ckey 
endfun

fun! ChangeListNewKey()
    let ckey = input("ckey:")
    if (ckey != '')
        if (!has_key(g:CHLIST, ckey))
            let g:CHLIST[ckey] = {}
            let g:ChlistCurKey = ckey
        "    call ChangeListUpdate()
        endif
    endif
endfun

fun! ChangeListDelkey()
    let ckey = input("dkey:")
    if (ckey != '')
        if (has_key(g:CHLIST, ckey))
            call remove(g:CHLIST, ckey)
        endif
    endif
endfun

fun! ChangeListAdd()
    let save_cursor = getpos(".")
    let bufn = bufname("%")

    if (!has_key(g:CHLIST, g:ChlistCurKey))
        echo "No keys"
        return
    endif

    if (!has_key(g:CHLIST[g:ChlistCurKey], bufn)) 
        let g:CHLIST[g:ChlistCurKey][bufn] = []
    endif

    for entry in g:CHLIST[g:ChlistCurKey][bufn]
        if (entry[1] == save_cursor[1])
            return
        endif
    endfor

    call add(save_cursor, bufn)
    call add(g:CHLIST[g:ChlistCurKey][bufn], save_cursor)
endfun

fun! ChangeListDel()
    let save_cursor = getpos(".")
    let bufn = bufname("%")

    if (!has_key(g:CHLIST[g:ChlistCurKey], bufn)) 
        return
    endif

    for entry in g:CHLIST[g:ChlistCurKey][bufn]
        if (entry[1] == save_cursor[1])
            call remove(g:CHLIST[g:ChlistCurKey][bufn], index(g:CHLIST[g:ChlistCurKey][bufn], entry))
            return
        endif
    endfor
endfun

fun! ChangeListShow()
        rightbelow new
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
        setlocal nowrap
        setlocal nonu

        let s:txt = printf("<%s>\n", g:ChlistCurKey)
        put =s:txt

        for ckey in keys(g:CHLIST)
            for fkey in keys(g:CHLIST[ckey])
                for lkey in g:CHLIST[ckey][fkey]
                    let s:txt = printf("%-10s %-35s %-5d %-50s", ckey, fkey, lkey[1], lkey[2])
                    put =s:txt
                endfor
            endfor
        endfor
        "cexpr! s:txt
        exe ":redraw"
        call getchar()
        exe ":close"
endfun

let g:qflist = []
fun! ChangeListScan()
    let dent = {}

    for ckey in keys(g:CHLIST)
        for fkey in keys(g:CHLIST[ckey])
            for lkey in g:CHLIST[ckey][fkey]
            call add(g:qflist, {"bufnr":lkey[0], "filename":lkey[4],
                   \ "lnum":lkey[1], "pattern":"", "col":lkey[2], "text":ckey})
            endfor
        endfor
    endfor

    if (!empty(g:qflist))
        call setqflist(g:qflist, "r")
        call ChangeNP(2)
    endif
endfun

fun! ChangeListUpdate()
    let cl_lineno = []
    let cl_fdict = {}
    let save_cursor = getpos(".")
    for ckey in keys(g:CHLIST)
        call cursor(1,1)
        let cl_flag = 1
        let cl_lineno=[]
        let line_entry=[]

        while (cl_flag)
            let cl_lineno=[]
            let cl_flag = search(ckey,'', line('$'))
            if (cl_flag != 0)
                call add(cl_lineno, cl_flag)
                call add(cl_lineno, GetTagName(line(".")))
                call add(line_entry, cl_lineno)
            endif
        endwhile

        let cl_fdict = {bufname("%"):line_entry}
        call extend(g:CHLIST[ckey], cl_fdict)
    endfor
    call setpos('.', save_cursor)
endfun



let g:ch_lkey_index = 0
let g:ch_scan_list=[]

fun! ChangeListScan1()
    let ch_i = 0
    let ch_keys=[]
    let ch_keys = keys(g:CHLIST)

    if (empty(g:CHLIST))
        return
    endif 

    if (len(g:CHLIST) == 1)
        let ckey =ch_keys[0]
    elseif
        for ckey in keys(g:CHLIST)
            echo ch_i." ".ckey
            let ch_i = ch_i + 1
        endfor

        let ch_sel = nr2char(getchar())

        if (ch_sel < 0 || ch_sel > 9)
            return
        endif

        let ckey = ch_keys[ch_sel]
    endif


    if (has_key(g:CHLIST, ckey))
        let g:ch_scan_list=[]
        for fkey in keys(g:CHLIST[ckey])
            for lkey in g:CHLIST[ckey][fkey]
                call add(g:ch_scan_list, [fkey, lkey[0], ckey])
            endfor
        endfor
    endif
    call ChangeNP(2)
endfun

fun! ChangeListScanNext()
    if (empty(g:ch_scan_list))
        call ChangeListScan()
    endif

    if (empty(g:ch_scan_list))
        return
    endif

    if (g:ch_lkey_index >= len(g:ch_scan_list))
        let g:ch_lkey_index = 0
        return
    endif

    exe 'silent edit' '+'.g:ch_scan_list[g:ch_lkey_index][1] fnameescape(g:ch_scan_list[g:ch_lkey_index][0]) 

    let ckey = g:ch_scan_list[g:ch_lkey_index][2]
    if (ckey != '')
        let ch_sflag = search(ckey,'', line('.'))
        if (ch_sflag == 0)
            call ChangeListUpdate()
        endif
    endif

    let g:ch_lkey_index = g:ch_lkey_index + 1
    if (g:ch_lkey_index >= len(g:ch_scan_list))
        let g:ch_lkey_index = 0
    endif
    call ChangeNP(2)
endfun

fun! ChangeListScanPrev()
    if (empty(g:ch_scan_list))
        call ChangeListScan()
    endif

    if (empty(g:ch_scan_list))
        return
    endif

    if (g:ch_lkey_index >= len(g:ch_scan_list))
        let g:ch_lkey_index = 0
        return
    endif

    exe 'silent edit' '+'.g:ch_scan_list[g:ch_lkey_index][1] fnameescape(g:ch_scan_list[g:ch_lkey_index][0]) 

    let ckey = g:ch_scan_list[g:ch_lkey_index][2]
    if (ckey != '')
        let ch_sflag = search(ckey,'', line('.'))
        if (ch_sflag == 0)
            call ChangeListUpdate()
        endif
    endif

    let g:ch_lkey_index = g:ch_lkey_index - 1

    if (g:ch_lkey_index < 0)
        let g:ch_lkey_index = len(g:ch_scan_list)-1
    endif
    call ChangeNP(2)
endfun

command! GenerategtagsFiles call GenerategtagsFiles()
    function! GenerategtagsFiles()
    let cmd = 'silent! !global --single-update ".bufname("%").' 
    let env = asynchandler#rename('gtags.files')
    call asynccommand#run(cmd, env)
endfunction
