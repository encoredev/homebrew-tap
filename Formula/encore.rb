class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.3.1"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.3.1-darwin_amd64.tar.gz"
    sha256 "b6ff0e218d497d88f8b93cb3f7f6bc8067d0538072a219d2fa1c643cbf2fcc7a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.3.1-darwin_arm64.tar.gz"
    sha256 "98aa461ce20fae8b061d4a8a6c54797f1f091ae0499197b924b48060d484cc5b"
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
