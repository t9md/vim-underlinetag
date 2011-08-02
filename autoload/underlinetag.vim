"=============================================================================
" File: underlinetag.vim
" Author: t9md <taqumd@gmail.com>
" Version: 0.5
" WebPage: http://github.com/t9md/vim-undelinetag
" License: BSD

" GUARD: {{{
"============================================================
if exists('g:loaded_underlinetag') &&
      \ exists("g:underlinetag_dev") &&
      \ !g:underlinetag_dev
  finish
endif

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

let s:underlinetag_ids = []
function! s:gen_syn_cmd(tag_file) "{{{
  let keywords = map(readfile(a:tag_file),'split(v:val,"\t")[0]')
  return printf(g:underlinetag_syntax , join(s:uniq(keywords), " "))
endfunction "}}}

let s:status = {}

function! s:execute_highlight() "{{{
  let tagfiles = map(tagfiles(), 'fnamemodify(v:val, ":p")')
  for tagfile in tagfiles
    if getftime(tagfile) > get(s:status, tagfile, 0)
      let s:syntable[tagfile] = s:gen_syn_cmd(tagfile)
      let s:status[tagfile] = getftime(tagfile)
    endif
  endfor
  for tagfile in tagfiles
    execute 'silent! ' . s:syntable[tagfile]
  endfor
  exe g:underlinetag_highlight
endfunction "}}}

function! underlinetag#toggle() "{{{
  if !exists('b:underlinetag') | let b:underlinetag = 0 | endif
  call underlinetag#do(!b:underlinetag)
endfunction "}}}

function! underlinetag#do(flag) "{{{
  if !g:underlinetag
    syn clear UnderlineTag
    let status = 0
  elseif a:flag == 1
    call s:execute_highlight()
    let status = 1
  else
    syn clear UnderlineTag
    let status = 0
  endif
  let b:underlinetag = status
endfunction "}}}
"}}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
