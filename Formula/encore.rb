class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.9.1-test"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-test-darwin_amd64.tar.gz"
    sha256 "sha1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-test-darwin_arm64.tar.gz"
    sha256 "sha12"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-test-linux_amd64.tar.gz"
    sha256 "sha3"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.9.1-test-linux_arm64.tar.gz"
    sha256 "sha4"
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
