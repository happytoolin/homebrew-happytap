class Hni < Formula
  desc "ni-compatible package manager command router with node shim"
  homepage "https://github.com/happytoolin/hni"
  version "0.0.1-alpha-2"
  license "GPL-3.0"

  on_macos do
    on_arm do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "96213ce7c4d0a3012741b695ff0f8815018dd25e371172b8797fb53e035f40fe"
    end
    on_intel do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "09245da52a4ffbb5711c657477ef1b474e8cb77de9a05ca371aeae7dc067a0ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cd242a9348e2174edf8b19f9f0a594c7c8e429841cd77c88b1c2548630fae8fa"
    end
    on_intel do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7bda318f3c601af97784a2641525c04902e51af0cb63979086cb4de22feceddd"
    end
  end

  def install
    bin.install "hni"
    %w[ni nr nlx nu nun nci na np ns].each do |name|
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
