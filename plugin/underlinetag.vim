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
let g:underlinetag_highlight = exists('g:underlinetag_highlight')
      \ ? g:underlinetag_highlight
      \ : 'highlight UnderlineTag gui=underline cterm=underline term=underline'

let g:underlinetag_syntax = exists('g:underlinetag_syntax')
      \ ? g:underlinetag_syntax
      \ : 'syntax keyword UnderlineTag %s containedin=ALLBUT,.*String.*,.*Comment.*,cIncluded,.*Function.*'
"}}}

" Command {{{
"=================================================================
command! UnderlineTagOn       :call underlinetag#do(1)
command! UnderlineTagOff      :call underlinetag#do(0)
command! UnderlineTagToggle   :call underlinetag#toggle()
" }}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
