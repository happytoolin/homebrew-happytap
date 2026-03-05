class Hni < Formula
  desc "ni-compatible package manager command router with node shim"
  homepage "https://github.com/happytoolin/hni"
  version "0.0.8-alpha-2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "400335248e3941503b6316abcfb87307d46beee20048e8ee29db86c0286c8741"
    end
    on_intel do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "25f4be74ff3b650b97df7270ea44bed2cbfadeef5d8d9498e8570f0b44ddc6f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1bcb18d16d83c482ef5c6735da2270496d99fd35aa591a1921d46658768158ce"
    end
    on_intel do
      url "https://github.com/happytoolin/hni/releases/download/v#{version}/hni-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e117a5c227c8597c177261081ee04b1b4a59b9227b72ad159b07de72e3dd7ccd"
    end
  end

  def install
    bin.install "hni"
    %w[ni nr nlx nu nun nci na np ns node].each do |name|
      bin.install_symlink bin/"hni" => name
    end
    generate_completions_from_executable(bin/"hni", "completion", shells: [:bash, :zsh, :fish])
  end

  test do
    assert_match "hni", shell_output("#{bin}/hni --version")
    assert_match "usage", shell_output("#{bin}/hni --help").downcase
  end
end
