"=============================================================================
" File: underlinetag.vim
" Author: t9md <taqumd@gmail.com>
" Version: 0.5
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
if !exists('g:underlinetag_highlight')
  let g:underlinetag_highlight = 'highlight UnderlineTag gui=underline cterm=underline term=underline'
endif

if !exists('g:underlinetag_syntax')
  let g:underlinetag_syntax = 'syntax keyword UnderlineTag %s containedin=ALLBUT,.*String.*,.*Comment.*,cIncluded,.*Function.*'
endif
"}}}

if !exists('g:undelinetag')
  let g:underlinetag = 1
endif
if !exists('g:undelinetag_autoupdate')
  let g:underlinetag_autoupdate = 0
endif

" Command {{{
"=================================================================
command! UnderlineTagOn       :call underlinetag#do(1)
command! UnderlineTagOff      :call underlinetag#do(0)
command! UnderlineTagToggle   :call underlinetag#toggle()
command! UnderlineTagDisable  exe 'let g:underlinetag=0 | call underlinetag#do(0)'
command! UnderlineTagEnable   exe 'let g:underlinetag=1'
" }}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
