# homebrew-formulae

```sh
brew tap daugvinasr/formulae
```

The formulae are HEAD-only: they build from the latest commit on the default branch, no tagged releases.

| Formula | Description |
| --- | --- |
| `yabai` | Tiling window manager for macOS (builds from [daugvinasr/yabai](https://github.com/daugvinasr/yabai) master) |
| `now-playing-bar` | Menu bar item showing the currently playing track (builds from [daugvinasr/now-playing-bar](https://github.com/daugvinasr/now-playing-bar) main, bundles [ungive/mediaremote-adapter](https://github.com/ungive/mediaremote-adapter) v0.7.7) |

```sh
brew install --HEAD daugvinasr/formulae/yabai
brew install --HEAD daugvinasr/formulae/now-playing-bar
```

Update to the latest commit:

```sh
brew upgrade --fetch-HEAD daugvinasr/formulae/yabai
brew upgrade --fetch-HEAD daugvinasr/formulae/now-playing-bar
```

Run `now-playing-bar` as a login service:

```sh
brew services start now-playing-bar
```
