{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        bufferline = "multiple";
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
        cursorline = true;
        file-picker = {
          hidden = false;
        };
        idle-timeout = 0;
        indent-guides = {
          render = true;
        };
        line-number = "relative";
        lsp = {
          display-messages = true;
        };
        scrolloff = 8;
        shell = [
          "fish"
          "-c"
        ];
        statusline = {
          center = [
            "file-name"
            "file-modification-indicator"
          ];
          left = [
            "mode"
          ];
          mode = {
            insert = "INSERT";
            normal = "NORMAL";
            select = "SELECT";
          };
          right = [
            "spinner"
            "diagnostics"
            "position"
            "spacer"
            "position-percentage"
            "spacer"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
        };
        whitespace = {
          render = {
            newline = "none";
            space = "none";
            tab = "all";
          };
        };
      };
      keys = {
        insert = {
          S-A-down = "copy_selection_on_next_line";
          S-A-up = "copy_selection_on_prev_line";
          down = "no_op";
          end = "no_op";
          home = "no_op";
          left = "no_op";
          pagedown = "no_op";
          pageup = "no_op";
          right = "no_op";
          up = "no_op";
        };
        normal = {
          S-A-down = "copy_selection_on_next_line";
          S-A-up = "copy_selection_on_prev_line";
          S-tab = "unindent";
          X = "extend_line_above";
          down = "no_op";
          end = "no_op";
          home = "no_op";
          left = "no_op";
          pagedown = "no_op";
          pageup = "no_op";
          right = "no_op";
          tab = "indent";
          up = "no_op";
        };
      };
      theme = "base16";
    };

    themes = {
      base16 = with config.colorScheme.palette; {
        "attributes" = "#${base09}";
        "comment" = { fg = "#${base04}"; modifiers = ["italic"]; };
        "constant" = "#${base09}";
        "constant.character.escape" = "#${base0C}";
        "constant.numeric" = "#${base09}";
        "constructor" = "#${base0D}";
        "debug" = "#${base03}";
        "diagnostic" = { modifiers = ["underlined"]; };
        "diff.delta" = "#${base09}";
        "diff.minus" = "#${base08}";
        "diff.plus" = "#${base0B}";
        "error" = "#${base08}";
        "function" = "#${base0D}";
        "hint" = "#${base03}";
        "info" = "#${base0D}";
        "keyword" = "#${base0E}";
        "label" = "#${base0E}";
        "namespace" = "#${base0E}";
        "operator" = "#${base05}";
        "special" = "#${base0D}";
        "string"  = "#${base0B}";
        "type" = "#${base0A}";
        "variable" = "#${base08}";
        "variable.other.member" = "#${base0B}";
        "warning" = "#${base09}";

        "markup.bold" = { fg = "#${base0A}"; modifiers = ["bold"]; };
        "markup.heading" = "#${base0D}";
        "markup.italic" = { fg = "#${base0E}"; modifiers = ["italic"]; };
        "markup.link.text" = "#${base08}";
        "markup.link.url" = { fg = "#${base09}"; modifiers = ["underlined"]; };
        "markup.list" = "#${base08}";
        "markup.quote" = "#${base0C}";
        "markup.raw" = "#${base0B}";
        "markup.strikethrough" = { modifiers = ["crossed_out"]; };

        "diagnostic.hint" = { underline = { style = "curl"; }; };
        "diagnostic.info" = { underline = { style = "curl"; }; };
        "diagnostic.warning" = { underline = { style = "curl"; }; };
        "diagnostic.error" = { underline = { style = "curl"; }; };

        "ui.background" = { bg = "#${base00}"; };
        "ui.bufferline.active" = { fg = "#${base00}"; bg = "#${base03}"; modifiers = ["bold"]; };
        "ui.bufferline" = { fg = "#${base04}"; bg = "#${base00}"; };
        "ui.cursor" = { fg = "#${base00}"; bg = "#${base05}"; };
        "ui.cursor.insert" = { fg = "#${base05}"; modifiers = ["reversed"]; };
        "ui.cursorline.primary" = { fg = "#${base05}"; bg = "#${base01}"; };
        "ui.cursor.match" = { fg = "#${base09}"; };
        "ui.cursor.select" = { fg = "#${base05}"; modifiers = ["reversed"]; };
        "ui.gutter" = { bg = "#${base00}"; };
        "ui.help" = { fg = "#${base05}"; bg = "#${base01}"; };
        "ui.linenr" = { fg = "#${base04}"; bg = "#${base00}"; };
        "ui.linenr.selected" = { fg = "#${base05}"; bg = "#${base00}"; modifiers = ["bold"]; };
        "ui.menu" = { fg = "#${base05}"; bg = "#${base01}"; };
        "ui.menu.scroll" = { fg = "#${base03}"; bg = "#${base01}"; };
        "ui.menu.selected" = { fg = "#${base01}"; bg = "#${base04}"; };
        "ui.popup" = { bg = "#${base01}"; };
        "ui.selection" = { bg = "#${base02}"; };
        "ui.selection.primary" = { bg = "#${base02}"; };
        "ui.statusline" = { fg = "#${base04}"; bg = "#${base01}"; };
        "ui.statusline.inactive" = { bg = "#${base01}"; fg = "#${base03}"; };
        "ui.statusline.insert" = { fg = "#${base00}"; bg = "#${base0B}"; };
        "ui.statusline.normal" = { fg = "#${base00}"; bg = "#${base03}"; };
        "ui.statusline.select" = { fg = "#${base00}"; bg = "#${base0F}"; };
        "ui.text" = "#${base05}";
        "ui.text.focus" = "#${base05}";
        "ui.virtual.indent-guide" = { fg = "#${base02}"; };
        "ui.virtual.inlay-hint" = { fg = "#${base01}"; };
        "ui.virtual.ruler" = { bg = "#${base01}"; };
        "ui.window" = { bg = "#${base01}"; };
      };
    };
  };
}
