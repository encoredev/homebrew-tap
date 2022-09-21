class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.7.1"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.1-darwin_amd64.tar.gz"
    sha256 "f25e41c463361452831662dd50bc490b48d06c68827dbf38b57aa37523a95ed0"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.1-darwin_arm64.tar.gz"
    sha256 "45bdead2e237f28d0cf1d291ffc86830c9ce06559a2157e8e1892ff8830db17f"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.1-linux_amd64.tar.gz"
    sha256 "36a038157de973ec5478c6780b6a32593d4644c78b6f1ee2f24ef6f6158b5500"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.7.1-linux_arm64.tar.gz"
    sha256 "ff0ba0c2455b4dcebc50a8447a5e172af58c2552f75e224923df410cd84a0ddf"
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
