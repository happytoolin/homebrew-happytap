cask "happymode" do
  version "0.0.2"
  sha256 "065930f77f3be82e47ddf70d19240c0b41c2ad07acd7f935681d9e415c0c0d9c"

  url "https://github.com/happytoolin/happymode/releases/download/v#{version}/happymode-v#{version}.zip"
  name "happymode"
  desc "Menu bar app that switches Light/Dark mode based on sunrise and sunset"
  homepage "https://github.com/happytoolin/happymode"

  app "happymode.app"
end
