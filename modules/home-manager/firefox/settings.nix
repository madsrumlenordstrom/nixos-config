{ config, lib, pkgs, ... }:
{
  # Hardware accelerated video
  "media.ffmpeg.vaapi.enabled" = true;

  # Enable DRM
  "media.eme.enabled" = true;

  # UI stuff
  "browser.download.autohidebuttton" = false;
  "browser.aboutwelcome.enabled" = false;
  "browser.translations.automaticallyPopup" = false;
  "identity.fxaccounts.toolbar.enabled" = false;

  # For CSS and UI customization
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  "devtools.chrome.enabled" = true;
  "devtools.debugger.remote-enabled" = true;
  "browser.uiCustomization.state" = builtins.toJSON {
    currentVersion = 21;
    # Place extensions in the extensions menu
    placements.unified-extensions-area = [
      "sponsorblocker_ajay_app-browser-action"
      "ublock0_raymondhill_net-browser-action"
      "addon_darkreader_org-browser-action"
      "jid1-tsgsxbhncspbwq_jetpack-browser-action"
    ];
  };

  # Fully disable Pocket
  "extensions.pocket.enabled" = false;

  # Enable extensions by default
  "extensions.autoDisableScopes" = 0;

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
}
