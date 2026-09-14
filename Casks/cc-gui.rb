cask "cc-gui" do
  version "0.13.0"
  sha256 "496832e1c7fab251e9801192d3ac2c81cebbfee2e7cd28b716318b677b39e11b"

  url "https://github.com/Ed-Barnes937/CC-GUI/releases/download/v#{version}/CC-GUI_#{version}_aarch64.dmg",
      verified: "github.com/Ed-Barnes937/CC-GUI/"
  name "CC-GUI"
  desc "Desktop GUI for claude-commander"
  homepage "https://github.com/Ed-Barnes937/CC-GUI"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  app "CC-GUI.app"

  postflight do
    # Homebrew removed --no-quarantine (5.x) with no replacement; the app is
    # unsigned/un-notarized, so clear the Gatekeeper quarantine flag here.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/CC-GUI.app"]
  end

  caveats <<~EOS
    CC-GUI is not notarized by Apple. The quarantine flag is cleared automatically
    on install. If macOS still reports it as "damaged" or from an unidentified
    developer, clear it manually:

      xattr -dr com.apple.quarantine "#{appdir}/CC-GUI.app"
  EOS
end
