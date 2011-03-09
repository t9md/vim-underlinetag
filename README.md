What is this?
==================================
While I'm reading source code , I use tags and tagjump facility.
But to know what word I could jump is not possible at grance.

This mini-plugin provide facility to underline tagged keyword.

How to use?
================================
Generate syntax file
----------------------
following command generate vim syntax file.
This file is sourced when you call function `UnderlilneTagToggle`

    :UnderlilneTagGenerate

Underline or Un-Underline
----------------------
    :UnderlilneTagToggle

Mapping suggestion
----------------------
    nnoremap <Space>] :<C-u>UnderlilneTagToggle<CR>
