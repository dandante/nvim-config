# my neovim cheat sheet

## Terminal

* Open/toggle terminal with `CTRL-/`
* Move focus between terminal and window above with `CTRL-J` (go down) and `CTRL-K` (go up).
* In terminal, go to normal mode with `CTRL-\ CTRL-N`; go back to insert (terminal)
  mode with `i`.

## Copy/paste/registers

* To paste from e.g. register 0, type `"0p`.


## File explorer

* Switch between explorer and open buffers with `CTRL-H` (left) and `CTRL-L` (right).
* If explorer randomly takes up most of the screen width, toggle it off and back
  on with `<Leader>-e` twice. NOTE: That does not always work, but this (in command mode)
  will make the current window take up 50% of the total width:

```
lua vim.api.nvim_win_set_width(0, math.floor(vim.o.columns / 2))
```

Or, slightly easier to remember, make the current window wider by some amount:

```
vertical resize +30
```

## Navigating buffers

`H` and `L` to move left/right between open buffers.
Close current buffer with `:bd`.

## Run code in Lua

`<Leader>-?\r` will run the current line (or selection?)

## Compare unsaved buffer to original File


```
:vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
```

Still figuring out some subtleties of this.

## Resize Buffers

`ALT-HJKL` (These are custom keymaps)

## Moving selections up and down (Visual mode)

Related key combinations `ALT-K` and `ALT-J` move selected
text up and down in visual mode.
`>` and `<` indent and dedent the selection.


