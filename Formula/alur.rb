class Alur < Formula
  desc "ni-compatible package manager command router with node shim"
  homepage "https://github.com/happytoolin/alur"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.1/alur-aarch64-apple-darwin.tar.xz"
      sha256 "0e1acd73d112e5fd943edfa8210ed166c83851ad2c5f21e4339a8e5a94447c66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.1/alur-x86_64-apple-darwin.tar.xz"
      sha256 "a1e23dbae682ca13d37aa33e2c397ba26aa6043eac32e1e1290f222852ac58c3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.1/alur-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3f21c32c9313110c3c92deff30b1182d13ed6487276a6043ca7beb29fddc2dae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.1/alur-x86_64-unknown-linux-musl.tar.xz"
      sha256 "56ede7d744c5a1d368a6fe36f0dbc2342265ca71cea244791d92520d01fff231"
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
