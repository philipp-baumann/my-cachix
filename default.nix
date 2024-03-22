# use the cutting edge of R, CRAN and Nixpkgs inputs from this fork and 
# CI update triggered by
# https://github.com/philipp-baumann/nixpkgs/blob/r-daily-source/.github/workflows/r-update.yml
let
 pkgs = import (fetchTarball "https://github.com/philipp-baumann/nixpkgs/archive/refs/heads/r-daily.tar.gz") {};
 rpkgs = builtins.attrValues {
  inherit (pkgs.rPackages) data_table;
};
   system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocales nix ;
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [  rpkgs  system_packages  ];
      
  }
