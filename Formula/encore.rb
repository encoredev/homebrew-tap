class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.0.0"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.0.0-darwin_amd64.tar.gz"
    sha256 "e57aa7da5e729d1706e1668201d94dd101ed708c1425cac495447dde3a107dfe"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.0.0-darwin_arm64.tar.gz"
    sha256 "6c045e449954762a26bd381459036967dc9ffd5232f0d9fcdbdfb73636829995"
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
