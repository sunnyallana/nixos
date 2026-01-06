{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extraPackages = [
      pkgs.nixd
      pkgs.nixfmt
      pkgs.lldb
    ];

    userSettings = {
      agent.always_allow_tool_actions = true;
      notification_panel.button = false;
      outline_panel.dock = "right";
      git_panel.dock = "right";
      diagnostics = {
        include_warnings = true;
        inline.enabled = true;
      };
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      ui_font_size = 16;
      buffer_font_size = 16;
      theme.mode = "dark";
      buffer_font_family = "Maple Mono NF";
      ui_font_family = "Maple UI";
      format_on_save = "on";
      remove_trailing_whitespace_on_save = false;
      tab_size = 4;
      hard_tabs = true;
      lsp.rust-analyzer = {
        initialization_options = {
          cargo.features = "all";
          check.command = "clippy";
        };
        binary.path = "/run/current-system/sw/bin/rust-analyzer"; # TODO: try to remove this
      };
      dap.CodeLLDB.binary = "${pkgs.lldb}/bin/lldb-dap";
      languages.Nix.language_servers = [
        "nixd"
        "!nil"
      ];
    };
  };

  home.sessionVariables = {
    VISUAL = "zeditor --wait";
    EDITOR = "zeditor --wait";
    SUDO_EDITOR = "zeditor --wait";
  };
}
