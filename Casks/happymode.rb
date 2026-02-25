cask "happymode" do
  version "0.0.4"
  sha256 "d35bdeec1c0bedd626a837b569a12f79559b4b398babe096ce83269fd3bf6208"

  url "https://github.com/happytoolin/happymode/releases/download/v#{version}/happymode-v#{version}.zip"
  name "happymode"
  desc "Menu bar app that switches Light/Dark mode based on sunrise and sunset"
  homepage "https://github.com/happytoolin/happymode"

  app "happymode.app"

  # Unsigned app: strip quarantine so Homebrew installs run without manual Gatekeeper bypass.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/happymode.app"]
  end

  caveats <<~EOS
    happymode is distributed unsigned (no Apple Developer ID).
    If macOS still blocks launch on your machine, run:
      xattr -dr com.apple.quarantine "/Applications/happymode.app"
  EOS
end
