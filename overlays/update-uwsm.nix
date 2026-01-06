final: prev: {
  uwsm = prev.uwsm.overrideAttrs (old: rec {
    version = "0.26.0";

    src = prev.fetchFromGitHub {
      owner = "Vladimir-csp";
      repo = "uwsm";
      tag = "v${version}";
      hash = "sha256-Com3Q6/xPM6fDW0rNP8QQpn8A/bUSC7cLs3xwRiTGDs=";
    };
  });
}
