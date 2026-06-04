class Alur < Formula
  desc "ni-compatible package manager command router with node shim"
  homepage "https://github.com/happytoolin/alur"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.2/alur-aarch64-apple-darwin.tar.xz"
      sha256 "ae954d62ae346d305e039dbfc6e0e6342782f206e7b0f934f14192516467c67a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.2/alur-x86_64-apple-darwin.tar.xz"
      sha256 "cc04f584f4bac5b38d5a25bac0d37142372fc09c19b527ba495f4a6dae0bac4e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.2/alur-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5e6a95a5d61e690f76fa90fa843f23f67c00b2a185c422f699931df96ad8d524"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.2/alur-x86_64-unknown-linux-musl.tar.xz"
      sha256 "76ec832d0afeb9841d1eb8f6871db0b999c222882e1b6ffea36ca3d5fe653d27"
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
