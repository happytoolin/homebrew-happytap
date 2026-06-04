# happytap

Homebrew tap for HappyToolin macOS apps.

## Install

```bash
brew tap happytoolin/happytap
brew install alur
brew install --cask happymode
```

## Maintenance

- `Casks/happymode.rb` includes a bootstrap `:latest` cask that tracks `releases/latest`.
- Optional: the `happytoolin/happymode` release workflow can overwrite this with pinned version + SHA updates when `TAP_GITHUB_TOKEN` is configured.
