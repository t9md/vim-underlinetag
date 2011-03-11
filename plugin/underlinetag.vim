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

" Command {{{
"=================================================================
command! UnderlineTagOn       :call underlinetag#do(1)
command! UnderlineTagOff      :call underlinetag#do(0)
command! UnderlineTagToggle   :call underlinetag#toggle()
" }}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
