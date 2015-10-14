" These are settings to make folding easier to use and look at:
"  - Indented folded lines to match origin line indentation.
"  - Statbox to right displays line count and fold level.
"
" Note that custom foldtext will only work for vim 7.3+.

if has('folding')

  set foldtext=CustomFoldText()

  function! CustomFoldText(...)
    " At least vim 7.3
    "  - Requirement for `strdisplaywidth` (If `strdisplaywidth` fails for
    "  multi-byte chars, consider checking the `strlen` help).
    if v:version < 703
      return foldtext()
    endif

    " Common variables for all foldmethods.
    let lineCount = v:foldend - v:foldstart + 1
    let displayWidth = winwidth(0) - &foldcolumn
    if (&number || &relativenumber)
      let displayWidth -= &numberwidth
    endif
    let foldChar = '-'

    " Set fold fillchar.
    let &l:fillchars = substitute(&l:fillchars,',\?fold:.','','gi')
    execute 'setlocal fillchars+=fold:' . foldChar

    " Fold text for Diffs - centre-aligned statbox with a line count.
    if &foldmethod == 'diff'
      let statBox = printf('[ %s matching lines ]', lineCount)
      let filler = repeat(foldChar, (displayWidth - strchars(statBox)) / 2)
      return filler.statBox
    endif

    " Fold text for all other situations.
    "  - Fold description is a max length of 1/3 of the current window width.
    "  - Fold & comment markers are removed from the fold description.

    " Prepare fold indent, and if long enough, indicate folding with '+'.
    let foldIndicator = '+ '
    let indLen = strdisplaywidth(foldIndicator)
    if indent(v:foldstart) >= indLen
      let indent = repeat(' ', indent(v:foldstart) - indLen) . foldIndicator
    else
      let indent = repeat(' ', indent(v:foldstart))
    endif

    " Prepare the statbox.
    "  - Fix statbox width at 18 chars.
    "  - Count width by display cells instead of bytes (vim 7.4+).
    if v:version >= 704
      let countType = 'S'
    else
      let countType = 's'
    endif
    let statBox = '[ ' . printf('%14'.countType, lineCount.' lns, lv '.v:foldlevel) . ' ]'

    " Prepare fold description.
    "  - Use function argument as fold description text if provided.
    let foldDesc = a:0 > 0 ? a:1 : getline(v:foldstart)

    " Remove any fold markers.
    let foldmarkers = split(&foldmarker, ',')
    let foldDesc = substitute(foldDesc, '\V' . foldmarkers[0] . '\%(\d\+\)\?\s\*', '', '')

    " Remove any surrounding whitespace.
    let foldDesc = substitute(foldDesc, '^\s*\(.\{-}\)\s*$', '\1', '')

    " Space the description away from the midfiller a bit.
    let foldDesc = foldDesc . ' '

    " Prepare filler lines.
    "  - midFiller is the fill between the description and statbox, so its
    "  length is the leftover space after all other elements.
    let endFiller = repeat(foldChar, 1)
    let midFillerLength = displayWidth - strdisplaywidth(indent.foldDesc.statBox.endFiller)
    let midFiller = repeat(foldChar, midFillerLength)

    return indent.foldDesc.midFiller.statBox.endFiller
  endfunction

endif
