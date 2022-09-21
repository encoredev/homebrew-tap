class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.7.0"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.0-darwin_amd64.tar.gz"
    sha256 "79395dfff10770a1f0465b38a009319718e5d7cb25b640122cf95a27441c57c1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.0-darwin_arm64.tar.gz"
    sha256 "2d1a992b3fa4904af8e3989b6e490bd374ec73cc52c3cff5afe83f1ada032e02"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.0-linux_amd64.tar.gz"
    sha256 "500b300b61e0a3a74f6d2adab647f0217250f66c412d1b797d142ce0b11c4e6a"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.0-linux_arm64.tar.gz"
    sha256 "258ac39da81ec0e03f3c555d6fea0f7eb045dae7987eb98a0431d947dd934c38"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]

    # Install bash completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
    (bash_completion/"encore").write output

    # Install zsh completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
    (zsh_completion/"_encore").write output

    # Install fish completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
    (fish_completion/"encore.fish").write output
  end

  test do
    system "#{bin}/encore", "check"
  end
end
