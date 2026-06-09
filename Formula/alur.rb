class Alur < Formula
  desc "Fast package-manager routing with short commands and an opt-in Node shim"
  homepage "https://alur.happytoolin.com"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.5/alur-aarch64-apple-darwin.tar.xz"
      sha256 "d83677d37a94fdb265069756893dd80ce266b73ac05b6dc479902e831dc97760"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.5/alur-x86_64-apple-darwin.tar.xz"
      sha256 "3458f99975afba5723400eabf9079d119f121fb38f443b34bc31ed1a845d2fe4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.5/alur-aarch64-unknown-linux-musl.tar.xz"
      sha256 "63ea03e2e13f06510a36b9f84a7ae1e6bb51d41efa348e13818a3718f3542d9f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.5/alur-x86_64-unknown-linux-musl.tar.xz"
      sha256 "bf2c44d7899b993f4e554dda81cc4cfc9077ce54b9d30ef722d9085479b51450"
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
