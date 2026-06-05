class Alur < Formula
  desc "ni-compatible package manager command router with node shim"
  homepage "https://github.com/happytoolin/alur"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.3/alur-aarch64-apple-darwin.tar.xz"
      sha256 "798eda742b9c119da866028c9e8f6e45bae2e80b9291b8bb5b3150043909f106"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.3/alur-x86_64-apple-darwin.tar.xz"
      sha256 "8c3a5172035fcfa2ff326efa63e0f35d5551ce6a9c70502c344eb1957382c8f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.3/alur-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5c7588c9686b612dfe2dbd32dbf458b81416f71b6c302d6db71d698464072cf2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.3/alur-x86_64-unknown-linux-musl.tar.xz"
      sha256 "26fc81e3507db875d08967b5846ccebc6eb767cfea2f075b7316c993df7688cc"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
    "aarch64-pc-windows-gnu":             {
      "alur.exe": [
        "ni.exe",
        "nr.exe",
        "nlx.exe",
        "nun.exe",
        "nci.exe",
        "np.exe",
        "ns.exe",
      ],
    },
    "aarch64-unknown-linux-gnu":          {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
    "aarch64-unknown-linux-musl-dynamic": {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
    "aarch64-unknown-linux-musl-static":  {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
    "x86_64-apple-darwin":                {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
    "x86_64-pc-windows-gnu":              {
      "alur.exe": [
        "ni.exe",
        "nr.exe",
        "nlx.exe",
        "nun.exe",
        "nci.exe",
        "np.exe",
        "ns.exe",
      ],
    },
    "x86_64-unknown-linux-gnu":           {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
    "x86_64-unknown-linux-musl-dynamic":  {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
    "x86_64-unknown-linux-musl-static":   {
      alur: %w[
        ni
        nr
        nlx
        nun
        nci
        np
        ns
      ],
    },
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "alur" if OS.mac? && Hardware::CPU.arm?
    bin.install "alur" if OS.mac? && Hardware::CPU.intel?
    bin.install "alur" if OS.linux? && Hardware::CPU.arm?
    bin.install "alur" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
