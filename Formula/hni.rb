class Hni < Formula
  desc "ni-compatible package manager command router with node shim"
  homepage "https://github.com/happytoolin/hni"
  version "0.0.3"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "072701b675cf9e439f784fad4cdd6e5df57dae4db0daf5d32a2aec7ec9c67a18"
    end
    on_intel do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "a764fd2cb624f3f5fb6e7bcb194b6bd1adca9b8acaf73643c593c5265c5940a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "63e7fb1b2bf0de89abb45ce4a893a1bc7decbaec4515db68d833fc1c3d713743"
    end
    on_intel do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "23318febbee3ce687ec83996c8101f7af1f3bfb60e819c80a73abcb2ed5c72b7"
    end
  end

  def install
    bin.install "hni"
    %w[ni nr nlx nru nun nci na np ns].each do |name|
      bin.install_symlink bin/"hni" => name
    end
    generate_completions_from_executable(bin/"hni", "completion", shells: [:bash, :zsh, :fish])
  end

  def caveats
    <<~EOS
      Add the hni init line at the end of your shell config, after nvm/mise/asdf/fnm/volta init:

        zsh:  eval "$(hni init zsh)"
        bash: eval "$(hni init bash)"
        fish: hni init fish | source
        pwsh: Invoke-Expression (& hni init powershell)

      Nushell:

        hni init nushell | save --force ~/.config/nushell/hni.nu
        source ~/.config/nushell/hni.nu
    EOS
  end

  test do
    assert_match "hni", shell_output("#{bin}/hni --version")
    assert_match "usage", shell_output("#{bin}/hni --help").downcase
  end
end
