# homebrew-formulae

```sh
brew tap daugvinasr/formulae
```

Both formulae are HEAD-only: they build from the latest commit on the default branch, no tagged releases.

| Formula | Description |
| --- | --- |
| `space-number` | Menu bar space indicator for yabai (builds from [daugvinasr/space-number](https://github.com/daugvinasr/space-number) main) |
| `yabai` | Tiling window manager for macOS (builds from [daugvinasr/yabai](https://github.com/daugvinasr/yabai) master) |

```sh
brew install --HEAD daugvinasr/formulae/space-number

brew install --HEAD daugvinasr/formulae/yabai
```

Update to the latest commit:

```sh
brew upgrade --fetch-HEAD daugvinasr/formulae/space-number
brew upgrade --fetch-HEAD daugvinasr/formulae/yabai
```
