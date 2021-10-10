" node plugins


" python3 plugins
call remote#host#RegisterPlugin('python3', 'C:/Users/Aliaksandr/AppData/nvim/plugged/LanguageClient-neovim/rplugin/python3/LanguageClient', [
      \ {'sync': v:true, 'name': 'LanguageClient_alive', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_call', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_completionItem/resolve', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_completionManager_refresh', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_exit', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_FZFSinkTextDocumentCodeAction', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_FZFSinkTextDocumentDocumentSymbol', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_FZFSinkTextDocumentReferences', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_FZFSinkWorkspaceSymbol', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': 'LanguageClient_getState', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'BufReadPost', 'type': 'autocmd', 'opts': {'pattern': '*', 'eval': '[{''buftype'': &buftype, ''languageId'': &filetype, ''filename'': expand(''%:p'')}]'}},
      \ {'sync': v:false, 'name': 'BufWritePost', 'type': 'autocmd', 'opts': {'pattern': '*', 'eval': '[{''languageId'': &filetype, ''filename'': expand(''%:p'')}]'}},
      \ {'sync': v:false, 'name': 'CursorMoved', 'type': 'autocmd', 'opts': {'pattern': '*', 'eval': '[{''buftype'': &buftype, ''line'': line(''.'')}]'}},
      \ {'sync': v:false, 'name': 'TextChanged', 'type': 'autocmd', 'opts': {'pattern': '*', 'eval': '[{''filename'': expand(''%:p''), ''buftype'': &buftype}]'}},
      \ {'sync': v:false, 'name': 'TextChangedI', 'type': 'autocmd', 'opts': {'pattern': '*', 'eval': '[{''filename'': expand(''%:p''), ''buftype'': &buftype}]'}},
      \ {'sync': v:false, 'name': 'LanguageClient_initialize', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_notify', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_registerServerCommands', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_rustDocument_implementations', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_setLoggingLevel', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClientStart', 'type': 'command', 'opts': {'nargs': '*', 'range': ''}},
      \ {'sync': v:false, 'name': 'LanguageClientStop', 'type': 'command', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_codeAction', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': 'LanguageClient_textDocument_completion', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_completionOmnifunc', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_definition', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'textDocument_didChange', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_didClose', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'textDocument_didSave', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_documentSymbol', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_formatting', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_hover', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': 'LanguageClient_textDocument_hoverSync', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_rangeFormatting', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_references', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_rename', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_textDocument_signatureHelp', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_workspace_didChangeConfiguration', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_workspace_executeCommand', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'LanguageClient_workspace_symbol', 'type': 'function', 'opts': {}},
     \ ])
call remote#host#RegisterPlugin('python3', 'C:/Users/Aliaksandr/AppData/nvim/plugged/deoplete.nvim/rplugin/python3/deoplete', [
      \ {'sync': v:false, 'name': '_deoplete_init', 'type': 'function', 'opts': {}},
     \ ])


" ruby plugins


" python plugins


