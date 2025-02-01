if vim.g.colors_name ~= nil then vim.cmd "highlight clear" end
vim.g.colors_name = "theme"

local mode = vim.api.nvim_get_option_value("background", {})

-- Highlight groups
local hi = vim.api.nvim_set_hl

local black = 0
local red = 1
local green = 2
local yellow = 3
local blue = 4
local magenta = 5
local cyan = 6
local white = 7
local bright_black = 8
local bright_red = 9
local bright_green = 10
local bright_yellow = 11
local bright_blue = 12
local bright_magenta = 13
local bright_cyan = 14
local bright_white = 15

local bg, fg, contrast = black, bright_white, bright_black
if mode == "light" then
  bg, fg, contrast = white, black, bright_white
end

-- ***** Builtin Highlight Groups *****
hi(0, "ColorColumn", { link = "CursorLine" })
hi(0, "Conceal", { bold = true })
hi(0, "CurSearch", { ctermbg = bright_yellow })
hi(0, "Cursor", { ctermfg = bg, ctermbg = fg })
hi(0, "lCursor", { link = "Cursor" })
hi(0, "CursorIM", { link = "Cursor" })
hi(0, "CursorColumn", { link = "CursorLine" })
hi(0, "CursorLine", { ctermbg = contrast })
hi(0, "Directory", { ctermfg = blue })
hi(0, "DiffAdd", { ctermbg = green, ctermfg = fg, bold = true })
hi(0, "DiffChange", { ctermbg = blue, ctermfg = fg, bold = true })
hi(0, "DiffDelete", { ctermbg = red, ctermfg = fg, bold = true })
hi(0, "DiffText", { ctermbg = bright_blue, ctermfg = fg, bold = true })
hi(0, "EndOfBuffer", { link = "NonText" })
hi(0, "TermCursor", { link = "Cursor" })
hi(0, "TermCursorNC", { link = "TermCursor" })
hi(0, "ErrorMsg", { ctermfg = bright_red })
hi(0, "WinSeparator", {})
hi(0, "Folded", {})
hi(0, "FoldColumn", { link = "LineNr" })
hi(0, "SignColumn", { link = "LineNr" })
hi(0, "IncSearch", { link = "Search" })
hi(0, "Substitute", { link = "Search" })
hi(0, "LineNr", { ctermfg = contrast })
hi(0, "LineNrAbove", { link = "LineNr" })
hi(0, "LineNrBelow", { link = "LineNr" })
hi(0, "CursorLineNr", { link = "CursorLine" })
hi(0, "CursorLineFold", { link = "CursorLine" })
hi(0, "CursorLineSign", { link = "CursorLine" })
hi(0, "MatchParen", { ctermbg = contrast, bold = true, underline = true })
hi(0, "ModeMsg", { bold = true })
hi(0, "MsgArea", {})
hi(0, "MsgSeparator", {})
hi(0, "MoreMsg", { ctermfg = green })
hi(0, "NonText", { ctermfg = contrast })
hi(0, "Normal", { ctermfg = fg, ctermbg = bg })
hi(0, "NormalFloat", { ctermbg = bg })
-- TODO: find color
-- hi(0, "FloatBorder", {})
-- hi(0, "FloatTitle", {})
-- hi(0, "FloatFooter", {})
-- **********
hi(0, "NormalNC", { link = "Normal" })
hi(0, "Pmenu", { ctermbg = contrast }) -- TODO: find better color (contrast does not work well for some colors)
hi(0, "PmenuSel", { reverse = true })
hi(0, "PmenuKind", { link = "Pmenu" })
hi(0, "PmenuKindSel", { link = "PmenuSel" })
hi(0, "PmenuExtra", { link = "Pmenu" })
hi(0, "PmenuExtraSel", { link = "PmenuSel" })
hi(0, "PmenuSbar", { link = "Pmenu" })
hi(0, "PmenuThumb", { link = "PmenuSel" })
hi(0, "Question", { ctermfg = green })
hi(0, "QuickFixLine", { link = "Search" })
hi(0, "Search", { ctermbg = contrast })
hi(0, "SnippetTabstop", {})
hi(0, "SpecialKey", { link = "NonText" })
-- TODO: fix undercurl and sp color
-- hi(0, "SpellBad", { undercurl = true })
-- hi(0, "SpellCap", { undercurl = true })
-- hi(0, "SpellLocal", { undercurl = true })
-- hi(0, "SpellRare", { undercurl = true })
-- **********
hi(0, "StatusLine", { ctermfg = fg, ctermbg = contrast })
hi(0, "StatusLineNC", {})
hi(0, "TabLine", { link = "StatusLine" })
hi(0, "TabLineFill", { link = "TabLine" })
hi(0, "TabLineSel", { reverse = true })
hi(0, "Title", { ctermfg = magenta, bold = true })
hi(0, "Visual", { reverse = true })
hi(0, "VisualNOS", { link = "Visual" })
hi(0, "WarningMsg", { ctermfg = bright_yellow })
hi(0, "Whitespace", { link = "NonText" })
hi(0, "WildMenu", { link = "Pmenu" })
hi(0, "WinBar", { link = "StatusLine" })
hi(0, "WinBarNC", { link = "StatusLineNC" })

hi(0, "Comment", { ctermfg = green, italic = true })

hi(0, "Constant", { ctermfg = magenta })
hi(0, "String", { link = "Constant" })
hi(0, "Character", { link = "Constant" })
hi(0, "Number", { ctermfg = yellow })
hi(0, "Boolean", { link = "Number" })
hi(0, "Float", { link = "Number" })

hi(0, "Identifier", { ctermfg = blue })
hi(0, "Function", { link = "Identifier" })

hi(0, "Statement", { ctermfg = red, bold = true })
hi(0, "Conditional", { link = "Statement" })
hi(0, "Repeat", { link = "Statement" })
hi(0, "Label", { link = "Statement" })
hi(0, "Operator", { link = "Statement" })
hi(0, "Keyword", { link = "Statement" })
hi(0, "Exception", { link = "Statement" })

hi(0, "PreProc", { ctermfg = yellow })
hi(0, "Include", { link = "PreProc" })
hi(0, "Define", { link = "PreProc" })
hi(0, "Macro", { link = "PreProc" })
hi(0, "PreCondit", { link = "PreProc" })

hi(0, "Type", { ctermfg = cyan, bold = true })
hi(0, "StorageClass", { link = "Type" })
hi(0, "Structure", { link = "Type" })
hi(0, "Typedef", { link = "Type" })

hi(0, "Special", { ctermfg = cyan })
hi(0, "SpecialChar", { link = "Special" })
hi(0, "Tag", { link = "Special" })
hi(0, "Delimiter", { link = "Special" })
hi(0, "SpecialComment", { link = "Special" })
hi(0, "Debug", { link = "Special" })

hi(0, "Underlined", { underline = true })
hi(0, "Ignore", { link = "Normal" })
hi(0, "Error", { ctermfg = bg, ctermbg = bright_red })
hi(0, "Todo", { ctermfg = bg, ctermbg = bright_yellow })

hi(0, "Added", { link = "DiffAdd" })
hi(0, "Changed", { link = "DiffChange" })
hi(0, "Removed", { link = "DiffDelete" })

-- ***** Diagnostic Highlight Groups *****
hi(0, "DiagnosticError", { ctermfg = bright_red })
hi(0, "DiagnosticWarn", { ctermfg = bright_yellow })
hi(0, "DiagnosticInfo", { ctermfg = bright_blue })
hi(0, "DiagnosticHint", { ctermfg = bright_cyan })
hi(0, "DiagnosticOk", { ctermfg = bright_green })
hi(0, "DiagnosticVirtualTextError", { link = "DiagnosticError" })
hi(0, "DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
hi(0, "DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
hi(0, "DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
hi(0, "DiagnosticVirtualTextOk", { link = "DiagnosticOk" })
hi(0, "DiagnosticUnderlineError", { ctermfg = bright_red, underline = true })
hi(0, "DiagnosticUnderlineWarn", { ctermfg = bright_yellow, underline = true })
hi(0, "DiagnosticUnderlineInfo", { ctermfg = bright_blue, underline = true })
hi(0, "DiagnosticUnderlineHint", { ctermfg = bright_cyan, underline = true })
hi(0, "DiagnosticUnderlineOk", { ctermfg = bright_green, underline = true })
hi(0, "DiagnosticFloatingError", { link = "DiagnosticError" })
hi(0, "DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
hi(0, "DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
hi(0, "DiagnosticFloatingHint", { link = "DiagnosticHint" })
hi(0, "DiagnosticFloatingOk", { link = "DiagnosticOk" })
hi(0, "DiagnosticSignError", { link = "DiagnosticError" })
hi(0, "DiagnosticSignWarn", { link = "DiagnosticWarn" })
hi(0, "DiagnosticSignInfo", { link = "DiagnosticInfo" })
hi(0, "DiagnosticSignHint", { link = "DiagnosticHint" })
hi(0, "DiagnosticSignOk", { link = "DiagnosticOk" })
hi(0, "DiagnosticDeprecated", { strikethrough = true })
hi(0, "DiagnosticUnnecessary", { link = "NonText" })

-- ***** Treesitter Highlight Groups *****
hi(0, "@variable", { link = "Identifier" })
-- hi(0, "@variable.builtin", {})
-- hi(0, "@variable.parameter", {})
-- hi(0, "@variable.parameter.builtin", {})
-- hi(0, "@variable.member", {})

hi(0, "@constant", { link = "Constant" })
-- hi(0, "@constant.builtin", {})
-- hi(0, "@constant.macro", {})

-- hi(0, "@module", {})
-- hi(0, "@module.builtin", {})

-- hi(0, "@label", {})

hi(0, "@string", { link = "String" })
-- hi(0, "@string.documentation", {})
-- hi(0, "@string.regexp", {})
-- hi(0, "@string.escape", {})
-- hi(0, "@string.special", {})
-- hi(0, "@string.special.symbol", {})
-- hi(0, "@string.special.path", {})
-- hi(0, "@string.special.url", {})
hi(0, "@character", { link = "Character" })
-- hi(0, "@character.special", {})

hi(0, "@boolean", { link = "Boolean" })
hi(0, "@number", { link = "Number" })
hi(0, "@number.float", { link = "Float" })

hi(0, "@type", { link = "Type" })
-- hi(0, "@type.builtin", {})
hi(0, "@type.definition", { link = "Typedef" })

-- hi(0, "@attribute", {})
-- hi(0, "@attribute.builtin", {})

-- hi(0, "@property", {})

hi(0, "@function", { link = "Function" })
-- hi(0, "@function.builtin", {})
-- hi(0, "@function.call", {})
-- hi(0, "@function.macro", {})
-- hi(0, "@function.method", {})
-- hi(0, "@function.method.call", {})

-- hi(0, "@constructor", {})

hi(0, "@operator", { link = "Operator" })

hi(0, "@keyword", { link = "Keyword" })
-- hi(0, "@keyword.coroutine", {})
-- hi(0, "@keyword.function", {})
-- hi(0, "@keyword.operator", {})
-- hi(0, "@keyword.import", {})
-- hi(0, "@keyword.type", {})
-- hi(0, "@keyword.modifier", {})
-- hi(0, "@keyword.repeat", {})
-- hi(0, "@keyword.return", {})
-- hi(0, "@keyword.debug", {})
-- hi(0, "@keyword.exception", {})
-- hi(0, "@keyword.conditional", {})
-- hi(0, "@keyword.conditional.ternary", {})
-- hi(0, "@keyword.directive", {})
-- hi(0, "@keyword.directive.define", {})

hi(0, "@punctuation.delimiter", { link = "Delimiter" })
hi(0, "@punctuation.bracket", { link = "Special" })
hi(0, "@punctuation.special", { link = "Special" })

hi(0, "@comment", { link = "Comment" })
-- hi(0, "@comment.documentation", {})
-- hi(0, "@comment.error", {})
-- hi(0, "@comment.warning", {})
-- hi(0, "@comment.todo", {})
-- hi(0, "@comment.note", {})

-- hi(0, "@markup.strong", {})
-- hi(0, "@markup.italic", {})
-- hi(0, "@markup.strikethrough", {})
-- hi(0, "@markup.underline", {})
-- hi(0, "@markup.heading", {})
-- hi(0, "@markup.heading.1", {})
-- hi(0, "@markup.heading.2", {})
-- hi(0, "@markup.heading.3", {})
-- hi(0, "@markup.heading.4", {})
-- hi(0, "@markup.heading.5", {})
-- hi(0, "@markup.heading.6", {})
-- hi(0, "@markup.quote", {})
-- hi(0, "@markup.math", {})
-- hi(0, "@markup.link", {})
-- hi(0, "@markup.link.label", {})
-- hi(0, "@markup.link.url", {})
-- hi(0, "@markup.raw", {})
-- hi(0, "@markup.raw.block", {})
-- hi(0, "@markup.list", {})
-- hi(0, "@markup.list.checked", {})
-- hi(0, "@markup.list.unchecked", {})

hi(0, "@diff.plus", { link = "DiffAdd" })
hi(0, "@diff.minus", { link = "DiffDelete" })
hi(0, "@diff.delta", { link = "DiffChange" })

hi(0, "@tag", { link = "Tag" })
-- hi(0, "@tag.builtin", {})
-- hi(0, "@tag.attribute", {})
hi(0, "@tag.delimiter", { link = "Delimiter" })

-- ***** LSP Highlight Groups *****
-- hi(0, "LspReferenceText", {})
-- hi(0, "LspReferenceRead", {})
-- hi(0, "LspReferenceWrite", {})
-- hi(0, "LspInlayHint", {})
-- hi(0, "LspCodeLens", {})
-- hi(0, "LspCodeLensSeparator", {})
-- hi(0, "LspSignatureActiveParameter", {})
--
-- hi(0, "@lsp.type.class", {})
-- hi(0, "@lsp.type.comment", {})
-- hi(0, "@lsp.type.decorator", {})
-- hi(0, "@lsp.type.enum", {})
-- hi(0, "@lsp.type.enumMember", {})
-- hi(0, "@lsp.type.event", {})
-- hi(0, "@lsp.type.function", {})
-- hi(0, "@lsp.type.interface", {})
-- hi(0, "@lsp.type.keyword", {})
-- hi(0, "@lsp.type.macro", {})
-- hi(0, "@lsp.type.method", {})
-- hi(0, "@lsp.type.modifier", {})
-- hi(0, "@lsp.type.namespace", {})
-- hi(0, "@lsp.type.number", {})
-- hi(0, "@lsp.type.operator", {})
-- hi(0, "@lsp.type.parameter", {})
-- hi(0, "@lsp.type.property", {})
-- hi(0, "@lsp.type.regexp", {})
-- hi(0, "@lsp.type.string", {})
-- hi(0, "@lsp.type.struct", {})
-- hi(0, "@lsp.type.type", {})
-- hi(0, "@lsp.type.typeParameter", {})
-- hi(0, "@lsp.type.variable", {})
--
-- hi(0, "@lsp.mod.abstract", {})
-- hi(0, "@lsp.mod.async", {})
-- hi(0, "@lsp.mod.declaration", {})
-- hi(0, "@lsp.mod.defaultLibrary", {})
-- hi(0, "@lsp.mod.definition", {})
-- hi(0, "@lsp.mod.deprecated", {})
-- hi(0, "@lsp.mod.documentation", {})
-- hi(0, "@lsp.mod.modification", {})
-- hi(0, "@lsp.mod.readonly", {})
-- hi(0, "@lsp.mod.static", {})
