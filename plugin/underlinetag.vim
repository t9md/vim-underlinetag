"=============================================================================
" File: underlinetag.vim
" Author: t9md <taqumd@gmail.com>
" Version: 0.1.0
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
let g:underlinetag = 0
let g:underlinetag_file = exists('g:underlinetag_file')
      \ ? g:underlinetag_file
      \ : 'underlinetag_syntax.vim'
"}}}
" Function {{{
"=================================================================

function! s:uniq(list) "{{{
  let dic = {}
  for e in a:list | let dic[e] = 1 | endfor
  return keys(dic)
endfunction "}}}
function! s:prepare(tag_file) "{{{
  if !filereadable(a:tag_file)
    return ""
  endif
  let format = 'syntax keyword UnderlineTag %s containedin=ALLBUT,.*String.*,.*Comment.*,cIncluded,.*Function.*'
  let keywords = map(readfile(a:tag_file),'split(v:val,"\t")[0]')
  return printf(format, join(s:uniq(keywords), " "))
endfunction "}}}
function! s:underlinetag_syntax_gen() "{{{
  let tag_files = tagfiles()
  let result = []
  for tag_file in tag_files
    call add(result,s:prepare('tags'))
  endfor
  call filter(result, '!empty(v:val)')
  call writefile(result, g:underlinetag_file)
endfunction "}}}
function! s:underlinetag_toggle() "{{{
  if !exists('b:underlinetag')
    let b:underlinetag = 0
  endif
  let b:underlinetag = !b:underlinetag
  if b:underlinetag
    execute 'silent! source ' . g:underlinetag_file
    let highlight_cmd = exists('g:underlinetag_highlight')
          \ ? g:underlinetag_highlight
          \ : 'gui=underline cterm=underline term=underline'
    exe 'highlight UnderlineTag ' . highlight_cmd
  else
    syn clear UnderlineTag
  endif
endfunction "}}}

"}}}
" Command {{{
"=================================================================
command! UnderlilneTagToggle   :call s:underlinetag_toggle()
command! UnderlilneTagGenerate :call s:underlinetag_syntax_gen()
" }}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
