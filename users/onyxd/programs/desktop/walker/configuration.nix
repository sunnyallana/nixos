{ walker, ... }:

{
  imports = [ walker.homeManagerModules.default ];

  programs.walker = {
    enable = true;
    elephant = {
      installService = false; # fixes environment variables when launching apps
      settings.providers.desktopapplications.launch_prefix = "uwsm-app"; # faster than "uwsm app --"
    };
    config.theme = "no-colors";
  };

  xdg.configFile."walker/themes/no-colors/style.css".source = ./style.css;
}
