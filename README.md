What is this?
==================================
While I'm reading source code , I use tags and tagjump facility.
But to know what word I could jump is not possible at a glance.

This mini-plugin provide facility to underline tagged keyword.

How to use?
================================

Generate syntax file
----------------------

Following command generate vim syntax file.
This file is sourced when you call function `UnderlineTagToggle`

    :UnderlineTagGenerate

Underline or Un-Underline
----------------------
    :UnderlineTagToggle

Mapping
----------------------

    nnoremap <Space>] :<C-u>UnderlineTagToggle<CR>

Register to autocmd Hook
-------------------------
If you whan to tag underlined automatically as default.
Set following snippet to your .vimrc

    augroup UnderlineTag
      autocmd!
      autocmd BufEnter *.py UnderlineTagOn
    augroup END

