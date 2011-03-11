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

" used to store syntax command for each file of tagfiles()
let s:syntable = {}

" Function {{{
"=================================================================
function! s:uniq(list) "{{{
  let dic = {}
  for e in a:list | let dic[e] = 1 | endfor
  return keys(dic)
endfunction "}}}

function! s:gen_syn_cmd(tag_file) "{{{
  let keywords = map(readfile(a:tag_file),'split(v:val,"\t")[0]')
  return printf(g:underlinetag_syntax , join(s:uniq(keywords), " "))
endfunction "}}}

function! s:execute_highlight() "{{{
  let tagfiles = map(tagfiles(), 'fnamemodify(v:val, ":p")')
  for tagfile in tagfiles
    if !has_key(s:syntable, tagfile)
      let s:syntable[tagfile] = s:gen_syn_cmd(tagfile)
    endif
  endfor

  for tagfile in tagfiles
    execute 'silent! ' . s:syntable[tagfile]
  endfor
  exe g:underlinetag_highlight
endfunction "}}}

function! underlinetag#toggle() "{{{
  " if g:underlinetag == 0 | return | endif
  if !exists('b:underlinetag') | let b:underlinetag = 0 | endif
  call underlinetag#do(!b:underlinetag)
endfunction "}}}

function! underlinetag#do(flag) "{{{
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

let &cpo = s:old_cpo
" vim: foldmethod=marker
