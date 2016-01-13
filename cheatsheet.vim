
" Toggle invisible symbols like Tab and EOL
" Shortcut to rapidly toggle `set list`

" If you like, you can customise other invisible characters besides tabs and
" end-of-lines. For more information, run :help listchars.
" You can customise the syntax highlighting colours of invisible 
" characters with the NonText and SpecialKey keywords. 
" In my prefered colourtheme, I have added the following lines:
" Invisible character colors 

highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Unicode characters can be inserted by typing <CTRL-v u> followed by the 4
" digit hexadecimal code.

" Sets tabstop, softtabs, shiftwidth
set ts=8 sts=0 sw=8 noexpandtab " default settings

" If you prefer to work with tab characters then it is a good 
" idea to ensure that tabstop == softtabstop. This makes it less 
" likely that you’ll end up with a mixture of tabs and spaces for 
" indentation. If you prefer to work with spaces, then it is preferable to 
" ensure that softtabstop == shiftwidth. This way, you can expect the same 
" number of spaces to be inserted whether you press the tab key in insert 
" mode, or use the indentation commands in normal/visual modes.The following 
" snippet of vimscript allows you to assign the same value to tabstop, 
" softtabstop and shiftwidth simultaneously:" Set tabstop, softtabstop 
" and shiftwidth to the same value

command! -nargs=* Stab call Stab()
function! Stab()
   let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
   if l:tabstop > 0
      let &l:sts = l:tabstop
      let &l:ts = l:tabstop
      let &l:sw = l:tabstop
   endif
   call SummarizeTabs()
endfunction

function! SummarizeTabs()
   try
      echohl ModeMsg
      echon 'tabstop='.&l:ts
      echon ' shiftwidth='.&l:sw
      echon ' softtabstop='.&l:sts
      if &l:et
         echon ' expandtab'
      else
         echon ' noexpandtab'
      endif
   finally
      echohl None
   endtry
endfunction

" To invoke this command, go into normal mode (by pressing escape) then run: :Stab
" Then hit enter. You will see this :set tabstop = softtabstop = shiftwidth = 
" Enter the size that you want to assign to those settings, and hit enter. A 
" summary line then shows the value of each setting, as well as showing 
" whether or not expandtab is enabled. If you hit enter without providing a 
" value, then the tab settings are not affected.You can also call the summary 
" line by itself. I’ve mapped this to ctrl-shift-tab for convenience. Feel free to 
" modify the mappings, and the funcionality to suit your preferences.

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss and .atom files as XML
  autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
endif

" The command for converting between tabs and spaces is:
" :retab!
" More specifically, to convert tabs to spaces, run:
" :set expandtab
" :retab!
" And to convert spaces to tabs, run:
" :set noexpandtab
" :retab!
"
" Strip trailing whitespace
" Strip trailing spaces throughout an 
" entire file by running this substitution command:
" :%s/\s\+$//e
" This has a couple of side-effects: it moves your cursor, and 
" sets the last item in your search history to trailing whitespace. 
" This function gets around these problems:

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Put it in your .vimrc file.If you want to map this function to a key (e.g. F5), add this:
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
" If you want to run this command automatically when a file is saved, add this:
autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

" This example runs the autocommand on python and javascript files. 
" Use this as a template, and add other filetypes to suit your needs.
" Delete blank linesYou can delete all blank lines by running the 
" following command:  
" :g/^$/d

" These commands show and navigate through the buffer list:
" command | action
" --------+---------------------
" :ls	    | show the buffer list
" :bn	    | open the next buffer in the current window (cycles from the end of
"         | the list to the beginning).
" :bp	    | open the previous buffer in the current window (cycles from the
"         | start of the list to the end).
" --------+---------------------

" CTRL-^	-- switch to the alternate file
"
" Dealing with hidden buffers
" A buffer is marked as ‘hidden’ if it has unsaved changes, and it is not
" currently loaded in a window. If you try and quit Vim while there are hidden
" buffers, you will raise an error: E162: No write since last change for
" buffer “a.txt”. In this scenario, you can do any of the following:
"
" command | action
" --------+---------------------
" :w	    | save the changes to a file
" :e!	    | restore the original file
" :bd!	 | forcibly remove the buffer from the buffer list, discarding any changes
" :q!	    | force Vim to quit, discarding changes to all modified buffers
" --------+---------------------
"
" By default, Vim makes it difficult to create hidden buffers. 
" To make Vim more liberal about hidden buffers, put the 
" following in your .vimrc:
set hidden

" command    | action
" -----------+---------------------
" ctrl-w s	 | split the current window horizontally, loading the same file in the new window
" ctrl-w s	 | split the current window horizontally, loading the same file in the new window
" ctrl-w v	 | split the current window vertically, loading the same file in the new window
" :sp[lit]   | filename	split the current window horizontally, loading filename in the new window
" :vsp[lit]  | filename	split the current window vertically, loading filename in the new windowClosing split windows
" :q[uit]    | close the currently active window
" :on[ly]    | close all windows except the currently active windowChanging focus between windows
" ctrl-w w	 | cycle between the open windows
" ctrl-w w	 | cycle between the open windows
" ctrl-w h	 | focus the window to the left
" ctrl-w j	 | focus the window to the down
" ctrl-w k	 | focus the window to the up
" ctrl-w l	 | focus the window to the rightI have the following lines in my .vimrc file:map <C-h> <C-w>h
" -----------+---------------------
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Resizing windows
" You can resize windows by clicking on the boundary between windows, and
" dragging it to your prefered size. The following key commands also help:
"
" command   |  action
" ----------+---------------------
" ctrl-w +	|  increase height of current window by 1 line
" ctrl-w -	|  decrease height of current window by 1 line
" ctrl-w _	|  maximise height of current window
" ctrl-w |	|  maximise width of current windowMoving windows
" ctrl-w r	|  rotate all windows
" ctrl-w x	|  exchange current window with its neighbour
" ctrl-w H	|  move current window to far left
" ctrl-w J	|  move current window to bottom
" ctrl-w K	|  move current window to top
" ctrl-w L	|  move current window to far right
" ----------+---------------------


" command             |  action
" --------------------+---------------------
" :tabe[dit] filename |  Open filename in a new tab
" ctrl-W T	          |  Move current split window into its own tab
" :q	                |  Close window, closing tab if it contains a single window
" :tabc[lose]	       |  Close the current tab page and all its windows
" :tabo[nly]	       |  Close all tabs apart from the current oneSwitching tabsWhen you 
"                     |  have multiple tabs open
" --------------------+---------------------
" You can switch between them using the 
" mouse, or the following commands:
" --------------------+---------------------
" gt	                |  Move to next tab
" gT	                |  Move to previous tab
" #gt	                |  Move to tab number #I’m accustomed to the tab switching shortcuts of Firefox, so to port these into my Vim environment, I include the following in my .vimrc:" For mac users (using the 'apple' key)
" --------------------+---------------------

" for linux and windows users (using the control key)
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-0> :tablast<CR>

" Rearranging tabs
" In MacVim, you can rearrange tabs by dragging and dropping them with the
" mouse.  The following commands can be used in Terminal Vim:

" command    |  action
" -----------+---------------------
" :tabmove	 | Move current tab to the end
" :tabmove 0 | Move current tab to the beginning
" :tabmove 1 | Move current tab to become the 2nd tab
" -----------+---------------------

" Vims tabs can point to different directories
" For example: first tab holds file in c:\project1\subdirectory1
"              second tab holds file in d:\project2\
" To change location issue cmd :cd followed by path to folder
" To see current location use :pwd command

" Vim lets you define a visual selection, then perform search and replace only
" on the selected range of lines. It’s tempting to think that in visual block
" mode, a substitution command such as this:
" :s/_/ /g
" would operate only on the selected block. But Vim considers the range to
" include entire lines, so the search and replace operation is not limited to
" the visual block.The trick here is to modify the search pattern with the
" flag \%V. This tells Vim to match only within the visual selection. Running
" this substitution has the desired effect:
" :s/\%V_/ /g

" The changelist remembers the position of every change that can be 
" undone. You can move back and forwards through the changelist 
" using the commands:
" g;
" g,
"
" You can view the contents of the changelist by running the command:
" :changes

" The Jumplist
" Vim also maintains a jumplist, remembering each position to which the cursor
" jumped, rather than scrolled. You can move backwards and forwards through
" the jumplist with the commands:
" ctrl-o
" ctrl-i
" You can view the contents of the jumplist by issuing the command:
" :jumps
" When you are browsing Vim’s documentation, you can follow the link under the
" cursor with the command:
" ctrl-]

" Depending on what arguments you supply, the :edit command may do one of 3 things:
" 1) pass it the name of a file, and it will open that file in the current window
" 2) pass it the name of a directory, and it will open a file explorer for that directory
" 3) when called with no arguments, the :edit command will revert to the latest 
"    saved version of the current file. 
" To discard unwanted changes, you will have to force this command with a
" trailing ‘!’ bang.  Pressing the <tab> key triggers auto-complete for
" directories and files that match the characters you have typed so far.If you
" want to open several files from the same directory, specifying the full path
" can start to feel like a lot of extra work. You could set the working
" directory to match that of the file being edited in the current window by
" issuing the command:
" :cd %:h
" However, this can make it harder to locate some files, because you have to 
" climb the directory tree before drilling down again. I prefer to create a 
" set of shortcuts for opening files located in the same directory as 
" the current file:
"
let mapleader=','
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
" Now, I can run ,ew and it expands to :e path/to/directory/of/current/file/. 
" This makes it really easy to open several files from the same directory.
" The ‘ew’ command stands for open in window. The other variants stand for
" open in split (‘es’), open in vertical split (‘ev’) and open in tab (‘et’)
" respectively. Additionally, this allows you to expand the directory of the
" current file anywhere at the command line by pressing %%.

" If you want to make Vim wrap long lines to fit in the window, you first have
" to enable 
" :set wrap. 
" By default Vim will break lines at exactly the width of the window, which 
" causes some words to be split across two lines. To prevent this from 
" happening, you can enable 
" :set linebreak
" The linebreak setting will not work when the list setting is enabled. So if
" you find that enabling linebreak does not produce the desired effect, try
" running 
" :set nolist. 
" To be sure, you can run the following command:
" :set wrap linebreak nolist
" Rather than having to ensure that 3 separate options are configured 
" correctly, I would prefer if I could just issue the command 
" :Wrap. 
" This can be achieved by putting the following in your .vimrc file:
command! -nargs=* Wrap set wrap linebreak nolist
"
" Moving around through wrapped lines
" Unlike many text editing environments, Vim makes a distinction between
" displayed lines, and numbered lines.  When wrap is enabled, each numbered
" line might be split across more than one display lines. The k and j keys
" move up and down by numbered lines. If you want to move the cursor up and
" down by display lines instead, you can use the commands gk and gj instead.
" Hitting two keys in quick succession feels slow compared to pressing a
" single key whilst holding down a modifier key.
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^
" On the mac, this allows me to use j, k, $, 0 and ^ on display lines by holding 
" down the command key.
" If you prefer not to show line numbers, there is another way. The showbreak option 
" can be set to a character which will lead each display line after the first one. 
" It can be set as follows:
" :set showbreak=â€¦

" The gq{motion} command will format a section of text. The ip motion selects
" the current paragraph, so gqip applies formatting to the current
" paragraph.Running the gq command moves the cursor to the end of the
" paragraph.  If you want to keep the cursor on the same word, you can instead
" run the command gw.The textwidth setting is a number representing the
" maximum allowed width of a line. When set to zero, which is the default, Vim
" will use the full width of the window up to a maximum of 80 characters. When
" set to a value above zero, Vim will format lines of text so as not to exceed
" the value of textwidth.The wrapmargin setting can be used to specify the
" number of characters from the right window border where wrapping begins.
" This can be useful if you have number or foldcolumn enabled, as both of
" these use up some of the width of the window. The textwidth setting takes
" precedence over wrapmargin.You can influence how Vim applies formatting with
" the formatoptions setting. This is a string, which may contain any of the
" flags defined in fo-table. You can set the formatoptions to a string by
" direct assignment:
" :set formatoptions=tcq 
" You can also add and remove flags from the list, with the following invocations:
" :set fo+=a 
" :set fo-=n 
" In the video, I demonstrate how Vim behaves when inserting, editing and
" deleting text with a blank formatoptions string, then with fo=t, and finally
" with fo=ta.Note that the gq command will only invoke Vim’s internal
" formatter if both the formatexpr and formatprg options are blank. On the
" other hand, the gw command will always invoke Vim’s internal formatting
" engine, even if one of the alternate formatters is enabled.

" Spell checking is enabled by running 
" :set spell
"
" Toggle spell checking on and off with `,s` let
mapleader = "," 
nmap <silent> <leader>s :set spell!<CR>
"
" Set region to British English
" set spelllang=en_gb 

" The default spelllang is en, which includes all regions of English. In the
" example above, I run set spelllang=en_gb, which sets the region to British
" English. This means it is possible to have several documents open at once,
" and for each to have their own spelling dictionary. If you would prefer to
" set the spelllang to the same value for all documents, you can run one of
" the following:

" :windo set spelllang=en_us 
" :bufdo set spelllang=en_us 

" The first of these will set the spelling dictionary for all windows in the 
" current tabpage. The second one will apply the spelling dictionary to all 
" open buffers. You can advance through the highlighted spelling errors with the 
" ]s 
" command, or you can move through them backwards with the 
" [s 
" command. When the cursor is on a misspelled word, you can bring up a list of
" suggested corrections with the command 
" z=
" The prompt at the bottom of the screen advises you to enter the number of
" the word you want to use in place of the misspelled word, then hit enter.
" This takes you back to your document, with the correction applied.If you
" prepend the z= command with a count, it will take that word from the list of
" suggested corrections without even showing you the list. So if you are
" confident that the first suggestion is the one you want, you could instead
" run 
" 1z=
" Adding and removing words to spellfileBy default, Vim will load a
" spellfile from the location: ~/.vim/spell/LL.EEE.add Where LL is the language
" and EEE is the encoding of the file in the active window. For example, if
" you are editing a file whose encoding is UTF-8, with spelllang set to en_us
" then Vim will look for a spell file at ~/.vim/spell/en.utf-8.add
" If you don’t want to correct a word, you can add it to the spellfile with
" the 
" zg 
" You can also remove a word from the spelling dictionary with the 
" zw 
" If you change your mind, each of these commands can be reverted with the
" undo commands 
" zug and zuw

" To paste contents of another file into currently opened
" :r <file name>
" command is used. It command read all from <file name> and paste text below 
" current line of current file

" In Visual selection mode press <o> to toggle between selections angles
" If in Visual selection mode press $ that will move cursor to the end of line
" and selects all lines to end even if they have different length

" You may already know that gv can be used to start visual mode with the same
" selection as last time visual mode was used. If you have cut and pasted a
" visual selection, then this doesn’t work the way that you would expect.
" Fortunately, you can visually select the text from the last edit by jumping to
" the first and last characters with the motions \[ and `]`.I keep the following
" mapping in my .vimrc:
" Visually select the text that was last edited/pasted
nmap gV `[v`] 
" So with gv I can reselect the last visual selection, and with gV
" I can visually select the text that was most recently edited or pasted.

" Use q/ to open command line buffer to insert search commands like in regular buffer
" Use q: to open command line buffer to insert commands like in regular buffer
" <ctrl-f> - Switch from commandline mode to the commandline window

" Essential folding commands
" command    | action
" -----------+---------------------
" zi         |  which turns the folding functionality on and off. 
" zi	       |  switch folding on or off 
" za	       |  toggle current fold open/closed 
" zc	       |  close current fold 
" zR         |  open all folds 
" zM	       |  close all folds 
" zv	       |  expand folds to reveal cursor
" -----------+---------------------
" zj	       |  move down to top of next fold 
" zk	       |  move up to bottom of
" -----------+---------------------
" I recommend learning these commands first. The za command is so useful that you
" may want to consider mapping it to a single keystroke.
" nnoremap <Space> za 
" While za is great for opening folds, the zc command is often more suitable
" when you want to close a fold. If the current fold is already closed, then
" zc will close the parent fold.

" Navigating the unfolded document
" Even when the document is fully unfolded, the fact that Vim knows where the
" folds start and finish gives us an additional method for moving around.  The
" custom fold expression adds a whole new layer of semantics, which allows us
" to rapidly navigate the sections of the document.
" command  |  action
" ---------+----------------------
" zo 	     |  open current fold 
" zO 	     |  recursively open current fold 
" zc	     |  close current fold 
" zC 	     |  recursively close current fold 
" za	     |  toggle current fold 
" zA 	     |  recursively open/close current fold 
" zm	     |  reduce `foldlevel` by one 
" zM	     |  close all folds zr increase `foldlevel` by one 
" zR	     |  open all folds
" ---------+----------------------

" Creating an ftpluginCreate a filetype plugin for markdown files as follows:
mkdir -p ~/.vim/after/ftplugin/markdown 
vim ~/.vim/after/ftplugin/markdown/folding.vim 
" You can replace markdown with the name of any other language to create a
" filetype plugin for that language instead.The mechanics of a foldexpr
" Here’s the boilerplate fold expression that we used to begin with:

function! MarkdownFolds()
  return "0"
endfunction
setlocal foldmethod=expr
setlocal foldexpr=MarkdownFolds()

" For markdown files
function! MarkdownFolds()
   var currentLine = getline(v:lnum)
   if match(currentLine, "^##") >= 0
      return ">2"
   elseif match(currentLine, "^#") >= 0
      return ">1"
   elseif
      return "="
   endif
endfunction

" It works like this: the MarkdownFolds() function is called one time for each
" line in the document. If the function returns "0", it indicates that the line
" is not part of a fold. If the function returns "1", it indicates that the line
" has a fold level of one. Here are a few more values that can be returned from
" a fold expression, with their meanings: 
" value	      |  meaning
" -------------+------------------
 "0"	         |  the line is not in a fold
 "1", "2", ...	|  the line is in a fold with this level
 "="	         |  use fold level from the previous line
 ">1", ">2"	   |  a fold with this level starts at this line
" -------------+------------------
" For a complete list of values that can be returned by a fold expression, look
" up :help fold-expr.
" Inside of a fold expression, we can use the v:lnum variable to access the
" line number of the current line that is being evaluated. This can easily be
" combined with the getline() function to get the contents of the current line
" that’s being evaluated.

" Customizing the foldtext
" We can customize the way that a fold looks by way of the foldtext option.
" Here’s the boilerplate foldtext expression that we used to begin with:

function! MarkdownFoldText() 
   return getline(v:foldstart)
endfunction
setlocal foldtext=MarkdownFoldText()

" Inside of a foldtext expression, we can use the v:foldstart and v:foldend
" variables, which reference the line numbers of the first and last lines that
" make up the current fold.

" @: - repeats the latest ex command

" The argdo command works like this:
" :argdo {cmd}
" Where {cmd} could be any Ex command, such as 
" :substitute, :global, or :normal 
" for example. This is just like running:
" :first
" The argdo command works best when the 'hidden' setting is enabled. For more
" information, see Vimcast episode 6 - Working with buffers.

" Using argdo with substitute
" The video demonstrates how to use argdo with the substitute comamnd.  We
" start off simple:
" :argdo %s/\a/*/g 
" There’s a problem with this command: if any of the buffers in the argument
" list do not contain a match for the pattern specified by the substitute
" command (in this case \a), then the substitue command will raise an error:
" E486 pattern not found. We can suppress this error by modifying the
" substitute command with the e flag:
" :argdo %s/\a/*/ge 
" That cuts down some of the noise, but the substitute command still reports
" details of about the effect it has on each file in the argument list. We can
" suppress that output by prefixing the whole thing with silent:
" :silent argdo %s/\a/*/ge 
" Alternatively, we could use :silent!, which would suppress all output
" including error messages. That way, we could leave out the e flag:
" :silent! argdo %s/\a/*/g 

" Pasting the last Ex command into the command line
" On the command line, you can paste the contents of a register by pressing
" <C-r>{register}. In this context, the quote: register comes in handy: it
" contains the last executed Ex command. For example, if we start out by
" running a simple substitute command:
" :%s/\a/*/g 
" To prefix this with argdo, simply type :argdo, then a space, then <C-r>:
" which will produce:
" :argdo %s/\a/*/g 
" After executing this command, the : register will contain 
" argdo %s/\a/*/g
" We could prefix this with silent by typing :silent, space, then <C-r>: to
" produce:
" :silent argdo %s/\a/*/g 
" 
" :argdo Vs :bufdo
" Just as we can use :argdo to execute a command on each of the files in the
" arglist, we can use :bufdo to execute a command on each of the files in the
" buffer list. In some circumstances, the buffer list and arglist may refer to
" the same set of files.  In this case, it would make no difference whether
" you used :bufdo or :argdo. It’s easy to add files to the buffer list
" (perhaps unintentionally), so if you use :bufdo there’s always a risk that
" it might end up touching a file that you didn’t mean to change.  Whereas the
" arglist only changes when you tell it to. For that reason, I prefer to use
" :argdo instead of :bufdo.

" The :t command is simply an alias for :copy

" Iterate throw all file in args list witch matches {pattern}
" and execute command on each line from QuickFix list
" :vimgrep %s/{pattern}/{replacement}/g ##
" :cdo %s/{pattern}/{replacement}/ge
" :cdo update

" We can use <C-r>" to insert the text that was just deleted with the cw
" command. That works fine for a one off change, but if we attempt to repeat
" the change with the dot command, it reproduces the result of the last
" insertion.  In the example, that means using the dot command on two produces
" (one), when we actually want (two).If we use <C-r><C-o>" instead, Vim
" inserts the contents of the default register literally, using the current
" value of the default register. In this case, we can use the dot command to
" repeat the remaining changes.

" Calling functions from Vimscript standard library
" For example, we could use the sqrt() function to calculate the square root
" of a number:
" :put =sqrt(81)
" We can execute any Vimscript code at the expression register. So long as the
" expression returns a string (or something that can be converted to a string),
" then we can use the result. For a complete reference of the functions defined
" in Vim’s standard library, look up 
" :h function-list

" Calling user-defined functions
" We’re not limited to using functions defined in the Vimscript standard
" library. We can also evalute user-defined functions. For example, Vimscript
" has no simple way of generating a random number. We could hand-roll our own
" Random() function:

function! Random()
  return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
endfunction

" We could use this function at the expression register:
" :put =Random()
" Calling external scriptsThe system() function allows us to get the output
" from some external script. For example, if we’re running Vim inside the Bash
" shell, we could use the built-in bash function $RANDOM to fetch a random
" number:
" :put =system('echo $RANDOM')
" If we wanted some more complex behaviour, we could write a script using a
" language of our choice. For example, here’s a tiny script written in Ruby,
" which uses the faker library to generate fake credentials:

" ```ruby code
" require 'faker'
" name = [Faker::Name.first_name, Faker::Name.first_name].join(" ")
" print [name, Faker::Internet.email(name)].join(",")
" ```

" We could run this script at the Bash shell like this:
" $ ruby fake-credentials.rb
" Lottie Walton,lottie.walton@hartmannsipes.name

" Inside of Vim, we could use the expression register to insert the results from
" this external script into the document:
" :put =system('ruby fake-credentials.rb')
" Ex commands
" We can invoke the expression register using the :put Ex command.  For
" example, this command would insert a new line containing the text ‘9.0’:
" :put =sqrt(81)
" When we invoke the expression register from Insert mode (via <C-r>=), the
" result is inserted at the current cursor location. Whereas the :put Ex command
" always inserts the result on a new line. We could use this same technique to
" insert fake credentials from our simple ruby script:
" :put =system('ruby fake-credentials.rb')
" If you’re only using the expression register to get output from an external
" script, then there’s an even quicker way of doing it: using the :read!
" “read-bang” Ex command.
" :read !ruby fake-credentials.rb
" This executes the specified command in the shell and outputs the results
" directly into the document below the cursor position.



