![screenshot](https://ccd0.github.io/4chan-x/img/screenshot.png)
# 4chan XK
4chan XK is a script forked from 4chan X that adds various features to anonymous imageboards, forked for circlerjerks. It was originally developed for 4chan but has no affiliation with it.

It was previously developed by [ccd0](https://github.com/ccd0/4chan-x), [aeosynth](https://github.com/aeosynth/4chan-x), [Mayhem](https://github.com/MayhemYDG/4chan-x), [ihavenoface](https://github.com/ihavenoface/4chan-x), [Zixaphir](https://github.com/zixaphir/appchan-x), [Seaweed](https://github.com/seaweedchan/4chan-x), and [Spittie](https://github.com/Spittie/4chan-x), with contributions from many others.

If you're looking for a maintained fork of OneeChan (a style script used in addition to 4chan XK), try
https://github.com/KevinParnell/OneeChan.

## Please note
**Uninstalling**: 4chan XK disables the native extension, so if you uninstall 4chan XK, you'll need to re-enable it. To do this, click the `[Settings]` link in the top right corner, uncheck "`Disable the native extension`" in the panel that appears, and click the "`Save Settings`" button. If you don't see a "`Save Settings`" button, it may be being hidden by your ad blocker.

**Private browsing**: By default, 4chan XK remembers your last read post in a thread and which posts were made by you, even if you are in private browsing / incognito mode. If you want to turn this off, uncheck the `Remember Last Read Post` and `Remember Your Posts` options in the settings panel. You can clear all 4chan browsing history saved by 4chan XK by resetting your settings.

Use of the "Link Title" feature to fetch titles of Youtube links is subject to Youtube's [Terms of Service](https://www.youtube.com/t/terms) and [Privacy Policy](http://www.google.com/policies/privacy). For more details on what information is sent to Youtube and other sites, and how to turn it off if you don't want the feature, see 4chan XK's [privacy documentation](https://github.com/ErinSteph/4chan-xk/wiki/Privacy).

## Install

### Firefox
Install [Violentmonkey](https://addons.mozilla.org/en-US/firefox/addon/violentmonkey/), [Tampermonkey](https://addons.mozilla.org/en-US/firefox/addon/tampermonkey/), or [Greasemonkey](https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/) (issues since v4: [#2526](https://github.com/greasemonkey/greasemonkey/issues/2526), [#2576](https://github.com/greasemonkey/greasemonkey/issues/2574)), then **[click here to install 4chan XK](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js)**.

Ports of Greasemonkey are available for [SeaMonkey](https://sourceforge.net/projects/gmport/) and [Pale Moon](https://github.com/janekptacijarabaci/greasemonkey/releases/latest).

### Chromium
**Userscript**: Install [Violentmonkey](https://chrome.google.com/webstore/detail/violent-monkey/jinjaccalgkegednnccohejagnlnfdag) or [Tampermonkey](https://tampermonkey.net/), then **[click here to install 4chan XK](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true)**.

**Chrome extension**: 4chan XK is also available as a standalone Chrome extension. The Chrome extension has the additional feature of being able to sync your settings and data with other devices via Chrome Sync. But there is an issue when the script updates: Whenever the Chrome extension is updated, until you hard refresh (F5) the tab, 4chan XK is unable to save any data (such as posts marked as yours and settings changes). The userscript version above does not have this problem when 4chan XK updates, only when Violentmonkey / Tampermonkey is updated. To install as a Chrome extension:

- **Chromium**, **Vivaldi**: **[Download 4chan XK](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.crx)**, then open `chrome://extensions` and drag the downloaded file onto the page.**.
- **Opera**: **[Click to install 4chan XK](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.crx)**, then follow the prompts to activate it in your extension manager.
- **Chrome**: Install 4chan XK from the **[Chrome store](https://chrome.google.com/webstore/detail/ohnjgmpcibpbafdlkimncjhflgedgpam)**.

Note: This version of 4chan XK does not work with Opera 12. If you need Opera 12 support, try [loadletter's fork](https://github.com/loadletter/4chan-x) instead.

### Safari
Install the [Userscripts](https://itunes.apple.com/us/app/userscripts/id1463298887) extension. Enable it by pressing `⌘,`, navigating to the extensions pane and checking `Userscripts` checkbox. Now open the Userscripts editor by clicking on the `</>` button in the taskbar. Then click on the `+` button and select the `New Javascript` option. Replace the default text with the contents of the 4chan XK **[script](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true)**. Finally save it by pressing `⌘s`.

### WebKitGTK+ / QtWebKit / QtWebEngine
Several minimal browsers have support for userscripts and can run 4chan XK. Due to the lack of the cross-site GM_* API, and lack of support for userscripts in iframes, not all features will work. You may experience crashes when repeatedly solving the default image-based captchas. You can avoid this problem by enabling `Use Recaptcha v1` in your settings.

- **dwb**: Install the userscripts extension, then save the [script](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true) to the `$XDG_CONFIG_HOME/dwb/greasemonkey` or `$HOME/.config/dwb/greasemonkey` directory (creating it if necessary):

  ```
  dwbem -N -i userscripts
  wget -P ${XDG_CONFIG_HOME:-$HOME/.config}/dwb/greasemonkey https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true
  ```

- **Midori**: Enable `User addons` in your preferences, under the Extensions tab. In the Privacy tab, check `Enable HTML5 local storage support`. Optionally, if you want 4chan XK to be able to open new tabs when you start or reply to a thread, you will need to check `Allow scripts to open popups` under the Behavior tab. Then click the link to the [script](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true) to install it.

- **Luakit**: Navigate to the [script](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true), then type the command `:usi` to install it.

- **uzbl**: Install the script from https://github.com/singpolyma/singpolyma/blob/master/uzbl/data/scripts/userscript.sh, enable it in your config file, and then save [4chan XK](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true) to `$XDG_DATA_HOME/uzbl/userscripts` (or `$HOME/.local/share/uzbl/userscripts`). The commands below assume you have run uzbl at least once to create its config file.

  ```
  wget -P "${XDG_DATA_HOME:-$HOME/.local/share}/uzbl/scripts" https://raw.githubusercontent.com/singpolyma/singpolyma/master/uzbl/data/scripts/userscript.sh
  chmod +x "${XDG_DATA_HOME:-$HOME/.local/share}/uzbl/scripts/userscript.sh"
  echo '@on_event LOAD_COMMIT spawn @scripts_dir/userscript.sh document-start' >> "${XDG_CONFIG_HOME:-$HOME/.config}/uzbl/config"
  echo '@on_event LOAD_FINISH spawn @scripts_dir/userscript.sh document-end'   >> "${XDG_CONFIG_HOME:-$HOME/.config}/uzbl/config"
  wget -P "${XDG_DATA_HOME:-$HOME/.local/share}/uzbl/userscripts" https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true
  ```

- **qutebrowser**: Save the [script](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true) to the `$XDG_DATA_HOME/qutebrowser/greasemonkey` or `$HOME/.local/share/qutebrowser/greasemonkey` directory:

  ```
  wget -P ${XDG_DATA_HOME:-$HOME/.local/share}/qutebrowser/greasemonkey https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true
  ```

### MS Edge
Install [Tampermonkey](https://www.microsoft.com/en-us/store/p/tampermonkey/9nblggh5162s), then **[click here to install 4chan XK](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK.user.js?raw=true)**.

### Other browsers
4chan XK can be used in some browsers that do not support userscripts using [a local proxy](https://github.com/ccd0/4chan-x-proxy). Not all features will work.

## Beta version
New features and non-urgent bugfixes are released on the beta channel for further testing before they are moved the stable version. Please [report](https://github.com/ErinSteph/4chan-xk/issues?q=is%3Aopen+sort%3Aupdated-desc) any issues you find, and be sure to mention which version you're using. You should back up your settings regularly to prevent them from being lost due to bugs.

To install the **beta** version and get updates whenever there's a new **beta** version:
- [Install userscript](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK-beta.user.js) (use with Greasemonkey / Violentmonkey / Tampermonkey / JS Blocker / etc.)
- [Download Chrome extension](https://github.com/ErinSteph/4chan-xk/blob/master/builds/4chan-XK-beta.crx) (download and drag to `chrome://extensions`)

To install the current **beta** version but get updates from the **stable** channel (for example, if just you want a particular recent feature):
- [Install userscript](https://github.com/ErinSteph/4chan-xk/raw/beta/builds/4chan-X.user.js)
- [Download Chrome extension](https://github.com/ErinSteph/4chan-xk/raw/beta/builds/4chan-X.crx)

## Troubleshooting
If you encounter a bug, try the steps [here](https://github.com/ErinSteph/4chan-xk/blob/master/CONTRIBUTING.md#reporting-bugs), then report it to the [issue tracker](https://github.com/ErinSteph/4chan-xk/issues?q=is%3Aopen+sort%3Aupdated-desc). If the bug seems to be caused by a script update, you can install a old version from the [changelog](https://github.com/ErinSteph/4chan-xk/blob/master/CHANGELOG.md).

## More information
- [Changelog](https://github.com/ErinSteph/4chan-xk/blob/master/CHANGELOG.md)
- [Frequently Asked Questions](https://github.com/ErinSteph/4chan-xk/wiki/Frequently-Asked-Questions)
- [Report Bugs](https://github.com/ErinSteph/4chan-xk/issues)
- [Contributing](https://github.com/ErinSteph/4chan-xk/blob/master/CONTRIBUTING.md)
