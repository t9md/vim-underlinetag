"=============================================================================
" File: underlinetag.vim
" Author: t9md <taqumd@gmail.com>
" Version: 0.2
" WebPage: http://github.com/t9md/vim-undelinetag
" License: BSD

" GUARD: {{{
"============================================================
" if exists('g:loaded_underlinetag')
  " finish
" endif

let g:loaded_underlinetag = 1
let s:old_cpo = &cpo
set cpo&vim
" }}}

" Init {{{
"=================================================================
" used to store syntax command for each file of tagfiles()
let g:underlinetag_syntable = {}

" controll enabled or disabled globally
let g:underlinetag = 1

" is used when highlight tagged keyword
let g:underlinetag_file = exists('g:underlinetag_file')
      \ ? g:underlinetag_file
      \ : 'underlinetag_syntax.vim'

let g:underlinetag_highlight = exists('g:underlinetag_highlight')
      \ ? g:underlinetag_highlight
      \ : 'gui=underline cterm=underline term=underline'

let s:syn_cmd_format = 'syntax keyword UnderlineTag %s containedin=ALLBUT,.*String.*,.*Comment.*,cIncluded,.*Function.*'
"}}}

" Function {{{
"=================================================================
function! s:uniq(list) "{{{
  let dic = {}
  for e in a:list | let dic[e] = 1 | endfor
  return keys(dic)
endfunction "}}}

function! s:gen_syn_cmd(tag_file) "{{{
  let keywords = map(readfile(a:tag_file),'split(v:val,"\t")[0]')
  return printf(s:syn_cmd_format, join(s:uniq(keywords), " "))
endfunction "}}}

function! s:underlinetag_syntax_gen(tagfile) "{{{
  call map(map(tagfiles(), 'fnamemodify(v:val, ":p")'),
        \ 'let g:underlinetag_syntable[v:val] = s:gen_syn_cmd(v:val)')
endfunction "}}}

function! s:execute_highlight() "{{{
  let tagfiles = map(tagfiles(), 'fnamemodify(v:val, ":p")')
  for tagfile in tagfiles
    if !has_key(g:underlinetag_syntable, tagfile)
      let g:underlinetag_syntable[tagfile] = s:gen_syn_cmd(tagfile)
    endif
  endfor

  for tagfile in tagfiles
    execute 'silent! ' . g:underlinetag_syntable[tagfile]
  endfor
  exe 'highlight UnderlineTag ' . g:underlinetag_highlight
endfunction "}}}

function! s:underlinetag_toggle() "{{{
  " if g:underlinetag == 0 | return | endif
  if !exists('b:underlinetag') | let b:underlinetag = 0 | endif
  call s:underlinetag(!b:underlinetag)
endfunction "}}}

function! s:underlinetag(flag) "{{{
  " if g:underlinetag == 0 | return | endif
  if a:flag == 1
    call s:execute_highlight()
    let status = 1
  else
    syn clear UnderlineTag
    let status = 0
  endif
  let b:underlinetag = status
  return status
endfunction "}}}
"}}}
" Command {{{
"=================================================================
command! UnderlineTagEnable   :let g:underlinettag = 1
command! UnderlineTagDisable  :let g:underlinettag = 0
command! UnderlineTagGenerate :call s:underlinetag_syntax_gen()
command! UnderlineTagOn       :call s:underlinetag(1)
command! UnderlineTagOff      :call s:underlinetag(0)
command! UnderlineTagToggle   :call s:underlinetag_toggle()
" }}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
