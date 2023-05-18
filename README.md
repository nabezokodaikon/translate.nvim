# translate.nvim
A plugin that translates the selected string into any language.

## Install
### dein.vim
```
[[plugins]]
repo = 'nabezokodaikon/translate.nvim'
```

## Usage
1. Select the text to translate.
2. Running `Translate` command.
  * The first argument specifies the language of the selected string. .
  * The second argument specifies the language to translate.
3. The translated text is popup window.
  * Translated text is added to yank.

## Example
```
vim.keymap.set('v', '<Leader>t', '<cmd>Translate ja en<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<Leader>j', '<cmd>Translate en ja<CR>', { noremap = true, silent = true })
```

## Requirements
[Translate Shell](https://github.com/soimort/translate-shell)

## CREDITS
[Translate Shell](https://github.com/soimort/translate-shell)

## Author
[nabezokodaikon](https://github.com/nabezokodaikon)

