{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  updateInterval = 24 * 60 * 60 * 1000; # Updates icons every day
in
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;

        search = {
          default = "DuckDuckGo";
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "channel"; value = "unstable"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://nixos.org/favicon.png";
              inherit updateInterval;
              definedAliases = ["@np"];
            };

            "Den Danske Ordbog" = {
              urls = [
                {
                  template = "https://ordnet.dk/ddo/ordbog";
                  params = [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://ordnet.dk/favicon.ico";
              inherit updateInterval;
              definedAliases = ["@ddo"];
            };

            "GitHub" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    { name = "q"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://github.githubassets.com/favicons/favicon-dark.png";
              inherit updateInterval;
              definedAliases = ["@gh"];
            };

            "Wikipedia" = {
              urls = [
                {
                  template = "https://en.wikipedia.org";
                  params = [
                    { name = "search"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://en.wikipedia.org/static/favicon/wikipedia.ico";
              inherit updateInterval;
              definedAliases = ["@wp"];
            };

            "Wiktionary" = {
              urls = [
                {
                  template = "https://en.wiktionary.org";
                  params = [
                    { name = "search"; value = "{searchTerms}"; }
                  ];
                }
              ];
              iconUpdateURL = "https://en.wiktionary.org/static/favicon/wiktionary/en.ico";
              inherit updateInterval;
              definedAliases = ["@wt"];
            };

            # Does not work how I want it to right now
            "Google Translate" = {
              urls = [
                {
                  template = "https://translate.google.com";
                  params = [
                    { name = "sl"; value = "{searchTerms}"; } # Input language
                    { name = "tl"; value = "{searchTerms}"; } # Output language
                    { name = "text"; value = "{searchTerms}"; } # Text to translate
                  ];
                }
              ];
              iconUpdateURL = "https://ssl.gstatic.com/translate/favicon.ico";
              inherit updateInterval;
              definedAliases = ["@tl"];
            };

            "Google".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
        };
  
        # Extentions must be manually enabled on first launch
        extensions = with config.nur.repos.rycee.firefox-addons; [
          darkreader
          ublock-origin
          sponsorblock
          h264ify
        ];

        settings = {
          # Hardware accelerated video
          "media.ffmpeg.vaapi.enabled" = true;

          # Enable DRM
          "media.eme.enabled" = true;

          # UI stuff
          "browser.download.autohidebuttton" = false;
          "browser.aboutwelcome.enabled" = false;

          # For CSS and UI customization
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "devtools.chrome.enabled" = true;
          "devtools.debugger.remote-enabled" = true;

          # Fully disable Pocket
          "extensions.pocket.enabled" = false;

          # Hardening inspired by arkenfox
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "geo.provider.ms-windows-location" = false;
          "geo.provider.use_corelocation" = false;
          "geo.provider.use_gpsd" = false;
          "geo.provider.use_geoclue" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shopping.experience2023.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.ping-centre.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "network.prefetch-next" = false;
          "network.dns.disablePrefetch" = true;
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false;
          "network.http.speculative-parallel-limit" = 0;
          "browser.places.speculativeConnect.enabled" = false;
          "network.proxy.socks_remote_dns" = true;
          "network.file.disable_unc_paths" = true;
          "network.gio.supported-protocols" = "";
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.suggest.searches" = true;
          "browser.urlbar.trending.featureGate" = false;
          "browser.urlbar.addons.featureGate" = false;
          "browser.urlbar.mdn.featureGate" = false;
          "browser.urlbar.pocket.featureGate" = false;
          "browser.urlbar.weather.featureGate" = false;
          "browser.formfill.enable" = false;
          "browser.search.separatePrivateDefault" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "browser.cache.disk.enable" = true;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.privacy_level" = 2;
          "toolkit.winRegisterApplicationRestart" = false;
          "browser.shell.shortcutFavicons" = false;
          "security.ssl.require_safe_negotiation" = true;
          "security.tls.enable_0rtt_data" = false;
          "security.OCSP.enabled" = 1;
          "security.OCSP.require" = true;
          "security.cert_pinning.enforcement_level" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          "dom.disable_window_move_resize" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          # "devtools.debugger.remote-enabled" = false;
          "permissions.manager.defaultsUrl" = "";
          "webchannel.allowObject.urlWhitelist" = "";
          "network.IDN_show_punycode" = true;
          "pdfjs.disabled" = false;
          "pdfjs.enableScripting" = false;
          "browser.tabs.searchclipboardfor.middleclick" = false;
          "browser.download.useDownloadDir" = false;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          "extensions.enabledScopes" = 5;
          "extensions.postDownloadThirdPartyPrompt" = false;
          "browser.contentblocking.category" = "strict";
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearOnShutdown.cache" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.sessions" = false;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.offlineApps" = false;
          "privacy.cpd.cache" = true;
          "privacy.cpd.formdata" = true;
          "privacy.cpd.history" = true;
          "privacy.cpd.sessions" = true;
          "privacy.cpd.offlineApps" = false;
          "privacy.cpd.cookies" = false;
          "privacy.sanitize.timeSpan" = 0;
          "privacy.resistFingerprinting" = false;
          "privacy.window.maxInnerWidth" = 1600;
          "privacy.window.maxInnerHeight" = 900;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "privacy.resistFingerprinting.letterboxing" = false;
          "browser.display.use_system_colors" = false;
          "widget.non-native-theme.enabled" = true;
          "browser.link.open_newwindow" = 3;
          "browser.link.open_newwindow.restriction" = 0;
          "webgl.disabled" = false;
          "extensions.blocklist.enabled" = true;
          "network.http.referer.spoofSource" = false;
          "security.dialog_enable_delay" = 1000;
          "privacy.firstparty.isolate" = false;
          "extensions.webcompat.enable_shims" = true;
          "security.tls.version.enable-deprecated" = false;
          "extensions.webcompat-reporter.enabled" = false;
          "extensions.quarantinedDomains.enabled" = true;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.urlbar.showSearchTerms.enabled" = false;
          "security.family_safety.mode" = 0;
          "network.dns.skipTRR-when-parental-control-enabled" = false;
        };

        # Theme
        userChrome = ''
@define-color mantle #292c3c;
@define-color crust #232634;

@define-color text #c6d0f5;
@define-color subtext0 #a5adce;
@define-color subtext1 #b5bfe2;

@define-color surface0 #414559;
@define-color surface1 #51576d;
@define-color surface2 #626880;

@define-color overlay0 #737994;
@define-color overlay1 #838ba7;
@define-color overlay2 #949cbb;

@define-color blue #8caaee;
@define-color lavender #babbf1;
@define-color sapphire #85c1dc;
@define-color sky #99d1db;
@define-color teal #81c8be;
@define-color green #a6d189;
@define-color yellow #e5c890;
@define-color peach #ef9f76;
@define-color maroon #ea999c;
@define-color red #e78284;
@define-color mauve #ca9ee6;
@define-color pink #f4b8e4;
@define-color flamingo #eebebe;
@define-color rosewater #f2d5cf;

/* 
┌─┐┬┌┬┐┌─┐┬  ┌─┐
└─┐││││├─┘│  ├┤ 
└─┘┴┴ ┴┴  ┴─┘└─┘
┌─┐┌─┐─┐ ┬      
├┤ │ │┌┴┬┘      
└  └─┘┴ └─

by Miguel Avila

*/

/*
 
┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
│  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
└─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘

*/

:root {
  --sfwindow: #292c3c;
  --sfsecondary: #303446;
  --text: #c6d0f5;
  --overlay0: #737994;
  --tab-min-height: 33px !important;
  --tab-min-width: 60px !important;
  --urlbar-min-height: 25px !important;
  --uc-navbar-height: 33px !important;
}

/* TABS: height */
#tabbrowser-tabs,
#tabbrowser-tabs>#tabbrowser-arrowscrollbox,
.tabbrowser-tabs .tabbrowser-tab {
  min-height: var(--tab-min-height) !important;
  max-height: var(--tab-min-height) !important;
}

/* affecting #nav-bar height */
#search-container,
#urlbar-container {
  padding: calc((var(--uc-navbar-height) - var(--urlbar-min-height)) / 2) 0 !important;
}

/* (optional) the blue little icon when you drag tabs, in case you want extra slim tabs */
/* .tab-drop-indicator {
	/* default icon, height="29" */
/* background: url(chrome://browser/skin/tabbrowser/tab-drag-indicator.svg) no-repeat center; */
/* replacement icon, height="18" */

/* 
┌─┐┌─┐┬  ┌─┐┬─┐┌─┐
│  │ ││  │ │├┬┘└─┐
└─┘└─┘┴─┘└─┘┴└─└─┘ 
*/

#toolbar-menubar {
  color: var(--text) !important;
}

/* Tabs colors  */
#tabbrowser-tabs:not([movingtab])>#tabbrowser-arrowscrollbox>.tabbrowser-tab>.tab-stack>.tab-background[multiselected='true'],
#tabbrowser-tabs:not([movingtab])>#tabbrowser-arrowscrollbox>.tabbrowser-tab>.tab-stack>.tab-background[selected='true'] {
  background-image: none !important;
  background-color: var(--toolbar-bgcolor) !important;
}

#tabbrowser-tab:is([visuallyselected], [multiselected]) {
  background-color: var(--toolbar-bgcolor) !important;
}

.tab-background:is([selected], [multiselected]) {
  background-color: var(--toolbar-bgcolor) !important;
}

/* Inactive tabs color */
#navigator-toolbox {
  background-color: var(--sfwindow) !important;
}

.tab-text {
  color: var(--text) !important;
}

/* Icon color */
.toolbarbutton-icon {
  color: var(--text) !important;
}

.close-icon {
  color: var(--text) !important;
}

.tab-icon-image {
  fill: var(--text) !important;
}

/* Window colors  */
:root {
  --toolbar-color: var(--text) !important;
  --toolbar-bgcolor: var(--sfsecondary) !important;
  --tabs-border-color: var(--sfsecondary) !important;
  --lwt-sidebar-background-color: var(--sfwindow) !important;
  --lwt-toolbar-field-focus: var(--sfsecondary) !important;
}

/* Sidebar color  */
#sidebar-box,
.sidebar-placesTree {
  background-color: var(--sfwindow) !important;
}

/* 

┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐            
 ││├┤ │  ├┤  │ ├┤             
─┴┘└─┘┴─┘└─┘ ┴ └─┘            
┌─┐┌─┐┌┬┐┌─┐┌─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐
│  │ ││││├─┘│ ││││├┤ │││ │ └─┐
└─┘└─┘┴ ┴┴  └─┘┘└┘└─┘┘└┘ ┴ └─┘

*/

/* Tabs elements  */
/*
.tabbrowser-tab:not([pinned]) .tab-icon-image {
  display: none !important;
}
*/

.titlebar-buttonbox-container {
  display: none;
}

.titlebar-spacer {
  display: none !important;
}

#nav-bar:not([tabs-hidden='true']) {
  box-shadow: none;
}

#tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs]) > #tabbrowser-arrowscrollbox > .tabbrowser-tab:nth-child(1 of :not([pinned], [hidden])) {
  margin-inline-start: 0px !important;
}

#tabbrowser-tabs {
  margin-inline-start: 0 !important;
  padding-inline-start: 0 !important;
  border-inline-start: 0 !important;
}

:root {
  --toolbarbutton-border-radius: 0 !important;
  --tab-border-radius: 0 !important;
  --tab-block-margin: 0 !important;
}

.tab-background {
  border-right: 0px solid rgba(0, 0, 0, 0) !important;
  margin-left: 0px !important;
}

.tabbrowser-tab:is([visuallyselected], [multiselected])>.tab-stack>.tab-background {
  box-shadow: none !important;
}

.tabbrowser-tab[last-visible-tab='true'] {
  padding-inline-end: 0 !important;
}

.tabbrowser-tab {
  padding: 0px !important;
}

#tabs-newtab-button {
  padding-left: 0 !important;
}

/* Url Bar  */
#urlbar-input-container {
  color: var(--text) !important;
  background-color: var(--sfsecondary) !important;
  border: 1px solid rgba(0, 0, 0, 0) !important;
}

#urlbar-container {
  margin-left: 0 !important;
}

#urlbar[focused='true']>#urlbar-background {
  box-shadow: none !important;
}

#navigator-toolbox {
  border: none !important;
}

.urlbarView {
  margin-inline: 0px !important;
  width: 100% !important;
  background-color: var(--sfsecondary) !important;
}

.urlbarView-title {
  color: var(--text) !important;
}

.urlbarView-url {
  color: var(--overlay0) !important;
}

.urlbarView-body-inner {
  border: none !important
}

.urlbarView-row-inner {
  border-radius: 0px !important;
}

.urlbarView-row[selected],
.urlbarView-row:hover {
  background-color: var(--button-hover-bgcolor) !important;
}

/* Tool bar  */
.bookmark-item .toolbarbutton-icon {
  display: none;
}

toolbarbutton.bookmark-item:not(.subviewbutton) {
  min-width: 1.6em;
}

#toolbarbutton {
  padding: 0px !important;
}

#nav-bar-customization-target > :is(toolbarbutton, toolbaritem):first-child {
  padding-inline-start: 0px !important;
}

/*
.toolbaritem-combined-buttons {
  display: none;
}
*/

/* Toolbar  */
#PersonalToolbar,
#browser-window-close-button,
#tracking-protection-icon-container,
#urlbar-zoom-button,
#star-button-box,
#pageActionButton,
#pageActionSeparator,
#firefox-view-button,
#save-to-pocket-button,
#alltabs-button,
.tab-secondary-label {
  display: none !important;
}

/* Disable elements  */
#context-navigation,
#context-savepage,
#context-pocket,
#context-sendpagetodevice,
#context-selectall,
#context-viewsource,
#context-inspect-a11y,
#context-sendlinktodevice,
#context-openlinkinusercontext-menu,
#context-bookmarklink,
#context-savelink,
#context-savelinktopocket,
#context-sendlinktodevice,
#context-searchselect,
#context-sendimage,
#context-print-selection {
  display: none !important;
}

#context_bookmarkTab,
#context_moveTabOptions,
#context_sendTabToDevice,
#context_reopenInContainer,
#context_selectAllTabs,
#context_closeTabOptions {
  display: none !important;
}

#statuspanel {
  display: none !important;
}
        '';
      };
    };
  };
}
