# Browser Configuration #

If other browser configuration becomes relevant, it'll appear here.

## Firefox ##

Firefox is my default browser of choice. It should be installed by general other
steps in this repository.

### Configuration ###

Navigate to Firefox preferences.

  * Enable Firefox as the default browser.

  * Turn off `Crtl+Tab cycles through tabs in recently used order`.

  * Set the default search engine to DuckDuckGo. Delete the other search
    engines.

  * Turn off `Ask to save logins and passwords for websites`. That's what
    password managers are for.

### Extensions ###

At a minimum, I should install these extension, as well as my favorite password
manager.

  * [uBlock Origin]

    Most ad blockers do really well on their own, but one thing they don't block by
    default is the YouTube end-of-video ads that overlay videos.

     1. [Install uBlock Origin] as a browser add on.

     1. In your browser, navigate to the `My Filters` tab.

     1. `Import and append` the [`ublock_origin-block_youtube_overlays.txt`] file.

  * [Tree Style Tab]

     1. Under the `Preferences` tab, expand the `Development` dropdown and
        `Import` the [`tree-style-tab_config.json`] file.

  * [Facebook Container]

[Facebook Container]: https://addons.mozilla.org/en-US/firefox/addon/facebook-container/?src=search
[Install uBlock Origin]: https://github.com/gorhill/uBlock/#firefox--firefox-for-android
[Tree Style Tab]: https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/?src=search
[`tree-style-tab_config.json`]: ./tree-style-tab_config.json
[`ublock_origin-block_youtube_overlays.txt`]: ./ublock_origin-block_youtube_overlays.txt
[uBlock Origin]: https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/?src=search
