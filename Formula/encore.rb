class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.5.1"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.5.1-darwin_amd64.tar.gz"
    sha256 "59768cf04646dc6a2f91857a3e62da036452123a4d81166bc3aeeb9108b3fb3e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.5.1-darwin_arm64.tar.gz"
    sha256 "38e9cca0d3268791f76843882d36c4a19a826eec9e3a5a4f51cf824aad9d0336"
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
