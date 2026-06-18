class Alur < Formula
  desc "Fast package-manager routing with short commands and an opt-in Node shim"
  homepage "https://alur.happytoolin.com"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.6/alur-aarch64-apple-darwin.tar.xz"
      sha256 "e5ba2b22fe1bb43b82c0484d346fafdb1a29921d13188a0a5f4e28ffea20e7c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.6/alur-x86_64-apple-darwin.tar.xz"
      sha256 "bcf6933846aa8f88b52a1df526c1f8a2a7f478c5a7294d280d194ae0759a4af7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.6/alur-aarch64-unknown-linux-musl.tar.xz"
      sha256 "4b63ea640f6e63c53d2d4de32350380eb26883d1866f582b6786b6d217300db4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.6/alur-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7f5115c24434f009fe0d6836df1747ad63f0f78f3c4b2cea9db596333eccf297"
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
