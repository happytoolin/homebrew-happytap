class Alur < Formula
  desc "Fast package-manager routing with short commands and an opt-in Node shim"
  homepage "https://alur.happytoolin.com"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.7/alur-aarch64-apple-darwin.tar.xz"
      sha256 "de6778e521111f801eb36c17f8b8b1812a31420f6e7d97613ade18a6c86b206f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.7/alur-x86_64-apple-darwin.tar.xz"
      sha256 "97b3703deab92115f3de74c7721b2fc39094b3bbb9cd574bd9ca187ffe62ae87"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.7/alur-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b9f6e72fbf9f36895d3ea48a7434e73451ca76863c506ae0b9834c4a1aa81f78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.7/alur-x86_64-unknown-linux-musl.tar.xz"
      sha256 "78f4bf9290d80c5e1287a82819fb6b319b94bf750e3cdb4adc66a02134622593"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
      ],
    },
    "aarch64-pc-windows-gnu":             {
      "alur.exe": [
        "ni.exe",
        "nr.exe",
        "nex.exe",
        "nrm.exe",
        "nci.exe",
        "npar.exe",
        "nseq.exe",
      ],
    },
    "aarch64-unknown-linux-gnu":          {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
      ],
    },
    "aarch64-unknown-linux-musl-dynamic": {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
      ],
    },
    "aarch64-unknown-linux-musl-static":  {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
      ],
    },
    "x86_64-apple-darwin":                {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
      ],
    },
    "x86_64-pc-windows-gnu":              {
      "alur.exe": [
        "ni.exe",
        "nr.exe",
        "nex.exe",
        "nrm.exe",
        "nci.exe",
        "npar.exe",
        "nseq.exe",
      ],
    },
    "x86_64-unknown-linux-gnu":           {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
      ],
    },
    "x86_64-unknown-linux-musl-dynamic":  {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
      ],
    },
    "x86_64-unknown-linux-musl-static":   {
      alur: %w[
        ni
        nr
        nex
        nrm
        nci
        npar
        nseq
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
