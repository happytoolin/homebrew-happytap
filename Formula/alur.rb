class Alur < Formula
  desc "Fast package-manager routing with short commands and an opt-in Node shim"
  homepage "https://alur.happytoolin.com"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.4/alur-aarch64-apple-darwin.tar.xz"
      sha256 "5a42dd3f5c34a0b3d8fb22ff6a684026f26d4aecc81c846f4895fbf032ed6464"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.4/alur-x86_64-apple-darwin.tar.xz"
      sha256 "0c25b10f5f2c90aa4297c0acba13f4f0e2b10945bdaee15556f9063ebe84b1ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.4/alur-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d8a473534f4fbecc2dba6988a60bb837cb273a9b0aa2c7fbfdf41a96cc76cd15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/happytoolin/alur/releases/download/v0.0.4/alur-x86_64-unknown-linux-musl.tar.xz"
      sha256 "093689736656ff9d4100521da3b2ea82a103345e87138c37d554e8935e579021"
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
