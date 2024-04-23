{ config, lib, pkgs, ... }:
let 
  updateInterval = 24 * 60 * 60 * 1000; # Updates icons once per day
in
{
  # Disable stuff I do not use
  "Google".metaData.hidden = true;
  "Bing".metaData.hidden = true;
  "Amazon.com".metaData.hidden = true;
  "Wikipedia (en)".metaData.hidden = true;

  "Nix Packages" = {
    urls = [ {
      template = "https://search.nixos.org/packages";
      params = [
        { name = "type"; value = "packages"; }
        { name = "channel"; value = "unstable"; }
        { name = "query"; value = "{searchTerms}"; }
      ];
    } ];

    iconUpdateURL = "https://nixos.org/favicon.png";
    inherit updateInterval;
    definedAliases = ["@np"];
  };

  "Nix Options" = {
    urls = [ {
      template = "https://search.nixos.org/options";
      params = [
        { name = "type"; value = "packages"; }
        { name = "channel"; value = "unstable"; }
        { name = "query"; value = "{searchTerms}"; }
      ];
    } ];

    iconUpdateURL = "https://nixos.org/favicon.png";
    inherit updateInterval;
    definedAliases = ["@no"];
  };

  "AOTY" = {
    urls = [ {
      template = "https://www.albumoftheyear.org/search";
      params = [ { name = "q"; value = "{searchTerms}"; } ];
    } ];

    iconUpdateURL = "https://cdn.albumoftheyear.org/images/favicon.png";
    inherit updateInterval;
    definedAliases = ["@aoty"];
  };

  "Den Danske Ordbog" = {
    urls = [ {
      template = "https://ordnet.dk/ddo/ordbog";
      params = [ { name = "query"; value = "{searchTerms}"; } ];
    } ];

    iconUpdateURL = "https://ordnet.dk/favicon.ico";
    inherit updateInterval;
    definedAliases = ["@ddo"];
  };

  "GitHub" = {
    urls = [ {
      template = "https://github.com/search";
      params = [ { name = "q"; value = "{searchTerms}"; } ];
    } ];

    iconUpdateURL = "https://github.githubassets.com/favicons/favicon-dark.png";
    inherit updateInterval;
    definedAliases = ["@gh"];
  };

  "Wikipedia" = {
    urls = [ {
      template = "https://en.wikipedia.org";
      params = [ { name = "search"; value = "{searchTerms}"; } ];
    } ];

    iconUpdateURL = "https://en.wikipedia.org/static/favicon/wikipedia.ico";
    inherit updateInterval;
    definedAliases = ["@wp"];
  };

  "Wiktionary" = {
    urls = [ {
      template = "https://en.wiktionary.org";
      params = [ { name = "search"; value = "{searchTerms}"; } ];
    } ];

    iconUpdateURL = "https://en.wiktionary.org/static/favicon/wiktionary/en.ico";
    inherit updateInterval;
    definedAliases = ["@wt"];
  };
}
